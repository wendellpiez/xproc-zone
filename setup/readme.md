# Local XProc Setup

This folder provides scripts and utilities for setting up a local installation of a conformant XProc 3.0 processor, either or both Morgana XProc IIIse or XML Calabash.

Because any conformant XProc 3.0/3.1 setup should work with pipelines in this repository, you should otherwise and also feel free to use any installation and configuration you have (including XProc applications under development) and report back interesting findings.
See [THIRD_PARTY_LICENSES.md](../THIRD_PARTY_LICENSES.md) for licensing information on the products and open-source initiatives - of special interest when you plan to modify or extend the Zone.

Third-party software applications today may come with XProc support: use one of the approaches described here if you have no such tool and no interest in acquiring one.

## Using Powershell - PowerXML XProc/XSLT

Some users might prefer a Powershell-native execution framework, offering a choice of processors (Morgana IIIse or XML Calabash) and bundling their dependencies.

[PowerXML](https://github.com/theturnout/powerxml) is a Powershell-based application wrapper providing XSLT and XProc capabilities, which includes both Morgana and XML Calabash as XProc processor options. It was developed at theturnout.org for internal use but is available for experiment. (If you use this tool, please also support this effort.) No warranty is offered.

Powershell has its own dependencies as does any tool, as documented: the tradeoff is that PowerXML can offer everything packaged together in a way that makes deployment simple for the script writer (if anything can be 'simple' in a shell scripting language).

## Using Java 

If Powershell is not your thing, you can run XProc directly from the command line. Download one or both processors (utilities are offered here), and try them out.

Use Morgana if:

- You want something fast, lightweight and conformant
- You are considering upgrading to Morgana IIIee, for its performance, extensibility and product support

Use XML Calabash if:

- You need features that don't come with 'vanilla' Morgana IIIse such as iXML or XSL-FO

(Morgana can use an open-source iXML processor, but [it needs setup](https://www.xml-project.com/manual/ch02.html#configuration_s1_1_s2_7).)
 
Use both if:

- You are troubleshooting a deep problem and wish to rule out processor bugs as a possible cause
- You want to test for actual portability, not just portability in principle
- You are building an XProc engine and wish to compare against other implementations known to be conformant

### Set up Morgana

With Java and `bash`, run `./setup-morgana.sh` to set up. `curl` and `unzip` must be available on your command line.

Alternatively, with Windows Powershell and Java, run `setup-morgana.ps1`.

Or, by hand --

Morgana can be downloaded from  https://sourceforge.net/projects/morganaxproc-iiise/files

  - Get the latest `.zip`, don't worry about source code
  - Unzip it into a top-level `lib` directory
    - Create the directory if necessary
    - Take care to place in the repository `lib`, not in a project folder's `lib`.

#### Drop in Saxon-HE

The utility pipeline [lib/GRAB-SAXON.xpl](lib/GRAB-SAXON.xpl) is provided to download and extract Saxon-HE for Morgana.

Or, by hand - for version 12.3 (or adjusted for a version 12.x), download Saxon-HE 12.3 at https://www.saxonica.com/download/SaxonHE12-3J.zip

  - Unzip and copy `saxon-he-12.3.jar` into the new `MorganaXProc-IIIse-{version}/MorganaXProc-IIIse_lib`
  - Take care no other versions of Saxon are present (which might conflict)
  - Discard the rest if unwanted - keeping the zip file intact for the license information etc.

(TODO May 2026 - this download can be updated to Saxon 12.8 ...)

##### Note on Saxon versions (in Morgana)

We have successfully run with versions Saxon-HE 12.3 and 12.5, with the runtime flag ` -xslt-connector=saxon12-3` when invoking Morgana. ([As noted on the Morgana web site](https://www.xml-project.com/manual/ch02.html#configuration_s1_1_s2_2) this configuration should be forward compatible).

We are also doing our best to track versions of Saxon -- as you may see if GRAB-SAXON actually grabs a later version -- be that as may be, developers who have success with later versions and reasons to need a Saxon upgrade should [please make an Issue](https://github.com/usnistgov/oscal-xproc3/issues) or (better) [a PR](https://github.com/usnistgov/oscal-xproc3/pulls).

#### Acquire SchXSLT for Schematron support

Use [lib/GRAB-SCHXSLT.xpl](lib/GRAB-SCHXSLT.xpl) to pull down SchXSLT.

Or, by hand - find [David Maus's SchXSLT](https://github.com/schxslt/schxslt) on Github. The [distribution you want](https://github.com/schxslt/schxslt/releases/download/v1.9.5/schxslt-1.9.5-xproc.zip) provides XProc support.

(TODO May 2026 - update?)

#### Acquire XSpec for XSpec support

Use [lib/GRAB-XSPEC.xpl](lib/GRAB-XSPEC.xpl) to pull down XSpec.

(TODO May 2026 - update?)

#### Skip these downloads

Alternatively, developers who already have these libraries can configure to use available copies rather than downloading them - see the [lib/readme.md](lib/readme.md).

- For Saxon, provide the Saxon `jar` to the Morgana runtime (the pipeline does this by copying it into Morgana's `lib` directory; classpath incantations also work).

- For SchXSLT, edit the [Morgana configuration](lib/morgana-config.xml) or use a different configuration when invoking Morgana.

- for XSpec, edit the top-level [XSpec execution pipeline](xspec/xspec-execute.xpl) or any pipeline that calls into XSpec directly.

### Set up XML Calabash

As an alternative, a [Powershell script to set up XML Calabash](setup-xml-calabash.ps1) is also available.

XML Calabash is a little simpler to set up since it comes all-in-one with its dependencies included.

If you can't run this script you can follow what it does by hand - essentially, download XML Calabash and unzip into the correct location.

### Check your paths

The scripts [xz.sh](xz.sh) and [xz.bat](xz.bat) call scripts in the Morgana distribution. If the path to Morgana changes, or the path to the Morgana configuration file, these scripts must be updated to work.

Same for the scripts [xc.bat](xc.bat) and [xc.ps1](xc.ps1) calling XML Calabash.

See [Morgana documentation](https://www.xml-project.com/manual/index.html) for more support on running Morgana and XProc, including [Saxon configuration](https://www.xml-project.com/manual/ch02.html#configuration_s1_1_s2_2).

## Try your own XProc engine

If you already have either Morgana XProc IIIse or XML Calabash 3.0, fire away!

XProc is a standard so we are interested in any findings of variances between processors attempting, and shown, to be conformant.

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

Any problems with any pipelines on this site (or any pipelines not otherwise called out in documentation or comments) can be [reported](https://github.com/wendellpiez/xproc-zone/issues). Of course, if your aim is to learn XProc and related tech, we also hope you are looking at useful error messages very soon - signposts on your journey.
### TBD - Dynamic PowerXML - DPX

(Conceptual and unrealized)

Powershell scripting language, like any structured language, can be produced cleanly and simply using XSLT from sources with the necessary information. An XProc pipeline is such a source. Applying templates to the XProc as XML we can produce a control interface to that pipeline in the form of a Powershell script offering not only the code for executing it (with given bindings for ports and options), but also code for standing up a Windows GUI / dialog box providing a dashboard for that pipeline:

- Ports with binding points for one or more documents
- Slots for setting options (strings)
- A button to execute the pipeline with current settings

NB we are not talking about compiling or translating XProc so much as generating the widgetry for it. It may even be possible to do this via an XML-based tech (WPF/XAML?)

See here: 

https://www.reddit.com/r/PowerShell/comments/wa8sqe/adding_a_gui_for_powershell_scripts_preferred_and/

It needs to be able to -

permit binding inputs to files and hrefs (@sequence false|true)
set options as required
assign handling to output ports
  capturing in a window (default)
  writing to file
  /dev/null
show pipeline internals?
capture runtime messages
execute

### Notes

Enable the module from a console command prompt by importing it:

> Import-Module path/to/PowerXML/powerxml.psm1 -Force

(The `-Force` setting enables a clean import over any earlier module of the same name.)

With the module imported, commands work like this:

```
>  Transform-XML -Pipeline ".\smoketest\TEST-XSLT.xpl"
```

This can also be done in a Powershell script (when there is time to learn).

---

