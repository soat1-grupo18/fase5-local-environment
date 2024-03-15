#!/bin/bash

set -v

awslocal sns create-topic \
  --name ms-pedido