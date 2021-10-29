#!/bin/bash

set -eo pipefail
shopt -s nullglob

cd /data_models
diesel migration run

cron -f