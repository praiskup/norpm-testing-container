FROM registry.fedoraproject.org/fedora:44@sha256:74308242e6f1d8a473f93849c1f019c6eea2eb4bb9217bdf2c4ff0f2b64bd3a9

RUN dnf -y install python3-specfile \
                   redhat-rpm-config \
                   rpm-build \
                   golang-oras \
                   python3-lark \
      --enablerepo updates-testing \
    && dnf clean all

RUN oras pull quay.io/norpm/rawhide-specfiles@sha256:fb8f8be90b25dd7d38f587553ffc9806566bf2618b8022dd29543596b14dcbc4

RUN tar xf rpm-specs-latest.tar.xz

ADD rpmspec-epoch-version /rpmspec-epoch-version
RUN /rpmspec-epoch-version

ADD exclude-statements /exclude-statements
RUN /exclude-statements

ADD expand_exclusive_arch.py /expand_exclusive_arch.py
ADD expand-exclusive-arch-all /expand-exclusive-arch-all
RUN /expand-exclusive-arch-all
