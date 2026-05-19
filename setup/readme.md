# Local XProc Setup

***Play testers wanted***

Need help, have an update or a correction? [please make an Issue](https://github.com/usnistgov/oscal-xproc3/issues) or (better) [a PR](https://github.com/usnistgov/oscal-xproc3/pulls).

XProc is a declarative language that works at a high level of abstraction. Think of an XProc as an operational specification for a set of regular processes applied to a data stream (one or many documents). XProc is at home with XML and plays nice with JSON, HTML, and plain text-based formats.

To run XProc in 2026, you can use any of the following XProc engines:

- [XML Calabash](https://docs.xmlcalabash.com/) - an XProc 3.0/3.1 processor developed by Norm Walsh ([Saxonica](https://www.saxonica.com/welcome/welcome.xml))
- [Morgana XProc IIIse](https://www.xml-project.com/morganaxproc-iiise.html) - another XProc 3.0/3.1 processor by Achim Berndzen ([xmlProject](https://www.xml-project.com/))
- [PowerXML](https://github.com/theturnout/powerxml) - experimental Powershell wrapper for either (both) the forementioned (the [Turnout](https://turnout.rocks/))

Each of these is described further in its own *How To Set Up* file. Expert users might wish to adapt the scripts offered or bypass them altogether. (Each installation also has its own setup help, more generic than what is given here.)

- [How to set up Morgana IIIse](./how-to-setup-morgana.md)
- [How to set up XML Calabash](./how-to-setup-xmlcalabash.md)
- [How to set up PowerXML](./how-to-setup-powerxml.md)

If in doubt as to which to choose, give the documentation a look (more info is given below) and then decide. They are all open source projects with liberal license terms.

Alternatively, because any conformant XProc 3.0/3.1 setup should work with pipelines in this repository, also feel free to use any installation and configuration you have (including XProc applications under development) and report back interesting findings.

Keep in mind these are all moving targets and at some time soon the information here will be out of date.

See [THIRD_PARTY_LICENSES.md](../THIRD_PARTY_LICENSES.md) for licensing information on the products and open-source initiatives - of special interest when you plan to modify or extend the Zone.

## Which do I pick?

At time of writing, the Morgana installation weighs 20MB unzipped. The XML Calabash installation (with all included `.jar` files) weighs 180MB. XML Calabash seeks to be all in one, whereas Morgana seeks to be lean but extensible.

PowerXML includes either processor or both, depending on which one you opt to use from within Powershell.

Use PowerXML if:

- You like Powershell and wish a single unified interface
- Or, you are okay with it and you know you wish to use both processors


If you fall into neither category, use Morgana if:

- You want something fast, lightweight and conformant
- You are considering upgrading to Morgana IIIee, for its performance, extensibility and product support
- You want your installation to be as small as possible and don't mind the extra work that entails (installing minimal libraries), when necessary

Use XML Calabash if:

- You need features that don't come with freely-distributed Morgana IIIse, such as XSL-FO or `p:markdown-to-html` (or: you can't say you won't need them and prefer to have them in case)
- You want to acquire everything together rather than installing extra libraries for some features

Use *both* (or again, PowerXML) if:

- You plan to test for actual portability, not just portability in principle
- You wish to be able to rule out processor bugs (by cross-testing) when diagnosing deep problems
- You are building an XProc engine and wish to compare against other implementations known to be conformant

Finally, being able to call on expert assistance from someone who knows is a good reason to use either processor.

### Why so many options?

There is no single way to run commodity software, by definition. The options offered are not the only or "correct" options. (It is not unlikely XProc or XSLT are already running somewhere on your system you can't see.) The cost of this freedom is you have to choose one, or live with many.

### Try your own XProc engine

If you already have either Morgana XProc IIIse or XML Calabash 3.0, fire away!

XProc is a standard so we are interested in any findings of variances between processors attempting, and generally shown, to be conformant.

## Test your installation

Both processors come with basic 'HELLO WORLD' installation testing, but tests in this repository are more extensive and exhaustive, especially with respect to testing dependencies.

The same set of SMOKETEST pipelines will work for all processors. Run them using a script provided or by any other favored means of invoking Java applications.

### Using the scripts, check your paths

The scripts [xz.sh](xz.sh) and [xz.bat](xz.bat) call scripts in the Morgana distribution. If the path to Morgana changes, or the path to the Morgana configuration file, these scripts must be updated to work.

Same for the scripts [xc.bat](xc.bat) and [xc.ps1](xc.ps1) calling XML Calabash.

Scripts in other shells or with other usage should be straightforward to contrive based on these examples.

### Run the smoke tests

Because it reduces to (nearly) the most minimal use of XProc, if the [smoke test](./smoketest/TEST-XPROC3.xpl) application doesn't work, nothing can be expected to work.

Likewise, tests are provided that can show that XSLT and Schematron capabilities are correctly provided for (by the Saxon and SchXSLT libraries). See [TESTING.md](TESTING.md) for more information.

- [smoketest/TEST-XSLT.xpl](smoketest/TEST-XSLT.xpl)
- [smoketest/TEST-SCHEMATRON.xpl](smoketest/TEST-SCHEMATRON.xpl)
- [smoketest/TEST-XSPEC.xpl](smoketest/TEST-XSPEC.xpl)

Note that since Schematron and XSpec depend on XSLT and hence invoke Saxon, the Saxon-only smoketest can often be skipped.

### Smoke tests work, but a pipeline does not?

If the smoke tests work, but a pipeline does not function correctly, any problem is most likely not with installation or configuration, but with the pipeline itself, or in a resource that it reads or requires.

XProc being XML-centric, you will typically see information about errors and warnings in XML format. While this arguably compromises their legibility on the screen, generally speaking the messages embedded are fairly helpful. And this XML is very useful for other purposes, as it can be captured and processed.

Any problems with any pipelines on this site (or any pipelines not otherwise called out in documentation or comments) can be [reported](https://github.com/wendellpiez/xproc-zone/issues). Of course, if your aim is to learn XProc and related tech, we also hope you are looking at useful error messages very soon - signposts on your journey.

## How to run XProc (more detail)

At the repository root, four scripts are offered, all of which do the same thing - invoke an XProc engine to execute an XProc pipeline. Use the one that works best on your system.

- `xc.bat` - DOS batch file running XML Calabash (installed in `lib`)
- `xc.ps1` - Windows Powershell script running XML Calabash
- `xz.bat` - DOS batch file running Morgana IIIse (installed in `lib`)
- `xz.sh`  - bash shell for Morgana IIIse

A bash shell script for XML Calabash or a Powershell script for Morgana can be contrived from these as well.

As described above, there are many other ways ...

### Hints and tips

If you plan to run XProc from a command line, consider putting the repository path on your system PATH for greater convenience, making the repository scripts (or your versions of them) available across your system.

On a Windows system it is also possible to associate an entire file type (such as `*.xpl`) with a a `bat` file executable - offering a convenient way to run standalone XProc pipelines requiring no special runtime settings, with the **Open** choice on the context menu (right click on file) in Explorer. The same, or the equivalent, is possible in other operating system shells.

### No network

Nothing in this stack should require an Internet connection to work, once it is installed and running.

Note that this does not mean that a processor might not attempt to connect without your knowledge, such as (painful example) to download a copy of the W3C SVG 1.0 DTD every time an SVG is called with a presribed DOCTYPE. (Solution: do without the DTD.) Keep an eye on your data and processes since this is where such dependencies are often hidden. The typical symptom of this problem is that your XProc engine hangs up.


---

