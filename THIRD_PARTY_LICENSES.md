# Third party licenses

Utilities in the provided installation may rely on any of these open-source software packages:

- [PowerXML](https://github.com/theturnout/powerxml), an open-source Powershell utility from [The Turnout LLC](https://github.com/theturnout)
- [XML Calabash](https://www.xmlcalabash.com/) by Norm Walsh, an XProc 3.0 implementation
- [MorganaXProc-III](https://www.xml-project.com/morganaxproc-iiise.html) from [&lt;xml-project />](https://www.xml-project.com) an XProc 3.0 implementation
- Saxon 12 from [Saxonica](https://www.saxonica.com/), an XSLT implementation
- [SchXSLT](https://github.com/schxslt/schxslt) by David Maus, a Schematron implementation
- [XSpec](https://github.com/xspec/xspec) by Jeni Tennison and XSpec developers: providing unit testing for XSLT, Schematron and XProc
- Their dependencies, including Java.

After installation as described in the [README](README.md), see the `lib` directory for these distributions and their license files, where applicable.

PowerXML is released under an MIT license as documented [in its repository](https://github.com/theturnout/PowerXML/blob/develop/LICENSE).

XML Calabash is released under an MIT license as documented [in its repository](https://codeberg.org/xmlcalabash/xmlcalabash3/src/branch/main/LICENSE).

Licenses bearing on Morgana are in its [licenses](lib/MorganaXProc-IIIse-1.3.7/licences/) folder (GPL3 and other licenses).

Saxon licenses are in the [zip file distribution for Saxon](lib/SaxonHE12-3J.zip) in the `notices` folder - `LICENSE.txt` and neighboring files.

The license for SchXSLT is at the top level of its distribution.

Additionally to these, further details on licensing will be given in any projects that rely similarly on downloaded resources.

Note that these libraries are not available from the project repository; the utility `setup.sh`, or pipelines designed for the purpose, can be run to acquire them.

---
