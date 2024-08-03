# Find direct children nodes by tag
#
# compared with `std/xmltree.findAll(...)`: find nodes by tag recursively
#
iterator children(node: XmlNode, tag: string): XmlNode =
  for e in node:
    if e.kind() != xnElement or e.rawTag() != tag:
      continue
    yield e
