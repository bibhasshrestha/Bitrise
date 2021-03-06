#!/bin/bash
 
set -ex
 
PROJECT_ID='333'
API_KEY='d3TzEYq0j17cAyDDCTTvE1Pbh9whrcQ77kvdwcB6'
CLIENT_ID='db6ad047665572b188919f065e8115b9'
SCOPES=['"ViewTestResults"','"ViewAutomationHistory"']
API_URL='https://7iggpnqgq9.execute-api.us-east-2.amazonaws.com/udbodh/api'
INTEGRATION_JWT_TOKEN='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwcm9qZWN0X2lkIjozMzMsImFwaV9rZXlfaWQiOjQ4MjIsIm5hbWUiOiIiLCJkZXNjcmlwdGlvbiI6IiIsImljb24iOiIiLCJpbnRlZ3JhdGlvbl9uYW1lIjoiZ2l0bGFiIiwib3B0aW9ucyI6e30sImlhdCI6MTYyMTI0Mjg5Mn0.ZE9D7MxlCQV0LwpbJldKu7ZX_A7YFZzbdXQgD6v2e9A'
INTEGRATIONS_API_URL='http://ec3ed08ab73d.ngrok.io'
 
sudo apt-get update -y
sudo apt-get install -y jq
 
#Trigger test run
TEST_RUN_ID="$( \
  curl -X POST -G ${INTEGRATIONS_API_URL}/integrations/bitrise/${PROJECT_ID}/events \
    -d 'token='$INTEGRATION_JWT_TOKEN''\
    -d 'triggerType=Deploy'\
    -d 'projectId='$PROJECT_ID''\
  | jq -r '.test_run_id')"
 
AUTHORIZATION_TOKEN="$( \
  curl -X POST -G ${API_URL}/auth/token \
  -H 'x-api-key: '${API_KEY}'' \
  -H 'client_id: '${CLIENT_ID}'' \
  -H 'scopes: '"${SCOPES}"'' \
  | jq -r '.token')"
 
# Wait until the test run has finished
while : ; do
   RESULT="$( \
   curl -X GET ${API_URL}/automation-history?project_id=${PROJECT_ID}\&test_run_id="${TEST_RUN_ID}" \
   -H 'token: Bearer '"$AUTHORIZATION_TOKEN"'' \
   -H 'x-api-key: '${API_KEY}'' \
  | jq -r '.[0].finished')"
  if [ "$RESULT" != null ]; then
    break;
  fi
    sleep 15;
done
 
# # Once finished, verify the test result is created and that its passed
TEST_RUN_RESULT="$( \
  curl -X GET ${API_URL}/test-results?test_run_id="${TEST_RUN_ID}"\&project_id=${PROJECT_ID} \
    -H 'token: Bearer '"$AUTHORIZATION_TOKEN"'' \
    -H 'x-api-key: '${API_KEY}'' \
  | jq -r '.[0].status' \
)"
echo "Qualiti E2E Tests ${TEST_RUN_RESULT}"
