FROM registry.fedoraproject.org/fedora:44@sha256:c76c0a41b769676815b904ba5447ff07b719309a8edcda8caa136cbf680c5542

RUN dnf -y install python3-specfile \
                   redhat-rpm-config \
                   rpm-build \
                   golang-oras \
                   python3-ply \
    && dnf clean all

RUN oras pull quay.io/norpm/rawhide-specfiles:latest

RUN tar xf rpm-specs-latest.tar.xz

ADD rpmspec-epoch-version /rpmspec-epoch-version

RUN /rpmspec-epoch-version
