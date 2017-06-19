# sssi-website-temp
A temporary static website

To update the website, you need to do the following:
1. Build the project (use either `make build` or `gulp build`)
2. Push the built files to S3 (using `aws s3 sync ./dist s3://sssi.org.au --acl public-read`)
3. Invalidate the CloudFront (using `aws cloudfront create-invalidation --distribution-id E1AK4Y07WQUSX5 --paths '/*'`)

It is possible to manually do all these steps.

It's also possible to do them in one hit, using Make (`make deploy`).
