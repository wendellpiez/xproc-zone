# XML Calabash 3.0 - Setup

- [XML Calabash User Guide](https://docs.xmlcalabash.com/userguide/current/)

First, inspect the Powershell script setup-xml-calabash.ps1.

You can run this script on a system with Powershell, or you can perform its steps by hand:

- Download XML Calabash (probably the latest stable release) from the [release download page](https://codeberg.org/xmlcalabash/xmlcalabash3/releases)
- Unzip it into the `lib` folder of this repository
- Rename its main directory to `XMLCalabash` (no version number)

## Tweak the invocation scripts

The XML Calabash runtime scripts, [xc.bat](../xc.bat) and [xc.ps1](../xc.ps1), are wired with the current version number of XML Calabash, and may need to be updated to correspond to your setting.

## XML Calabash configuration

The XProc Zone uses an XML Calabash configuration that can be adjusted for your system. See the [XML Calabash documentation](https://docs.xmlcalabash.com/userguide/current/configuration.html).

## XQuery, XSLT 3.0/3.1, Schematron

XML Calabash comes with support for these XML-based technologies in its distribution, so they do not require separate downloads.

## XSpec

For XSpec support (XQuery and XSLT unit testing), use the `DOWNLOAD-XSPEC.xpl` and `smoketest/TEST-XSPEC.xpl` pipelines as [described for Morgana](how-to-setup-morgana.md). They should work in XML Calabash as well.

This XSpec harness is due to be updated or deprecated, at time of writing, for XSpec version 4 due out June, 2026.

---
