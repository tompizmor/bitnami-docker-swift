FROM gcr.io/stacksmith-images/minideb-buildpack:jessie-r3

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=che-swift \
    BITNAMI_IMAGE_VERSION=che-3.0.1-RELEASE-r0 \
    PATH=/opt/bitnami/python/bin:/opt/bitnami/swift/bin:$PATH

# Install Swift dependencies
RUN apt-get update && \
    apt-get install -y clang libedit2 libicu52 libsqlite3-dev libxml2 && \
    apt-get clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN bitnami-pkg install python-2.7.12-1 --checksum 1ab49b32453c509cf6ff3abb9dbe8a411053e3b811753a10c7a77b4bc19606df

# Install Swift module
RUN bitnami-pkg install swift-3.0.1-RELEASE-0 --checksum 4ae1a8804910f5f265133edf2897d86b9aac3daacbe51ab30bd29bd2a12acce7
ENV PATH=$PATH

RUN chmod a+r /opt/bitnami/swift/lib/swift/CoreFoundation/module.modulemap

# Set up Codenvy integration
USER bitnami
WORKDIR /projects

ENV TERM=xterm

CMD [ "tail", "-f", "/dev/null"]
