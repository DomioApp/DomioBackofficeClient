#!/usr/bin/env bash
set -e

echo Building Domio Client...

cd ~/domioclient


#=====================================================================================================================

buildstamp=`date -u '+%Y-%m-%d_%I:%M:%S%p'`
buildstamp=`date -u '+%s'`
hash=`git rev-parse --short HEAD`
version=`git tag -l --points-at HEAD`

echo ------------------------------------------------------
echo "Buildstamp: ${buildstamp}"
echo "Hash:       ${hash}"
echo "Version:    ${version}"
echo ------------------------------------------------------

mkdir -p /usr/local/domio_client

#go build -o /usr/local/bin/domio_public -ldflags "-X main.Buildstamp=$buildstamp -X main.Hash=$hash  -X main.Version=$version" domio_public

#echo "export function getAppInfo() { return '${version}' }" > src/scripts/app_info.js

npm install
npm run style

pub get
#pub build src/app --output=/usr/local/domio_client/js
pub build src/app
mv -f build/src/app/app.dart.js /usr/local/domio_client/app.dart.js

#echo "export function getAppInfo() { return '%VERSION%' }" > src/scripts/app_info.js

#=====================================================================================================================

logger -n logs5.papertrailapp.com -t deploy -P 18422 -p user.notice "Domio Client is built and ready!"