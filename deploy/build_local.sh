#!/usr/bin/env bash

export PATH=/cygdrive/c/dart-sdk/bin/:${PATH}

pub.bat get
pub.bat build src/app
mv -f build/src/app/app.dart.js /cygdrive/c/usr/local/domio_client/app.dart.js
