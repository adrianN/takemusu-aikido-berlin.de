#/bin/bash
git push
rsync -vrz html/ takemusu-website: --delete
