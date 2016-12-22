#!/bin/sh
set -ex
#mvn -DreleaseVersion=${version} -DdevelopmentVersion=${pom.version} -DpushChanges=false -DlocalCheckout=true -DpreparationGoals=initialize release:prepare release:perform -B
# http://maven.apache.org/maven-release/maven-release-plugin/prepare-mojo.html

version=`git describe --tags || { echo -n "0.0.0-"; git describe --always; }`
pomVersion=`xpath -q -e "project/version/text()" pom.xml`
localStage=`pwd`/local-staging-repo

mvn -DtagNameFormat="@{project.version}" -DreleaseVersion=${version} -DdevelopmentVersion=${pomVersion} -DpushChanges=false -DlocalCheckout=true -DpreparationGoals=initialize -DstagingRepository=local::default::file://${localStage} release:prepare release:stage -B
