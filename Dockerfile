FROM ubuntu:20.04

ARG TERRAFORM_VERSION="0.12.28"
ARG ANSIBLE_VERSION="2.9.10"
ARG PACKER_VERSION="1.6.0"
ARG AZCLI_VERSION="2.7.0"

LABEL maintainer="LASO Development"
LABEL terrform_version=${TERRAFORM_VERSION}
LABEL ansible_version=${ANSIBLE_VERSION}}
LABEL packer_version=${PACKER_VERSION}
LABEL azcli_version=${AZCLI_VERSION}

ENV DEBIAN_FRONTEND=noninteractive
ENV AZCLI_VERSION=${AZCLI_VERSION}
ENV TERRAFORM_VERSION=${TERRAFORM_VERSION}
ENV PACKER_VERSION=${PACKER_VERSION}

RUN apt-get update \
    && apt-get install -y --no-install-recommends ansible curl python3 python3-pip python3-boto unzip \
    && curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
    && curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && curl -LO https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
    && unzip '*.zip' -d /usr/local/bin \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* *.zip

CMD ["/bin/bash"]