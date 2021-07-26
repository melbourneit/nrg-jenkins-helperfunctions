#!/bin/bash

# Source: http://build.nrg-aws.com:8080/job/New_NRG_Cart_Jobs/job/CF_CREATE_SCALING_PROD

# generate variables containing build date
BUILD_DATE=$(date +%Y%m%d)
ENVIRONMENT_LOWER=$(echo $ENVIRONMENT | tr [A-Z] [a-z])
NAME="${ENVIRONMENT_LOWER}-${BUILD_DATE}${BUILD_NUMBER}"
CONSUL_SUBDOMAIN="${NAME}-consul"
PROMETHEUS_SUBDOMAIN="${NAME}-prometheus"
CART_SUBDOMAIN="${NAME}-cart"

SOURCE_AMI=$(cat /var/tmp/master_ami_id.txt)

./utils/create-update-cf.sh \
		--action=create-stack \
        --region=${AWS_REGION} \
        --stack_name=${NAME} \
        --parameters="ParameterKey=Environment,ParameterValue=${ENVIRONMENT} \
					  ParameterKey=Name,ParameterValue=${NAME} \
					  ParameterKey=SourceAmi,ParameterValue=${SOURCE_AMI} \
                      ParameterKey=ServiceInstanceType,ParameterValue=${SERVICE_INSTANCE_TYPE} \
                      ParameterKey=ConsulInstanceType,ParameterValue=${CONSUL_INSTANCE_TYPE} \
                      ParameterKey=PrometheusInstanceType,ParameterValue=${PROMETHEUS_INSTANCE_TYPE} \
                      ParameterKey=InstanceIAMRole,ParameterValue=${INSTANCE_IAM_ROLE} \
					  ParameterKey=ConsulSubdomain,ParameterValue=${CONSUL_SUBDOMAIN} \
					  ParameterKey=PrometheusSubdomain,ParameterValue=${PROMETHEUS_SUBDOMAIN} \
					  ParameterKey=CartSubdomain,ParameterValue=${CART_SUBDOMAIN} \
					  ParameterKey=ConsoleApiUrl,ParameterValue=${CONSOLE_API_URL} \
					  ParameterKey=AbnAuthGuid,ParameterValue=${ABN_AUTH_GUID} \
					  ParameterKey=DebugServices,ParameterValue=${DEBUG_SERVICES} \
					  ParameterKey=Development,ParameterValue=${DEVELOPMENT} \
					  ParameterKey=DomainsbotApiAuthToken,ParameterValue=${DOMAINSBOT_API_AUTH_TOKEN} \
					  ParameterKey=SpinApiUrl,ParameterValue=${SPIN_API_URL} \
					  ParameterKey=SpinPassword,ParameterValue=${SPIN_PASSWORD} \
					  ParameterKey=SpinUsername,ParameterValue=${SPIN_USERNAME} \
					  ParameterKey=DsaTenantPassword,ParameterValue=${DSA_TENANT_PASSWORD} \
                      ParameterKey=RecaptchaSiteKey,ParameterValue=${RECAPTCHA_SITE_KEY} \
                      ParameterKey=RecaptchaSecretKey,ParameterValue=${RECAPTCHA_SECRET_KEY} \
                      ParameterKey=DomainCheckAPIURL,ParameterValue=${DOMAIN_CHECK_API_URL} \
					  ParameterKey=CheckoutCCSalt,ParameterValue=${CHECKOUT_CC_SALT}" \
        --template_url=${CF_TEMPLATE_S3_BUCKET_URL}/scaling.json