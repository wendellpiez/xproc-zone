# Local XProc Setup

This folder provides scripts and utilities for setting up a local installaction of Morgana XProc IIIse.

We also recommend XML Calabash, and hasten to add that any conformant XProc 3.0/3.1 setup should work with pipelines in this repository. Feel free to use any installation and configuration you have (including XProc applications under development) and report back interesting findings.

The Morgana setup here is not required but is provided as an easy and low-risk way for a developer or autodidact to try XProc, before committing to other tools.



With Java and `bash`, run `./setup-morgana.sh` to set up. `curl` and `unzip` must be available on your command line.

With Windows Powershell and Java, run `setup-morgana.ps1`.

See [THIRD_PARTY_LICENSES.md](../THIRD_PARTY_LICENSES.md) for licensing information on these products and open-source initiatives.

Or, by hand --

## Install Morgana XProc IIIse

Morgana can be downloaded from  https://sourceforge.net/projects/morganaxproc-iiise/files

  - Get the latest `.zip`, don't worry about source code
  - Unzip it into a top-level `lib` directory
    - Create the directory if necessary
    - Take care to place in the repository `lib`, not in a project folder's `lib`.

### Drop in Saxon-HE

The utility pipeline [lib/GRAB-SAXON.xpl](lib/GRAB-SAXON.xpl) is provided to download and extract Saxon-HE for Morgana.

Or, by hand - for version 12.3 (or adjusted for a version 12.x), download Saxon-HE 12.3 at https://www.saxonica.com/download/SaxonHE12-3J.zip

  - Unzip and copy `saxon-he-12.3.jar` into the new `MorganaXProc-IIIse-{version}/MorganaXProc-IIIse_lib`
  - Take care no other versions of Saxon are present (which might conflict)
  - Discard the rest if unwanted - keeping the zip file intact for the license information etc.

#### Note on Saxon versions

We have successfully run with versions Saxon-HE 12.3 and 12.5, with the runtime flag ` -xslt-connector=saxon12-3` when invoking Morgana. ([As noted on the Morgana web site](https://www.xml-project.com/manual/ch02.html#configuration_s1_1_s2_2) this configuration should be forward compatible).

We are also doing our best to track versions of Saxon -- as you may see if GRAB-SAXON actually grabs a later version -- be that as may be, developers who have success with later versions and reasons to need a Saxon upgrade should [please make an Issue](https://github.com/usnistgov/oscal-xproc3/issues) or (better) [a PR](https://github.com/usnistgov/oscal-xproc3/pulls).

### Acquire SchXSLT for Schematron support

Use [lib/GRAB-SCHXSLT.xpl](lib/GRAB-SCHXSLT.xpl) to pull down SchXSLT.

Or, by hand - find [David Maus's SchXSLT](https://github.com/schxslt/schxslt) on Github. The [distribution you want](https://github.com/schxslt/schxslt/releases/download/v1.9.5/schxslt-1.9.5-xproc.zip) provides XProc support.

### Acquire XSpec for XSpec support

Use [lib/GRAB-XSPEC.xpl](lib/GRAB-XSPEC.xpl) to pull down XSpec.

### Skip these downloads

Alternatively, developers who already have these libraries can configure to use available copies rather than downloading them - see the [lib/readme.md](lib/readme.md).

- For Saxon, provide the Saxon `jar` to the Morgana runtime (the pipeline does this by copying it into Morgana's `lib` directory; classpath incantations also work).

- For SchXSLT, edit the [Morgana configuration](lib/morgana-config.xml) or use a different configuration when invoking Morgana.

- for XSpec, edit the top-level [XSpec execution pipeline](xspec/xspec-execute.xpl) or any pipeline that calls into XSpec directly.

### Check your paths

The scripts [xp3.sh](xp3.sh) and [xp3.bat](xp3.bat) call scripts in the Morgana distribution. If the path to Morgana changes, or the path to the Morgana configuration file, these scripts must be updated to work.

See [Morgana documentation](https://www.xml-project.com/manual/index.html) for more support on running Morgana and XProc, including [Saxon configuration](https://www.xml-project.com/manual/ch02.html#configuration_s1_1_s2_2).

## Try your own XProc engine

If you already have either Morgana XProc IIIse or XML Calabash 3.0, fire away!

XProc is a standard so we are interested in any findings of variances between processors thought to be conformant.

## Run the smoke tests

Because it reduces to (nearly) the most minimal use of XProc, if the [smoke test](./smoketest/TEST-XPROC3.xpl) application doesn't work, nothing can be expected to work.

Likewise, tests are provided that can show that XSLT and Schematron capabilities are correctly provided for (by the Saxon and SchXSLT libraries). See [TESTING.md](TESTING.md) for more information.

- [smoketest/TEST-XSLT.xpl](smoketest/TEST-XSLT.xpl)
- [smoketest/TEST-SCHEMATRON.xpl](smoketest/TEST-SCHEMATRON.xpl)
- [smoketest/TEST-XSPEC.xpl](smoketest/TEST-XSPEC.xpl)

Note that since Schematron and XSpec depend on XSLT and hence invoke Saxon, the Saxon-only smoketest can often be skipped.

### Smoke tests are working but a pipeline doesn't

If the smoke tests work, but a pipeline does not function correctly, any problem is most likely not with installation or configuration, but with the pipeline itself, or in a resource that it reads or requires.

XProc being XML-centric, you will typically see information about errors and warnings in XML format. While this arguably compromises their legibility on the screen, generally speaking the messages embedded are fairly helpful. And this XML is very useful for other purposes, as it can be captured and processed.

Any problems with any pipelines on this site (or any pipelines not otherwise called out in documentation or comments) should be [reported](https://github.com/usnistgov/oscal-xproc3/issues), as it is not our aim to distribute broken software. Of course, if your aim is to learn XProc and related tech, we also hope you are looking at useful error messages very soon - signposts on your journey.

---

