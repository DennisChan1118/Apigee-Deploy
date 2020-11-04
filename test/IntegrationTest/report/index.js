var reporter = require('cucumber-html-reporter');

var options = {
    theme: 'bootstrap',
    jsonFile: 'report/report.json',
    output: 'report/report.html',
    reportSuiteAsScenarios: true,
    scenarioTimestamp: true,
    launchReport: false
};

reporter.generate(options);
