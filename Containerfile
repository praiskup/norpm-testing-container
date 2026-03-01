FROM registry.fedoraproject.org/fedora:44@sha256:493b5381c34aa38d6054f5b958597610e0900f73ae301f49fd12355143d6023d

RUN dnf -y install python3-specfile \
                   redhat-rpm-config \
                   rpm-build \
                   golang-oras \
                   python3-lark \
      --enablerepo updates-testing \
    && dnf clean all

RUN oras pull quay.io/norpm/rawhide-specfiles@sha256:fb8f8be90b25dd7d38f587553ffc9806566bf2618b8022dd29543596b14dcbc4

RUN tar xf rpm-specs-latest.tar.xz

ADD https://raw.githubusercontent.com/praiskup/norpm-macro-overrides/refs/heads/main/distro-arch-specific.json /
ADD rpmspec-epoch-version /rpmspec-epoch-version
RUN /rpmspec-epoch-version

ADD exclude-statements /exclude-statements
RUN /exclude-statements

ADD expand_exclusive_arch.py /expand_exclusive_arch.py
ADD expand-exclusive-arch-all /expand-exclusive-arch-all
RUN /expand-exclusive-arch-all
