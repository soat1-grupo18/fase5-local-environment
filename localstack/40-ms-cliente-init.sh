#!/bin/bash

set -v

awslocal sqs create-queue \
  --queue-name ms-cliente-evento-pagamento-aprovado-dlq

awslocal sqs create-queue \
  --queue-name ms-cliente-evento-pagamento-aprovado \
  --attributes '{ "RedrivePolicy": "{\"deadLetterTargetArn\":\"arn:aws:sqs:us-east-1:000000000000:ms-cliente-evento-pagamento-aprovado-dlq\",\"maxReceiveCount\":\"3\"}" }'

awslocal sqs create-queue \
  --queue-name ms-cliente-evento-pagamento-recusado-dlq

awslocal sqs create-queue \
  --queue-name ms-cliente-evento-pagamento-recusado \
  --attributes '{ "RedrivePolicy": "{\"deadLetterTargetArn\":\"arn:aws:sqs:us-east-1:000000000000:ms-cliente-evento-pagamento-recusado-dlq\",\"maxReceiveCount\":\"3\"}" }'

awslocal sns subscribe \
  --topic-arn arn:aws:sns:us-east-1:000000000000:ms-pagamento \
  --protocol sqs \
  --notification-endpoint arn:aws:sqs:us-east-1:000000000000:ms-cliente-evento-pagamento-aprovado \
  --attributes '{ "RawMessageDelivery": "true", "FilterPolicy": "{\"event-type\": [\"aprovado\"]}" }'

awslocal sns subscribe \
  --topic-arn arn:aws:sns:us-east-1:000000000000:ms-pagamento \
  --protocol sqs \
  --notification-endpoint arn:aws:sqs:us-east-1:000000000000:ms-cliente-evento-pagamento-recusado \
  --attributes '{ "RawMessageDelivery": "true", "FilterPolicy": "{\"event-type\": [\"recusado\"]}" }'
