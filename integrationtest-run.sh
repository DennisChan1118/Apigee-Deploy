#!/bin/bash

echo "> API Proxy Name: (Enter '*' to test all proxies)"
read apiproxy

echo "> Move to 'test/IntegrationTest'..."
cd test/IntegrationTest
echo "> Install NodeJs packages..."
npm install
echo "> Run integration test for $apiproxy..."
npm run-script test -- features/Feature_$apiproxy
echo "> Generate Integration Test html report..."
npm run-script report
