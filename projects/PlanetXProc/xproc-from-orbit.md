# XProc from Orbit

> Material in draft!

From a height the broader outlines come into view.

XProc is a data processing technology for digital data. While it is an XML-based technology using XML syntax, it can work with many kinds of data, including common text-based formats such as JSON.

In XProc, information processing happens by means of *pipelines*. Expressed using XML format, an XProc pipeline is both a linguistic and computational artifact, and (in developers' minds) a discrete logical entity with an internal organization: a chain or branched structure.

A pipeline combines a sequence or set of processes and applies them to specified inputs ("sources") to create outputs ("results").

This makes XProc an appropriate technology for building and supporting complex workflows in document production, data conversion, and information exchange.

## Pipelines and steps

- A pipeline is made of steps
- A pipeline can also be used as a step, when declared with or imported into another pipeline
- XProc defines libraries of standard, reusable steps for all processors, supporting many common operations
- You can also design and use new steps, in and with your own XProc

?src/starter.xpl?

?src/refresh-xml.xpl?

## How to write a pipeline

An XProc pipeline takes the form of an arrangement of steps.

?src/moresteps.xpl?

We say 'arrangement' here since steps can accommodate as many inputs and outputs as needed, connecting together.

?src/double-validate.xpl?

[Illustration: a more complex pipeline]

# XProc from Above


---

## I/O, ports and documents

- Pipelines, and steps, can accept one or more designated inputs, or none - they can accept inputs provided at runtime, or find and load data sources, or both
- Steps can also expose processing results as outputs, and also interact with your system, writing files on disk or communicating through other channels
- The connections that an XProc step exposes for data are called its **ports**
- By means of ports, we pass documents into steps and get documents out - and while XProc calls them **documents**, they can be any kind of data at all
- A pipeline can be defined with ports for connecting with other steps, when used as a step in another pipeline
- The *composability* of steps is key to the efficiency and power offered by XProc


?src/refresh-xml.xpl?

?src/_make-orbital-markup.xpl?

---

## Steps with implicit port connections

- XProc syntax can be concise - once we make room in our heads and editors for all the tags - because it has rules for you don't see ports that can be assumed to be there by the rules
- This means most of the steps you use within a pipeline will naturally operate in sequence, unless you specifically arrange to do things otherwise - we like to say they *snap together*
- The XProc feature in play here is called the [default readable port](https://spec.xproc.org/3.0/xproc/#connecting-the-drp). The concept is simple. Any step with a primary input port that is not connected explicitly, will be bound to the primary output of the immediately preceding step.
- This works well, with the caveat that steps that have no input ports don't connect like this, even when given in sequence. Know your steps.

[illustrations: three steps in sequence, with and without ports showing]


?src/moresteps.xpl?

?src/moresteps-explicit.xpl?

---

## Knowing your formats

XProc comes with native support for XML and JSON reading and parsing, for plain text inputs, and for inputs defined with regular grammars using [Invisible XML (ixml)](https://invisiblexml.org).

All of these types of data, and others, can be passed from one step to another, as long as the step can accommodate the given format or media type.

[illustration: a step showing some JSON]

---

## Powerful embedded languages

XPath, XSLT and XQuery all play well with XProc, which is designed first and foremost to accommodate these kindred technologies.

XProc steps can either invoke or embed instances of these declarative processing languages, or others.

[illustration: a step showing some XQuery?]

---

## Looking at those ports

Ports go in only one direction: they are input or output, never both. The `identity` step replicates its input on its output.

The conventional name for the primary port is "source". The conventional name for the primary output port is "result". These names correspond with the uses of these terms in XSLT and XQuery.

So every port with an input is likely to have a 'source', while every port with an output is likely to have its 'result'.

It is sometimes useful for a step to have input but no output - `p:sink` being the simple example. A few steps have no inputs or outputs, but only effects in the system, such as `p:file-touch` or `file:mk-dir` (for making a directory).

The 'source' and 'result' ports can carry sequences when the steps on which they are defined say so - and when permitted to be sequences they may also be empty (have no documents bound to them): a sequence with no members, not a single.

Ports apart from 'source' and 'result' will be secondary, and will have names indicating their roles in the operation of their steps - a good example is a 'schema' secondary input port for a validation step, which a processor uses to provide the schema.

---

## Options

In addition to inputs and outputs (connection ports), steps can also have **options**.

These provide runtime configurations when invoking steps and pipelines.

Their values can be simple (string value flags) or complex (such as map objects, or expressions to be evaluated).

Its ports and options together provide an *interface* for using a step.

Options can be set on steps using abbreviated syntax (attributes) or long syntax (`p:with-option`)

[examples in both forms]

---

## Minimal XProc

If your skills include XSLT, this might be all you ever need in XProc:

  - `p:variable`
  - `p:load`
  - `p:store`
  - `p:xslt`
  - `@serialization`
  - `@message`

Take another lesson on Day Two - learn to write a pipeline and use it as a step

  - `p:declare-step`
  - `p:input` (and `p:with-input`)
  - `p:output`
  - `p:option` and (`p:with-option`)
  - `p:library`

Three everyday utility steps

  - `p:sink`
  - `p:cast-content-type`
  - `p:identity`

---

[Step list](xproc-step-list.html)

---
