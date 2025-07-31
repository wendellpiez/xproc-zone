# XProc from Orbit

> Material in draft!

XProc is a data processing technology for digital data. While it is an XML-based technology using XML syntax, it can work with many kinds of data, including common text-based formats such as JSON.

As a language, XProc describes **pipelines**. A pipeline combines a sequence or set of processes and applies them to specified inputs ("sources") to create outputs ("results").

Use XProc to build support complex workflows in document production, data conversion, and information exchange.

---

## Pipelines and steps

- A pipeline is made of steps
- A pipeline can also be used as a step, when declared with or imported into another pipeline
- XProc defines libraries of standard, reusable steps for all processors, supporting many common operations
- You can also design and use new steps, in and with your own XProc

?src/starter.xpl? A simple pipeline with three steps.

?src/producer.xpl? Four steps, including an imported step named with a developer's (project) namespace.

---

## How to write a pipeline

An XProc pipeline takes the form of an arrangement of steps.

?src/moresteps.xpl?

We say 'arrangement' here since steps can accommodate as many inputs and outputs as needed, connecting together.

?src/double-validate.xpl?

---

# XProc From 40,000 Feet

---

## I/O, ports and documents

- Pipelines, and steps, can accept one or more designated inputs, or none - they can accept inputs provided at runtime, or find and load data sources, or both, or generate their own
- Steps can also expose processing results as outputs, and also interact with your system, writing files on disk or communicating through other channels
- The connecting points on an XProc step are called its **ports**
- By means of ports, we pass documents into steps and get documents out - and while XProc calls them **documents**, they can be pretty much any kind of data
- A pipeline can be defined with ports for connecting with other steps, when used as a step in another pipeline
- The *composability* of steps is key to the efficiency and power offered by XProc

?src/double-validate.xpl? This pipeline validates its input twice and collects validation reports into a single document.

---

## Ports, steps, sources and results

Ports go in only one direction: they are for **input** or **output**, never both. One of the input ports will be designated as **primary**, while others are **secondary**. Similarly, one and only one of the output ports may be designated as primary. Not all steps have secondary ports, but some steps make little sense without them.

The conventional name for the primary *input* port is `source`. The conventional name for the primary *output* port is `result`. These names correspond with the uses of these terms in XSLT and XQuery.

It is sometimes useful for a step to have output but no input (like `p:load`), or input with no output (like `p:sink`). And not all steps produce modifications of inputs among their outputs. For example, `p:directory-list` has no input but produces XML on its `result` port listing the contents of a file system directory.

The `source` and `result` ports can carry *sequences* when they are defined as such on their steps - and when permitted to be sequences they may also be *empty*, with no documents bound to them.

Unlike the primary ports (likely named `source` and `result`), secondary ports are given names indicating the roles they play for their steps. Good examples include the `schema` secondary input port on validation steps, which a processor uses to provide a schema, or the `insertion` port on the `p:insert` step, for the data to be inserted.

---

## Steps with implicit port connections

XProc syntax can be fairly concise and clean - at least, as XML-based formats go - because it has sensible fallback rules and some nice ways of keeping syntax simple.

One important example: as long as steps in your pipeline are to be applied in sequence, their connections do not have to be shown. It has been suggested they *snap together*.

The XProc feature in play here is called the [default readable port](https://spec.xproc.org/3.0/xproc/#connecting-the-drp). The concept is simple. Any step with a primary input port that is not connected explicitly, will be bound to the primary output of the immediately preceding step.

This works well, with the caveat that steps that have no input ports don't connect like this, even when given in sequence - and steps with no output ports can't be connected as inputs at all. Know your steps.

?src/moresteps.xpl?

?src/moresteps-explicit.xpl? The same pipeline, with connections spelled out.

---

## Knowing your formats

XProc comes with native support for XML and JSON reading and parsing, for plain text inputs, and for inputs defined with regular grammars using [Invisible XML (ixml)](https://invisiblexml.org).

All of these types of data, and others, can be passed from one step to another, as long as both steps can accommodate the given format or media type.

?src/read-json.xpl? With map and array object types, XPath 3.0/3.1 supports JSON natively. 

---

## Powerful embedded languages

XPath, XSLT and XQuery all play well with XProc, which is designed first and foremost to accommodate these kindred technologies.

XProc steps can either invoke or embed instances of these declarative processing languages, or others.

?src/some-xquery.xpl?

---

## Options

In addition to inputs and outputs (connection ports), steps can also have **options**.

These provide runtime configurations when invoking steps and pipelines.

For some steps, certain options are required, for example to designate which nodes to delete on a `p:delete` step (using the `match` option).

Values assigned to options can be simple (string value flags) or complex (such as map objects, or expressions to be evaluated).

Its ports and options together provide an *interface* for using a step.

Options can be set on steps using abbreviated syntax (attributes) or long syntax (`p:with-option`)

?src/test-landing.xpl? Parameters are sent to the stylesheet using an XProc option (in attribute syntax).

---

## Foundations of XProc

The more you know, the better you feel.

- XML syntax
- XML namespaces
- XPath (including XPath 3.0, 3.1) and XDM (XML Data Model)
- XSLT, XQuery
- REST and the web / URIs
- schema technologies, standard vocabularies, validation and workflow
- HTML/CSS/SVG, XSL-FO

---

## Minimal XProc

If your skills include XSLT, this might be all you ever need in XProc:

  - `p:declare-step`
  - `p:variable`
  - `p:load`
  - `p:store`
  - `p:xslt`
  - `@serialization`
  - `@message`

Take another lesson on Day Two - learn to write a pipeline and use it as a step

  - `p:declare-step/@type`
  - `p:input` and `p:with-input`
  - `p:output`
  - `p:option` and `p:with-option`
  - `p:library`

Three everyday utility steps

  - `p:sink`
  - `p:cast-content-type`
  - `p:identity`

---
