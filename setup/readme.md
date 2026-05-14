# Local XProc Setup

Need help, have an update or a correction? [please make an Issue](https://github.com/usnistgov/oscal-xproc3/issues) or (better) [a PR](https://github.com/usnistgov/oscal-xproc3/pulls).

This page offers instructions (updated from time to time) on using utilities provided to install

- [XML Calabash](https://docs.xmlcalabash.com/) - an XProc 3.0/3.1 processor developed by Norm Walsh ([Saxonica](https://www.saxonica.com/welcome/welcome.xml))
- [Morgana XProc IIIse](https://www.xml-project.com/morganaxproc-iiise.html) - another XProc 3.0/3.1 processor by Achim Berndzen ([xmlProject](https://www.xml-project.com/))
- [PowerXML](https://github.com/theturnout/powerxml) - experimental Powershell wrapper for either (both) the forementioned (the [Turnout](https://turnout.rocks/))

XProc pipelines (other things being equal) can be run with any **one** of these - you do not need any, or all. (The variables will be around the edges with respect to the feature sets of the processors.)

Because any conformant XProc 3.0/3.1 setup should work with pipelines in this repository, also feel free to use any installation and configuration you have (including XProc applications under development) and report back interesting findings.

Keep in mind these are all moving targets and at some time soon the information here will be out of date.

See [THIRD_PARTY_LICENSES.md](../THIRD_PARTY_LICENSES.md) for licensing information on the products and open-source initiatives - of special interest when you plan to modify or extend the Zone.

## How to run XProc pipelines?

Having the capability puts you one step away from running the pipelines - next what?

Using scripts offered, you can run pipelines using appropriate arguments (varying per processor). It is especially easy to run a standalone pipeline (so called because it requires no runtime bindings or options to work), such as (using a batch script):

```
> xc.bat ./path/to/PIPELINE.xpl
```

where `PIPELINE.xpl` is an XProc file.

Do we really live this way? Yes, we do, until we no longer have to. Some day XProc may be available in tools you use every day casually, with no extra effort and no console window.

For those who really can't stand the command line, alternatives today (2026) include:

- Using a batch file or script file to support drag and drop in the GUI (this has been demonstrated on Windows)
- Creating a file association between XProc files and a script or batch file invoking an engine, so it runs on **File Open**
- Skipping the scripts and downloads and acquiring a commercial product that supports XProc - (oXygen XML has nice [trial license](https://www.oxygenxml.com/xml_editor/register.html) on request)


## Downloading PowerXML - XProc/XSLT in Powershell

A Powershell-native execution framework, offering a choice of processors (Morgana IIIse or XML Calabash) and bundling their dependencies, [PowerXML](https://github.com/theturnout/powerxml) provides package management along with a runtime API for XProc and XSLT, including both Morgana and XML Calabash as XProc processor options. (It bundles Java and C distributions as needed, and may require dependencies on your machine.)

PowerXML has been developed for internal use at [theturnout.org](theturnout.org), and is kindly made available to XProc users for experiment. For Powershell users, this gives you a no-fuss installation offering both major processors along with Saxon (for XSLT) and a couple of other tools (for XSD support).

To use PowerXML, navigate to the [code repository](https://github.com/theturnout/powerxml) and follow the instructions provided.

## Downloading and using a Java-based engine 

If Powershell is not your thing, or if you need closer control over versioning in the toolset, another alternative is to run XProc directly using Java from the command line. Scripts in the repository provide shells for executing either XML Calabash or Morgana IIIse, whichever you decide to make available.

In this folder (setup) can be found scripts for downloading and unpackaging the respective libraries:

- `setup-morgana.sh` (bash) or `setup-morgana.ps1` (Powershell) to set up Morgana
- `setup-xml-calabash.ps1` to set up XML Calabash (again with apologies, as bash users will have to figure it out)

### Which do I pick?

At time of writing, the Morgana installation weighs 20MB unzipped. The XML Calabash installation (with all included `.jar` files) weighs 180MB. XML Calabash seeks to be all-in-one, whereas Morgana seeks to be lean-but-extensible.

Use Morgana if:

- You want something fast, lightweight and conformant
- You are considering upgrading to Morgana IIIee, for its performance, extensibility and product support
- You want your installation to be as small as possible and don't mind the extra work that entails (installing libraries)

Use XML Calabash if:

- You need features that don't come with freely-distributed Morgana IIIse, such as XSL-FO or `p:markdown-to-html` (or you can't say you won't need them and prefer to have them in case)
- You want to acquire everything together rather than installing extra libraries for some features

Use *both* if:

- You plan to test for actual portability, not just portability in principle
- You wish to be able to rule out processor bugs (by cross-testing) when diagnosing deep problems
- You are building an XProc engine and wish to compare against other implementations known to be conformant

Finally, being able to call on expert assistance from someone who knows is a good reason to use either processor.

### Set up Morgana

Run a script to download Morgana. Then run XProc pipelines to install its dependencies for extended capabilities: XSLT 3.0; Schematron; XSpec.

With Java and `bash`, run `./setup-morgana.sh` to set up. `curl` and `unzip` must be available on your command line.

Alternatively, with Windows Powershell and Java, run `setup-morgana.ps1`.

Alternatively, Morgana can be downloaded from [its repository]( https://sourceforge.net/projects/morganaxproc-iiise/files).

  - Get the latest `.zip`, don't worry about source code
  - Unzip it into the repository (top-level) `lib` directory (not a project `lib`)
    - Then you can use the scripts unaltered
    - Though you should still inspect and adjust them

In the `lib` folder is also the [Morgana configuration file](../lib/morgana-config.xml), which can be consulted and edited to switch out or add available libraries for Morgana.

The [Morgana IIIse User Manual](https://www.xml-project.com/manual/index.html) also provides installation and configuration help.

With Morgana in place, you can proceed to run pipelines using only basic capabilities. Since you probably need XSLT and possibly other features, your next step might be to download libraries (using XProc) as follows:

#### Drop in Saxon-HE

Other capabilities described here may not be essential but XSLT is more or less a *sine qua non* for XProc. It comes with support built in for XSLT 1.0. For XSLT 3.0 you want the open-source Saxon-HE engine.

The utility pipeline [lib/GRAB-SAXON.xpl](lib/DOWNLOAD-SAXON.xpl) is provided to download and extract Saxon-HE for Morgana.

Or, download Saxon-HE 12.8 (or other version if/as needed) at https://www.saxonica.com/download/SaxonHE12-8J.zip

  - Unzip and copy `saxon-he-12.8.jar` into the new `MorganaXProc-IIIse/MorganaXProc-IIIse_lib`
  - Take care no other versions of Saxon are present (which might conflict)
  - Discard the rest if unwanted - keeping the zip file intact for the license information etc.

If you wish to run a licensed copy of a more capable Saxon (with its optimizations and extensions), this is possible! using either XProc engine, with a configuration. But this goes beyond the (open-source) edge of the Zone.

#### Acquire SchXSLT OR SchXSLT2 for Schematron support

If you want to be able to run ISO Schematron for validation, use one of these libraries (well-tested or newer-and-nicer).

Use SchXSLT if you are also using XSpec, which wants the same library; SchXSLT2 if not.

Use [DOWNLOAD-SCHXSLT2.xpl](DOWNLOAD-SCHXSLT2.xpl) to pull down SchXSLT2 and [DOWNLOAD-SCHXSLT.xpl](DOWNLOAD-SCHXSLT.xpl) for older SchXSLT. 

Or, by hand - find [David Maus's SchXSLT](https://codeberg.org/SchXslt) on Codeberg. You want the distribution file that provides XProc support.

#### Acquire XSpec for XSpec support

Use [DOWNLOAD-XSPEC.xpl](DOWNLOAD-XSPEC.xpl) to pull down XSpec, and [DOWNLOAD-SCHXSLT.xpl](DOWNLOAD-SCHXSLT.xpl) to acquire SchXSLT (a dependency).

This is an older XSpec - the new XSpec on deck (at writing), XSpec 4.0, will not require the SchXSLT component.

#### Skip these downloads

Alternatively, developers who already have these libraries can configure to use available copies rather than downloading them - see the [lib/readme.md](lib/readme.md).

- For Saxon, provide the Saxon `jar` to the Morgana runtime (the pipeline does this by copying it into Morgana's `lib` directory; classpath incantations also work).

- For SchXSLT, edit the [Morgana configuration](lib/morgana-config.xml) or use a different configuration when invoking Morgana.

- for XSpec, edit the top-level [XSpec execution pipeline](xspec/xspec-execute.xpl) or any pipeline that calls into XSpec directly.

### Set up XML Calabash

As an alternative, a [Powershell script to set up XML Calabash](setup-xml-calabash.ps1) is also available.

XML Calabash is a little simpler to set up since it comes all-in-one with its dependencies included.

If you can't run this script you can follow what it does by hand - essentially, download XML Calabash and unzip into the correct location.

#### XSpec and XML Calabash

The same distribution of XSpec described above also works with XML Calabash.

Saxon-HE and Schematron come with XML Calabash and do not require separate downloads.

### Check your paths

The scripts [xz.sh](xz.sh) and [xz.bat](xz.bat) call scripts in the Morgana distribution. If the path to Morgana changes, or the path to the Morgana configuration file, these scripts must be updated to work.

Same for the scripts [xc.bat](xc.bat) and [xc.ps1](xc.ps1) calling XML Calabash.

See [Morgana documentation](https://www.xml-project.com/manual/index.html) for more support on running Morgana and XProc, including [Saxon configuration](https://www.xml-project.com/manual/ch02.html#configuration_s1_1_s2_2).

Similarly, [XML Calabash](https://docs.xmlcalabash.com/userguide/current/index.html) has its own set of special capabilities

## How to run XProc (more detail)

At the repository root, four scripts are offered, all of which do the same thing - invoke an XProc engine to execute an XProc pipeline. Use the one that works best on your system.

- `xc.bat` - DOS batch file running XML Calabash (installed in `lib`)
- `xc.ps1` - Windows Powershell script running XML Calabash
- `xz.bat` - DOS batch file running Morgana IIIse (installed in `lib`)
- `xz.sh`  - bash shell for Morgana IIIse

A bash shell script for XML Calabash or a Powershell script for Morgana can be contrived from these as well.

As described above, there are many other ways ...

### Why all these options?

There is no single way to run commodity software, by definition. The options offered are not the only or "correct" options. Powershell and `bash` alternatives have their own advantages, and these are only a few. YMMV.

### Hints and tips

Consider putting the repository path on your system PATH for greater convenience using the command line to run pipelines.

On a Windows system it is also possible to associate an entire file type (such as `*.xpl`) with a a `bat` file executable - offering a convenient way to run standalone XProc pipelines requiring no special runtime settings, with the **Open** choice on the context menu (right click on file) in Explorer.

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

---

