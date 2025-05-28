# The XProc Zone

**Dare to Learn**

For learners, users and developers of XProc, XSLT, iXML, XSpec, XQuery, Schematron, XML validation technologies (XSD, RNG), formatters and renderers (SVG, XSL-FO) and everything that comes with them.

This repository provides a test bed and proving ground for [XProc 3.0][xproc], with:

- *XProc jump start* guidance
- Demonstrations for study and adaptation
- Utilities
- Working examples

Why XProc? You have markup, data, text, XML ... you want intelligibility. You can see the gleam of semantic gold, but it hides in the murk. XML is a way of shining light on text-based data. XProc is your flashlight, your microscope, your telescope and your laser.

Beyond its utility, XProc is also an easy way in to learn the foundations of markup processing, including

  - Syntaxes and parsing - XML, plain text processing, Invisible XML (iXML)
  - Transformations - XSLT
  - Data formats and modeling - JSON, XDM/XPath, XSLT
  - Validations and validation approaches and technologies
    - XPath-based - XPath, XSLT, Schematron
    - Schema languages e.g. RNG, XSD, DTD
  - Presentation, style and format in web browsers - HTML, CSS and Javascript

## Where to start

The Zone has two regions, or manifestations: a "public" space, the Portal, with its exhibits. And the downstairs, the Repository (repo). You are reading a README.md document in the Repo: standing at the top of the stairs, looking down.

The portal may show anything in the repo, in any form, or hide things or mark or mask or transform them. *The Zone is a band of **mimesis** or representation. An area of surround.* It shows things all dressed up, not only as they actually are but as they imagine themselves to be.

The portal might seem *plain* and unremarkable: a web site. A doorway. From this drabness it is reasonable to extrapolate that the technologies at work here unseen might be at work almost anywhere. The zone is in places you don't expect: you might not ever know you are in the zone.

Explore the deeper reaches of the zone by investigating the code base, installing and running the software, and adapting and extending its pipelines and data sets.

### Clone the Zone

To understand the back end, copy this repository or use `git` to clone it; then follow hints to build projects. Use the scripts and run pipelines. Read the readmes.

You can build everything in the zone and you can build your own.

The portal is produced as a static web site, designed to be delivered from a generic web server in a default configuration. Accordingly, running your own Zone (off the network, if wanted) is easy to do, and recommended for testing.

### Security caution

Like any program on your system, an XProc engine running pipelines can be used in inappropriate and potentially destructive ways, even unintentionally. *Take care to operate and run XProc within a controlled environment where your data is backed up and secure. Do not run pipelines you do not understand and control, and take appropriate caution and counter-measures with imported libraries.*

The Zone is maintained under `git`, which helps with this problem. We have more freedom to operate and experiment on our systems when we also have the option of restoring them from known checkpoints.

Since the biggest risk of automation has always been stepping on one's own feet -- at scale -- remember the corollary to Murphy's Law: *if it won't necessarily work, it won't work*. Make necessity your friend.

### Running XProc
## Project maintenance plan

This project works under a passive maintenance plan, and is likely to see punctuated equilibrium - periods of statis, briefly interrupted by periods of growth and change.

No effort beyond `git` (distributed version control) is made at archiving earlier versions.

The best way to use this project is to assume it may disappear tomorrow, and invest accordingly. The best way to acquire long-term, secure access is to copy it.

Forks are welcome and regarded as indicators of project success. Please do!

'XXX' and 'tbd' in these documents are indicators of come-back-to items.

## History

XProc has roots going back to SGML, prior to the development of XML. (Links available on request.)

This repository builds on [an earlier initiative](https://github.com/usnistgov/oscal-xproc3) in the public domain focused on XProc applications to OSCAL, the [Open Security Controls Assessment Language](https://pages.nist.gov/OSCAL/).

---


<!-- links -->

[xdm3]: https://www.w3.org/TR/xpath-datamodel/
[xmlcalabash3]: https://github.com/xmlcalabash/xmlcalabash3 
[xslt3]: https://www.w3.org/TR/xslt-30/
[xproc]: https://xproc.org/
[xproc-specs]: https://xproc.org/specifications.html
[xspec]: https://github.com/xspec/xspec
[ixml]: https://invisiblexml.org
[morgana]: https://www.xml-project.com/morganaxproc-iiise.html
[saxon12]: https://www.saxonica.com/documentation12/documentation.xml
[schxslt]: https://github.com/schxslt/schxslt

