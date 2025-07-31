# Planet XProc

A mini publishing framework. Markdown, TEI, HTML.

Three related operations

- Convert Markdown into a well-controlled format
- Validate against a jealous rules set for TEI-similar 'semantic' markup
  - Familiar structures (RelaxNG/RNC)
  - Referential integrity (links and type assignments) 
- Produce clean HTML for further publication

The project's combination of generalizable structural constraints (such as a TEI-compatible schema) with project-specific business rules (such as link checking) can be extended easily to cover new use cases, in many directions.

## Pipelines

### PRODUCE-FROM-MARKDOWN.xpl

Hard wired to produce file output xproc-from-orbit.xml from Markdown input [xproc-from-orbit.md](xproc-from-orbit.md).

### MAKE-PREVIEW-PAGE.xpl

Hard wired to produce an HTML reading version from the XML produced above.

### `src` folder

In `src` are some additional pipelines, both imported steps used in the top-level pipelines, and a few standalone examples for trial and testing.

(At least one of these pipelines produces an error by design - these are hands on.)

Also in `src` find folders containing XSLT and schemas - a schema composed in RNC (RelaxNG Compact Syntax), and a Schematron.

These are used to validate the file [xproc-from-orbit.xml](xproc-from-orbit.xml) against some obvious and not-so-obvious constraints.

Take a look at the code for more details.

## Testing

The stringent validations of interim results, joined to normal QA examination of final outputs, make most other kinds of testing superfluous for a 'bespoke' conversion process like this one.

However, the transformations also perform runtime dynamic testing of inputs against declared (expected) constraints. For example, a test for header nesting is performed over the Markdown source before it is converted into a well-structured result.

See the function `zone:well-nested($headers)` in [src/xslt/html-resuscitate.xsl](src/xslt/html-resuscitate.xsl). This function accepts a sequence of header elements `hN`, and returns `true()` if the sequence proceeds without stepping more than one level on its the way down the sequence. So `h3` can be followed by `h1` or `h2` (going back up), `h3` (on the same level), or `h4` (down one level) but not directly by `h5`. (An `h4` must come first.)

This rule ensures that a simple grouping algorithm can properly nest all implied sections (that is, sections as represented implicitly by headers as demarcators) without dealing with ambiguous interpolations. (In the case just given, does an `h5` following `h3` indicate a fourth-level nesting, or something else?)

The function can be tested by violating this rule and watching the conversion processor balk.

Also, the function itself is tested in [an XSpec](src/xslt/header-nesting.xspec).

## Dynamic transclusion of examples

This pipeline uses XInclude to graft example files directly into the result renderings.

This is supported by a simple syntactic convention in the Markdown source.

## Directions for development

- Try other Markdown file instances

---
/wap/20250729

