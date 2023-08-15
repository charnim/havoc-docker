#!/bin/bash

cd /opt/Havoc && ./havoc server --profile ./profiles/havoc.yaotl -v --debug

tail -F /dev/null
