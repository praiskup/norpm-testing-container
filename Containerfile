FROM registry.fedoraproject.org/fedora:42@sha256:87278f24ac7fcddf323f02ae553e86b711905b5f095e442d1bf7fe39914dc6d0

RUN dnf -y install python3-specfile \
                   redhat-rpm-config \
                   rpm-build \
                   golang-oras \
    && dnf clean all

RUN oras pull quay.io/norpm/rawhide-specfiles:latest

RUN tar xf rpm-specs-latest.tar.xz

ADD rpmspec-epoch-version /rpmspec-epoch-version

RUN /rpmspec-epoch-version
