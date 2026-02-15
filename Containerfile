FROM registry.fedoraproject.org/fedora:43@sha256:4a0697ae8a9de45df5fefff5d81feeaa39ae7fe071d1ed6b16b54261dc7f208c

RUN dnf -y install python3-specfile \
                   redhat-rpm-config \
                   rpm-build \
                   golang-oras \
                   python3-lark \
    && dnf clean all

RUN oras pull quay.io/norpm/rawhide-specfiles@sha256:6ee7b1ba77bd9478fbc9e619f0cff096cb00439bc3974907c21a61797ee96dea

RUN tar xf rpm-specs-latest.tar.xz

ADD rpmspec-epoch-version /rpmspec-epoch-version

RUN /rpmspec-epoch-version
