#!/bin/bash

TEST_1="`curl -o - http://localhost/ | grep Success`"
if [ -z "$TEST_1" ]; then exit -6; fi
  
exit 0
