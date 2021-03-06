#!/usr/bin/env bash

# Directory containing the angular-archwizard-demo repository
ARCHWIZARD_DEMO_DIR=$1

ARCHWIZARD_REPOSITORY_URL="https://github.com/madoar/angular-archwizard.git"
ARCHWIZARD_VERSION=$(grep '"angular-archwizard":' package.json | cut -d '"' -f4 | tr -d '[[:space:]]')
ARCHWIZARD_DIR="$ARCHWIZARD_DEMO_DIR/../angular-archwizard"
ARCHWIZARD_DIST_DIR="$ARCHWIZARD_DIR/dist"

# if a development version of angular-archwizard is specified in the package.json file
# then clone the angular-archwizard repository and build it locally
if [[ "$ARCHWIZARD_VERSION" == *develop ]]; then
  # clone angular-archwizard
  git clone $ARCHWIZARD_REPOSITORY_URL $ARCHWIZARD_DIR

  # build angular-archwizard develop branch
  cd $ARCHWIZARD_DIR
  npm install
  npm run build

  # install angular-archwizard
  cd $ARCHWIZARD_DEMO_DIR
  if [ -f "package-lock.json" ]; then
    rm package-lock.json
  fi
  npm install --save $ARCHWIZARD_DIST_DIR
  npm install --package-lock-only

  echo "Installed angular-archwizard from \"$ARCHWIZARD_REPOSITORY_URL\" to \"$ARCHWIZARD_DIST_DIR\""
fi
