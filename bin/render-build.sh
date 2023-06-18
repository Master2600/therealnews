#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate VERSION=20230609235510
bundle exec rake db:migrate VERSION=20230610005506
bundle exec rake db:migrate VERSION=20230610005639

bundle exec rake db:seed