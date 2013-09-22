#!/bin/bash

set -e

echo "===> Generating site..."
echo ""
bundle exec rake generate

echo ""
echo ""
echo "===> Copying to server..."
echo ""
rsync -avz public/* void.flux88.com:/srv/www/benscheirman.com/

echo ""
echo "===> Done."
