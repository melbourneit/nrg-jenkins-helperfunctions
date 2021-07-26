#!/bin/bash

# Source: http://build.nrg-aws.com:8080/job/New_NRG_Cart_Jobs/job/PACKER_NEW_SERVICE_AMI

./utils/create-ami.sh \
		--aws_access_key=${AWS_ACCESS_KEY_ID} \
        --aws_secret_key=${AWS_SECRET_ACCESS_KEY} \
        --parameters="\
        		source_ami=${SOURCE_AMI_ID}
        		ami_name=${AMI_NAME} \
                ami_version=${BUILD_NUMBER} \
                docker_registry_host=${DOCKER_REGISTRY_HOST} \
                services=${SERVICES} \
                start_non_scaling_ec2_instance=${WORKSPACE}/non-scaling/start_non_scaling_ec2_instance.sh \
                start_scaling_ec2_instance=${WORKSPACE}/scaling/start_scaling_ec2_instance.sh \
                start_scaling_ec2_consul_instance=${WORKSPACE}/scaling/start_scaling_ec2_consul_instance.sh \
                start_prometheus_ec2_instance=${WORKSPACE}/scaling/start_prometheus_ec2_instance.sh \
                ami_output_file=${AMI_OUTPUT_FILE}" \
        --template_file=new-services.json