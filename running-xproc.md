# Running XProc

Since the Zone must be open to exploration, some remarks are in order regarding XProc, the technology stack under the Zone, with some guidance on getting started with it.

As a back-end technology, XProc supports many deployment models. As a declarative language it is (in conception) "side-effect free" but that does not make it ineffective. Its capabilities in application are in its interfaces for reading data from and writing to file systems and networked resources using common protocols. This lets us bring information into XProc, and to expose and secure information rendered by XProc, out here (out there?) in the real world. The Zone is here and gone.

In a perfect world, there will be many options for running XProc. Today, professional XProc developers may want to use tools such as [oXygen XML Editor](https://www.oxygenxml.com/) (or [Developer](https://www.oxygenxml.com/xml_developer.html)), an Integrated Development Environment (IDE). Check to see if you already have an XProc 3.0/3.1 engine in your setup.

For learners and those just experimenting and evaluating, free tools are enough.

## Command-line tools

One option available to everyone is to run an available XProc engine from the command line. As it provides a level basis for everyone, everything on this repository is built to work from a command line or shell script, including under CI/CD (continuous integration/development). This offers versatility along with platform independence.

Open source processors that can execute your XProc pipelines using command-line invocations include [Morgana XProc III-se][morgana] and [XML Calabash 3][xmlcalabash3]. This repository provides instructions for using Morgana III-se, while on occasion XML Calabash may also be used, as documented.

### Setting up Morgana XProc III-se for the project

Those without an XProc 3.0 processor can install one. See the file [setup/morgana-setup.md](setup/morgana-setup.md).

[Morgana][morgana] is implemented in Scala by Achim Berndzen, on a Java platform. It is lightweight, fast, conformant, and extensible: this installation supports Schematron and XSpec as well as supported standard features including XSLT and XQuery (using Saxon).

Morgana is open source software licensed under the [GNU General Public License (GPL) 3](http://www.gnu.de/documents/gpl-3.1.en.html).

### Using XML Calabash for the project

Another recommendation is [XML Calabash](xmlcalabash3). For this project, consider it the 'second-line' processor, useful for:

- Confirming standards conformance by replicating functionality
- Testing, if and as XProc conformance ever becomes a question
- Some features not supported in Morgana XProc III-se

The intent is that one should fairly expect that pipelines written for one processor, except where documented as such, should work the same way in the other (produce the same results for the same inputs). Where and insofar as this expectation is met, we similarly have some assurance (in principle) of the *survivability* and *viability* of the code base, apart from today's platforms. One can dream.

And the practical impact is that if you are already running XML Calabash, you can continue to do so with pipelines published here, in the Zone.

XML Calabash is built in Java by Norm Tovey-Walsh of Saxonica. A rebuild of its XProc 1.0 progenitor, it is full-featured and well tested in the field. It is open source software licensed under the MIT License (use and distribute freely with acknowledgement).

Java developers should check their Maven repositories for XML Calabash 3.0.

### Java platform dependency

Either recommended processor requires Java to run.

Provided runtimes were tested using OpenJDK 17. On Windows, the Microsoft distribution has been unproblematic.

### Running pipelines

Two scripts at the top level are provided, for running the Morgana processor as 

#### Smoke test pipelines

In the folder [setup/smoketest/](setup/smoketest/) are several simple 'smoke test' pipelines for testing your XProc engine as configured.

#### Project pipelines

XProc pipelines (`.xpl` files) may be found throughout the XProc Zone, both dedicated to projects and at large. Projects will include standalone pipelines but may also contribute to portal production. Generic pipelines may be used across projects, and for higher-order tasks such as validating the XProc pipelines themselves against a set of rules defined for the repository.

The portal may be regarded as a project in itself, while:

- It is not stored in [projects/](projects) but in [its own folder](portal/)
- It produces static outputs to be committed to the repository with the project, not only as an archive but an ongoing publication, in [pub/](pub/). This folder is served from a web site to produce the XProc Zone Portal.
- Building the portal entails running one or more pipelines that may include, in production, calls to resources and pipelines in other projects

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

