FROM gcr.io/stacksmith-images/ubuntu-buildpack:14.04-r9

MAINTAINER Bitnami <containers@bitnami.com>

USER root

# Install extra packages
RUN apt-get update && \
    apt-get install -y clang libedit2 libicu52 libsqlite3-dev libxml2 && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    apt-get clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Install related packages
RUN bitnami-pkg install java-1.8.0_91-0 --checksum 64cf20b77dc7cce3a28e9fe1daa149785c9c8c13ad1249071bc778fa40ae8773
ENV PATH=/opt/bitnami/java/bin:$PATH

RUN bitnami-pkg install python-2.7.12rc1-0 --checksum 2c56021761411358b949fa0c962d61875d70f5b092fc937dceea1b52ce8440d5
ENV PATH=/opt/bitnami/python/bin:$PATH

# Swift module
RUN bitnami-pkg install swift-3.0-RELEASE-0 --checksum 260203f5915cd861c47adc6b9f2fb261702be9bebfcd82b056b7c15c50894043
ENV PATH=/opt/bitnami/swift/bin:$PATH

## STACKSMITH-END: Modifications below this line will be unchanged when regenerating

RUN chmod a+r /opt/bitnami/swift/lib/swift/CoreFoundation/module.modulemap

# Swift template
ENV BITNAMI_APP_NAME=swift \
    BITNAMI_IMAGE_VERSION=3.0-RELEASE-r0

USER bitnami
WORKDIR /projects

CMD ["tail", "-f", "/dev/null"]
