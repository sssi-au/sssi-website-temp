DOMAIN=sssi.org.au
STACK=sssi-org-au-test
deploy: build upload invalidate

build:
	gulp build

run:
	gulp serve

upload:
	aws s3 sync ./dist s3://$(DOMAIN) --acl public-read

invalidate:
	# Tell the CDN to refresh everything... This costs money if you do it too much
	aws cloudfront create-invalidation --distribution-id E1AK4Y07WQUSX5 --paths '/*'

deploy-infrastructure:
	AWS_DEFAULT_REGION=ap-southeast-2 \
	aws cloudformation create-stack \
		--stack-name $(STACK)-infrastructure \
		--template-body file://s3infra.json \
		--parameters ParameterKey=DomainName,ParameterValue=$(DOMAIN)

update-infrastructure:
	AWS_DEFAULT_REGION=ap-southeast-2 \
	aws cloudformation update-stack \
		--stack-name $(STACK)-infrastructure \
		--template-body file://s3infra.json \
		--parameters ParameterKey=DomainName,ParameterValue=$(DOMAIN)