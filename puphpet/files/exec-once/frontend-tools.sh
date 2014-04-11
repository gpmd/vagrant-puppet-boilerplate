#!/bin/bash

echo "--- Installing node.js ---"
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install python-software-properties python g++ make nodejs

echo "--- Installing grunt-cli ---"
npm install -g grunt-cli

echo "--- Installing Bower ---"
npm install -g bower

echo "--- Installing Compass ---"
gem install compass