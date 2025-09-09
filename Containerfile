FROM registry.fedoraproject.org/fedora:42@sha256:87278f24ac7fcddf323f02ae553e86b711905b5f095e442d1bf7fe39914dc6d0

RUN dnf -y install python3-specfile \
                   redhat-rpm-config \
                   rpm-build \
                   golang-oras \
                   python3-ply \
    && dnf clean all

RUN oras pull quay.io/norpm/rawhide-specfiles@sha256:6ee7b1ba77bd9478fbc9e619f0cff096cb00439bc3974907c21a61797ee96dea

RUN tar xf rpm-specs-latest.tar.xz

ADD rpmspec-epoch-version /rpmspec-epoch-version

RUN /rpmspec-epoch-version
