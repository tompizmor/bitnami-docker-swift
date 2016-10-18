FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r10

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=swift \
    BITNAMI_IMAGE_VERSION=3.0-RELEASE-r1

# Install Swift dependencies
RUN apt-get update && \
    apt-get install -y clang libedit2 libicu52 libsqlite3-dev libxml2 && \
    apt-get clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN bitnami-pkg install python-2.7.12rc1-0 --checksum 2c56021761411358b949fa0c962d61875d70f5b092fc937dceea1b52ce8440d5
ENV PATH=/opt/bitnami/python/bin:$PATH

# Install Swift module
RUN bitnami-pkg install swift-3.0-RELEASE-0 --checksum 260203f5915cd861c47adc6b9f2fb261702be9bebfcd82b056b7c15c50894043
ENV PATH=/opt/bitnami/swift/bin:$PATH

RUN chmod a+r /opt/bitnami/swift/lib/swift/CoreFoundation/module.modulemap

# Set up Codenvy integration
USER bitnami
WORKDIR /projects

ENV TERM=xterm

CMD ["/entrypoint.sh", "tail", "-f", "/dev/null"]
