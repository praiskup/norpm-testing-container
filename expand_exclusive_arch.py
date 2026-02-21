#! /bin/python3

"""
Extract excludearch/exclusivearch/buildarch from a specfile.
"""

import json
import logging
import sys

from specfile import Specfile


log = logging.getLogger("__main__")


class Spec:
    """
    Extract specfile tags (using RPM)
    """
    def __init__(self, path):
        self.spec = Specfile(path)
        # pylint: disable=no-member
        self.tags = self.spec.tags(self.spec.parsed_sections.package).content

    def __getattr__(self, name):
        return self.safe_attr(name)

    def get_tag(self, tagname):
        """ Get a tag value"""
        tagname = tagname.lower()
        values = []
        for tag in self.tags:
            if tag.name.lower() != tagname:
                continue
            values += [tag.value]
        return values

    def get_tags(self, tag_names):
        """Get tag values"""
        output = {}
        for tag in tag_names:
            output[tag] = self.get_tag(tag)
        return output


if __name__ == "__main__":
    output_tags = {}
    try:
        specfile = sys.argv[1]
        log.error("Handling %s", specfile)
        spec = Spec(specfile)
        output_tags = spec.get_tags(["exclusivearch", "excludearch",
                                     "buildarch"])
        print(json.dumps(output_tags, indent=4, sort_keys=True))
    except Exception:  # pylint: disable=broad-exception-caught
        print(json.dumps({"error": "???"}))
        sys.exit(1)
