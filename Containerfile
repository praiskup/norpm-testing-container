FROM registry.fedoraproject.org/fedora:45@sha256:b47be662cf0f82f377aaa7788f1b7d1d2ec79ea2e31065dc6eefed16e9294839

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
