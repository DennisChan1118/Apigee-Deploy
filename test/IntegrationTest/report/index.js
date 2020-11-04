var reporter = require('cucumber-html-reporter');

var options = {
    theme: 'bootstrap',
    jsonFile: 'result/result.json',
    output: 'result/result.html',
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false
};

reporter.generate(options);
