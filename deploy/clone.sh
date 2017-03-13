#!/usr/bin/env bash

cd ~/
rm -rf ~/domioclient
git clone git@gitlab.com:basharov/DomioClient.git ~/domioclient
cd ~/domioclient
git tag -l --points-at HEAD
