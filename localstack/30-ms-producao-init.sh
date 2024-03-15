#!/bin/bash

set -v

awslocal sqs create-queue \
  --queue-name ms-producao-evento-pedido-recebido-dlq

awslocal sqs create-queue \
  --queue-name ms-producao-evento-pedido-recebido \
  --attributes '{ "RedrivePolicy": "{\"deadLetterTargetArn\": \"arn:aws:sqs:us-east-1:000000000000:ms-producao-evento-pedido-recebido-dlq\", \"maxReceiveCount\": \"3\" }" }'

awslocal sns subscribe \
  --topic-arn arn:aws:sns:us-east-1:000000000000:ms-pedido \
  --protocol sqs \
  --notification-endpoint arn:aws:sqs:us-east-1:000000000000:ms-producao-evento-pedido-recebido \
  --attributes '{ "RawMessageDelivery": "true" }'