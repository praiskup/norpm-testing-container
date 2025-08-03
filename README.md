The norpm Testing Environment
=============================

This project aims to simplify testing for: **norpm** <https://github.com/praiskup/norpm>

The objective is:
1. To download the **latest Fedora Rawhide specfiles' tarball**
   <https://src.fedoraproject.org/lookaside/rpm-specs-latest.tar.xz>
2. Parse those spec files using the default Fedora RPM
3. Generate output from that RPM parser

By comparing this output and the output from *norpm* parser, we can define
expected and unexpected differences, and have a deterministic test-suite.

This project essentially acts as a **"cache"** for RPM output.

License
-------

For the code, kindly refer to the COPYING file.  The Fedora sources utilize the
[MIT License](https://docs.fedoraproject.org/en-US/legal/fedora-linux-license/),
or as stated in the respective specfile.
