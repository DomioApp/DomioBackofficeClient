#!/usr/bin/env bash

echo Installing NodeJS...
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
apt-get install -y nodejs
echo NodeJS is installed!
node version