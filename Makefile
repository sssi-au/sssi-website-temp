DOMAIN=sssi.org.au
STACK=sssi-org-au-test
deploy:
	gulp build
	aws s3 sync ./dist s3://$(DOMAIN) --acl public-read

run:
	gulp serve

deploy-infrastructure:
	AWS_DEFAULT_REGION=ap-southeast-2 \
	aws cloudformation create-stack \
		--stack-name $(STACK)-infrastructure \
		--template-body file://s3infra.json \
		--parameters ParameterKey=DomainName,ParameterValue=$(DOMAIN)