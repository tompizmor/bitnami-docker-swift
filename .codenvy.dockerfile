FROM gcr.io/stacksmith-images/minideb-buildpack:jessie-r1

MAINTAINER Bitnami <containers@bitnami.com>

ENV BITNAMI_APP_NAME=swift \
    BITNAMI_IMAGE_VERSION=3.0-RELEASE-r2 \
    PATH=/opt/bitnami/python/bin:/opt/bitnami/swift/bin:$PATH

# Install Swift dependencies
RUN apt-get update && \
    apt-get install -y clang libedit2 libicu52 libsqlite3-dev libxml2 && \
    apt-get clean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

RUN bitnami-pkg install python-2.7.12-1 --checksum 1ab49b32453c509cf6ff3abb9dbe8a411053e3b811753a10c7a77b4bc19606df

# Install Swift module
RUN bitnami-pkg install swift-3.0-RELEASE-0 --checksum 260203f5915cd861c47adc6b9f2fb261702be9bebfcd82b056b7c15c50894043
ENV PATH=$PATH

RUN chmod a+r /opt/bitnami/swift/lib/swift/CoreFoundation/module.modulemap

# Set up Codenvy integration
USER bitnami
WORKDIR /projects

ENV TERM=xterm

CMD ["/entrypoint.sh", "tail", "-f", "/dev/null"]
