FROM ubuntu:bionic-20200807

ARG TERRAFORM_VERSION="0.13.2"
ARG ANSIBLE_VERSION="2.5.1"
ARG PACKER_VERSION="1.5.4"
ARG AWSCLI_VERSION="1.18.19"

#LABEL maintainer="Sushil <sadhikari9@dxc.com>"
LABEL terraform_version=${TERRAFORM_VERSION}
LABEL ansible_version=${ANSIBLE_VERSION}
LABEL aws_cli_version=${AWSCLI_VERSION}

ENV DEBIAN_FRONTEND=noninteractive
ENV AWSCLI_VERSION=${AWSCLI_VERSION}
ENV TERRAFORM_VERSION=${TERRAFORM_VERSION}
ENV PACKER_VERSION=${PACKER_VERSION}
RUN apt-get update \
    && apt-get install -y ansible curl wget unzip  ntp

#python3 python3-pip python3-boto wget unzip  ntp 
    
#\  && pip3 install --upgrade awscli==${AWSCLI_VERSION}
  
RUN wget --quiet https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
  && mv terraform /usr/local/bin \
  && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip
  
RUN wget --quiet https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
  && unzip '*.zip' -d /usr/local/bin \
  && rm *.zip

RUN apt-get install -y python3 python3-pip python3-boto
  
RUN pip3 install --upgrade awscli==${AWSCLI_VERSION}

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD    ["/bin/bash"]
