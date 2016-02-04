#!/bin/bash

set -e

echo "===> Generating site..."
echo ""
bundle exec rake generate

echo ""
echo ""
echo "===> Copying to server..."
echo ""
rsync -avz public/* benscheirman.com:/srv/www/benscheirman.com/

ssh benscheirman.com -C "chmod 644 /srv/www/benscheirman.com/images/*"

echo ""
echo "===> Done."
