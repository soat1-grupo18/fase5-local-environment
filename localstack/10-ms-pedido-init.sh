#!/bin/bash

set -ev

awslocal sns create-topic \
  --name ms-pedido