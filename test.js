const row = {"test 1":[{"question":"question1","answer":"answer1"},{"question":"question2","answer":"answer2"},{"question":"question3","answer":"answer3"},{"question":"question4","answer":"answer4"}],"test2":[{"question":"question5","answer":"answer5"}],"test 3":[{"question":"question6","answer":"answer6"}]};
var step1 = row.reduce((result, {category_name, question, answer}) => {
    result[category_name] = result[category_name] || [];
    
    result[category_name].push({question, answer});
    return result;
}, {});
//return step1;
var result = Object.keys(step1).map(category_name => ({category:category_name, questions: step1[category_name]}));
