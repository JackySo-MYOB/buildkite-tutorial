ORG := "24x7classroom"
TOKEN := $(shell aws ssm get-parameters --names "/bk/api/token" --with-decryption --query Parameters[].Value --output text)
SLUG := "buildkite-tutorial-by-jacky-so"
.phony: help

help:
	@echo "Buildkite tutorial help: token list-user list-pipelines delete-pipeline SLUG=<slug>"
	@echo "Buildkite tutorial help: get-pipeline get-pipeline-webhook SLUG=<slug>"

token:
	@echo $(TOKEN)

list-pipelines:
	@echo "You have the following pipelines: "
	@curl -s -H "Authorization: Bearer $(TOKEN)" "https://api.buildkite.com/v2/organizations/$(ORG)/pipelines" | jq '.[] | {SLUG: .slug}'

delete-pipeline:
	@curl -H "Authorization: Bearer $(TOKEN)" -X DELETE "https://api.buildkite.com/v2/$(ORG)/24x7classroom/pipelines/$(SLUG)"

list-user:
	@curl -s -H "Authorization: Bearer $(TOKEN)" "https://api.buildkite.com/v2/user" | jq

get-pipeline:
	@curl -s -H "Authorization: Bearer $(TOKEN)" "https://api.buildkite.com/v2/organizations/$(ORG)/pipelines/$(slug)" | jq '.[]'

get-pipeline-webhook:
	@curl -s -H "Authorization: Bearer $(TOKEN)" "https://api.buildkite.com/v2/organizations/$(ORG)/pipelines/$(slug)" | jq '.[].provider | {URL: .webhook_url}'
