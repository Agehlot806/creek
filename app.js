const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const helmet = require("helmet");
const mongoose = require('mongoose');
const userRouter = require('./routes1/decentro.routes')
let acl = require('acl');
var timeout = require('connect-timeout');
require('./config/mysql.config')
require('dotenv/config'); // Environment variables

const rdb = require('./bootstrap/rdb'); // mysql connection
//const nosql = require('./bootstrap/nosql'); // mongodb  connection

const nosql =  mongoose.connect(process.env.DB_URL, { useCreateIndex: true,useNewUrlParser: true ,useUnifiedTopology: true});
      // to handle collection.ensureIndex is deprecated
//console.log(nosql);
// acl
mongoose.connection.on('connected', function(error){
    if (error) throw error;   
    //you must set up the db when mongoose is connected or your will not be able to write any document into it
    const app = express();
    app.use(cookieParser());
    app.use("/user",userRouter)
    app.use(require('./bootstrap/session'));
   
    app.use(timeout('20s'));
    //console.log(mongoose.connection.db);
    acl= new acl(new acl.mongodbBackend(mongoose.connection.db,"acl_"));
   // acl= new acl(new acl.mongodbBackend({ db:mongoose.connection.db, prefix : "acl_"}));
    console.log("Mongo connected");
     const aclPermisson = require('./bootstrap/acl')(acl);
  //   acl.allow(rules);
    aclPermisson.setting();
    // parse application/x-www-form-urlencoded
    app.use(bodyParser.urlencoded({
        extended: false
    }));
    app.use(bodyParser.json());
    app.use(
        cors({
        origin: true,
        credentials: true,
        optionsSuccessStatus: 200
    }));
    app.use(helmet());
    app.use(express.static(`${__dirname}/public`));
    // app.use(
    //     cors({
    //     origin: "['http://localhost:3000','http://vmi1031755.contaboserver.net','http://154.38.162.121']",
    //     credentials: true,
    //     optionsSuccessStatus: 200
    // }));
    //app.use(aclPermisson.authCheck());
    app.use(function(req,res,next){
        req.pool = rdb.pool;
        req.query = rdb.query;
        req.acl = acl;
      //  req.nosql = nosql;
        req.queryCache = require('./bootstrap/cache')(rdb.pool); // cache  connection
        global.pool = req.pool;
        global.query = req.query;
        global.acl = req.acl;
       // global.nosql = req.nosql;
        global.sqlcache = req.queryCache;
        next();
    });
    app.use(haltOnTimedout);
    // Route imports
    app.use(aclPermisson.authCheck);
    const homeRoutes = require('./routes/home')
    const authRoutes = require('./routes/auth')
    const decentoRoutes = require('./routes/decentoRoutes')
    const privateRoutes = require('./routes/privateRoutes')
    const faqRoutes = require('./routes/faqRoutes')
    const testimonialRoutes = require('./routes/testimonialRoutes')
    const dealRoutes = require('./routes/dealRoutes')

    // Middlewares
 //   app.use(cookieParser());
  //  app.use(require('./bootstrap/session'));
   
  //  app.use(express.json());


    // -> Route Middlewares
    app.use('/', homeRoutes);
    app.use('/api/private', privateRoutes);
    app.use('/api/user', authRoutes);
    app.use('/api/decentro', decentoRoutes);
    app.use('/api/faq', faqRoutes);
    app.use('/api/testimonial', testimonialRoutes);
    app.use('/api/deal', dealRoutes);
    
    function haltOnTimedout(req, res, next){
        if (!req.timedout) next();
    }

    app.use(function(err, req, res, next) {
        res.status(err.status || 500);
        res.json(err);
    });
    // Starting the server
    app.listen(process.env.PORT, () => {
        console.log(`Application running at http://localhost:${process.env.PORT}/`)
    })
    
});

