/* jslint node: true */
'use strict';

var config = require('../../config/config.json');

const apickli = require('../../apickli/apickli.js');
const { defineSupportCode } = require('cucumber');



defineSupportCode(function ({ Before }) {
    Before(function () {
        this.apickli = new apickli.Apickli(
            config.schema,
            config.domain + config.basepath);
        this.apickli.addRequestHeader('Cache-Control', 'no-cache');
    });
});
defineSupportCode(function ({ setDefaultTimeout }) {
    setDefaultTimeout(60 * 1000); // this is in ms
});
