#!/usr/bin/env bash

set -e

logger -n logs5.papertrailapp.com -t deploy -P 18422 -p user.notice "Domio Client deploy has started..."

cd ~/domioclient

if ! [ -x "$(command -v node)" ]; then
   echo 'node is not installed.' >&2
   sh ~/domioclient/deploy/install_node.sh
  else
   echo "node is already installed!" >&2
fi

if ! [ -x "$(command -v dart)" ]; then
   echo 'Dart is not installed.' >&2
   sh ~/domioclient/deploy/install_dart.sh
  else
   echo "Dart is already installed!" >&2
fi

export PATH=/usr/lib/dart/bin:${PATH}

sh ~/domioclient/deploy/copy_dart_files.sh
sh ~/domioclient/deploy/build.sh
sh ~/domioclient/deploy/clean.sh
