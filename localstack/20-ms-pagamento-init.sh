#!/bin/bash

set -v

awslocal dynamodb create-table \
  --table-name Pagamentos \
  --attribute-definitions '[ { "AttributeName": "id", "AttributeType": "S" }]' \
  --key-schema '[ { "AttributeName": "id", "KeyType": "HASH" }]' \
  --billing-mode PAY_PER_REQUEST

awslocal sns create-topic \
  --name ms-pagamento

awslocal sqs create-queue \
  --queue-name ms-pagamento-evento-pedido-recebido-dlq

awslocal sqs create-queue \
  --queue-name ms-pagamento-evento-pedido-recebido \
  --attributes '{ "RedrivePolicy": "{\"deadLetterTargetArn\": \"arn:aws:sqs:us-east-1:000000000000:ms-pagamento-evento-pedido-recebido-dlq\", \"maxReceiveCount\": \"3\" }" }'
  
awslocal sns subscribe \
  --topic-arn arn:aws:sns:us-east-1:000000000000:ms-pedido \
  --protocol sqs \
  --notification-endpoint arn:aws:sqs:us-east-1:000000000000:ms-pagamento-evento-pedido-recebido \
  --attributes '{ "RawMessageDelivery": "true" }'
