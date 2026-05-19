
# Morgana XProc IIIse (Java) - Setup

- [Morgana IIIse home page](https://www.xml-project.com/morganaxproc-iii.html)

Run a script to download Morgana. Then run XProc pipelines to install its dependencies for extended capabilities: XSLT 3.0; Schematron; XSpec.

- With Java and `bash`, run `./setup-morgana.sh` to set up. `curl` and `unzip` must be available on your command line.

- Alternatively, with Windows Powershell and Java, run `setup-morgana.ps1`.

- Alternatively, Morgana can be downloaded from [its repository]( https://sourceforge.net/projects/morganaxproc-iiise/files).

  - Get the latest `.zip`, don't worry about source code
  - Unzip it into the repository (top-level) `lib` directory (not a project `lib`)
  - Rename the folder containing Morgan and its libraries to `MorganaXProc-IIIse`

In the `lib` folder is also the [Morgana configuration file](../lib/morgana-config.xml), which can be consulted and edited to switch out or add available libraries for Morgana.

The [Morgana IIIse User Manual](https://www.xml-project.com/manual/index.html) also provides installation and configuration help.

With Morgana in place, you can proceed to run pipelines using only basic capabilities. For XSLT 3.0/3.1 you need Saxon-HE (or other version with license). For this and other features (see below) your next step might be to download libraries (using XProc) as described below.

You can skip downloading and testing any libraries you know you will not be using.

## Drop in Saxon-HE

Other capabilities described here may not be essential but XSLT is more or less a *sine qua non* for XProc. It comes with support built in for XSLT 1.0. For XSLT 3.0 you want the open-source Saxon-HE engine.

The utility pipeline [lib/GRAB-SAXON.xpl](lib/DOWNLOAD-SAXON.xpl) is provided to download and extract Saxon-HE for Morgana.

Or, download Saxon-HE 12.8 (or other version if/as needed) at https://www.saxonica.com/download/SaxonHE12-8J.zip

  - Unzip and copy `saxon-he-12.8.jar` into the new `MorganaXProc-IIIse/MorganaXProc-IIIse_lib`
  - Take care no other versions of Saxon are present (which might conflict)
  - Discard the rest if unwanted - keeping the zip file intact for the license information etc.

If you wish to run a licensed copy of a more capable Saxon (with its optimizations and extensions), this is possible! using either XProc engine, with a configuration. But this goes beyond the (open-source) edge of the Zone.

## Acquire SchXSLT OR SchXSLT2 for Schematron support

If you want to be able to run ISO Schematron for validation, use one of these libraries (well-tested or newer-and-nicer).

Use SchXSLT if you are also using XSpec, which wants the same library; SchXSLT2 if not.

Use [DOWNLOAD-SCHXSLT2.xpl](DOWNLOAD-SCHXSLT2.xpl) to pull down SchXSLT2 and [DOWNLOAD-SCHXSLT.xpl](DOWNLOAD-SCHXSLT.xpl) for older SchXSLT. 

Or, by hand - find [David Maus's SchXSLT](https://codeberg.org/SchXslt) on Codeberg. You want the distribution file that provides XProc support.

## Acquire XSpec for XSpec support

Use [DOWNLOAD-XSPEC.xpl](DOWNLOAD-XSPEC.xpl) to pull down XSpec, and [DOWNLOAD-SCHXSLT.xpl](DOWNLOAD-SCHXSLT.xpl) to acquire SchXSLT (a dependency).

This is an older XSpec - the new XSpec on deck (at writing), XSpec 4.0, will not require the SchXSLT component.
