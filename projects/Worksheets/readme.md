# Worksheets

In this folder find a miscellaneous collection of XProc, illustrating:

- XProc usage, idioms, techniques and methods
- XPath - not beginner-level
- XSLT
- XQuery

XProc files should run standalone, or as documented.

Any standalone XSLT will either run on itself, or accept defined inputs as described.

Ideas to come:

- Format dateTime picture writer
  - provide "April 1, 2001 1:01pm" and receive a picture `[MNn] [D] [Y] [h]:[m02][Pn]` writing date-times into that format
    - In the browser under XSLT 1.0?
- format-number picture writer?
    - reverse engineer this from the spec

- PRNG functionality - cf https://github.com/wendellpiez/xslt3-functions/tree/main/random-util

- Demonstrate defining a function as a step in XProc then using it from XSLT? (XML Calabash feature)
