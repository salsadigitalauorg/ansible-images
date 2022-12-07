#!/usr/bin/env python

import re

# Borrowed from https://github.com/django/django/blob/main/django/utils/text.py
def get_valid_filename(name):
    """
    Return the given string converted to a string that can be used for a clean
    filename. Remove leading and trailing spaces; convert other spaces to
    underscores; and remove anything that is not an alphanumeric, dash,
    underscore, or dot.
    >>> get_valid_filename("john's portrait in 2004.jpg")
    'johns_portrait_in_2004.jpg'
    """
    s = str(name).strip().replace(" ", "-").replace("---", "-")
    s = re.sub(r"(?u)[^-\w.]", "", s)
    return s


class FilterModule(object):
    def filters(self):
        return {'valid_filename': get_valid_filename}
