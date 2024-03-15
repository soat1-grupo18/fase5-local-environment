#!/bin/bash

set -ev

awslocal dynamodb create-table \
  --table-name Pagamentos \
  --attribute-definitions '[ { "AttributeName": "id", "AttributeType": "S" }]' \
  --key-schema '[ { "AttributeName": "id", "KeyType": "HASH" }]'

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

awslocal sqs create-queue \
  --queue-name ms-pagamento-evento-pagamento-aprovado-dlq

awslocal sqs create-queue \
  --queue-name ms-pagamento-evento-pagamento-aprovado \
  --attributes '{ "RedrivePolicy": "{\"deadLetterTargetArn\": \"arn:aws:sqs:us-east-1:000000000000:ms-pagamento-evento-pagamento-aprovado-dlq\", \"maxReceiveCount\": \"3\" }" }'

awslocal sns subscribe \
  --topic-arn arn:aws:sns:us-east-1:000000000000:ms-pagamento \
  --protocol sqs \
  --notification-endpoint arn:aws:sqs:us-east-1:000000000000:ms-pagamento-evento-pagamento-aprovado \
  --attributes '{ "RawMessageDelivery": "true", "FilterPolicy": "{\"event-type\": [\"aprovado\"]}" }'

awslocal sqs create-queue \
  --queue-name ms-pagamento-evento-pagamento-recusado-dlq

awslocal sqs create-queue \
  --queue-name ms-pagamento-evento-pagamento-recusado \
  --attributes '{ "RedrivePolicy": "{\"deadLetterTargetArn\": \"arn:aws:sqs:us-east-1:000000000000:ms-pagamento-evento-pagamento-recusado-dlq\", \"maxReceiveCount\": \"3\" }" }'

awslocal sns subscribe \
  --topic-arn arn:aws:sns:us-east-1:000000000000:ms-pagamento \
  --protocol sqs \
  --notification-endpoint arn:aws:sqs:us-east-1:000000000000:ms-pagamento-evento-pagamento-recusado \
  --attributes '{ "RawMessageDelivery": "true", "FilterPolicy": "{\"event-type\": [\"recusado\"]}" }'