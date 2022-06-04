#!/bin/bash

TEST_1="`curl -o - http://localhost/TestService.asmx/Test | grep Success`"
if [ -z "$TEST_1" ]; then exit -6; fi

TEST_1="`curl -o - http://localhost/Test.aspx | grep Success`"
if [ -z "$TEST_1" ]; then exit -6; fi
  
exit 0
