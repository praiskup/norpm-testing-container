FROM registry.fedoraproject.org/fedora:43@sha256:a08659cad3f9c8279e70bea1feee02162a1751bda3103c55ba437707fa8efeca

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
