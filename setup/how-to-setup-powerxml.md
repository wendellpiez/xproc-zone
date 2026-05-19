# PowerXML - XProc/XSLT in Powershell - Setup

A Powershell-native execution framework, offering a choice of processors (Morgana IIIse or XML Calabash) and bundling their dependencies, [PowerXML](https://github.com/theturnout/powerxml) provides package management along with a runtime API for XProc and XSLT, including both Morgana and XML Calabash as XProc processor options. (It bundles Java and C distributions as needed, and may require dependencies on your machine.)

PowerXML has been developed for internal use at [theturnout.org](theturnout.org), and is kindly made available to XProc users for experiment. For Powershell users, this gives you a no-fuss installation offering both major processors along with Saxon (for XSLT) and a couple of other tools (for XSD support).

To use PowerXML, navigate to the [code repository](https://github.com/theturnout/powerxml) and follow the instructions provided.

---

### XXX TBD - Dynamic PowerXML - DPX

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

NB - XAML is, of course, XML-based

