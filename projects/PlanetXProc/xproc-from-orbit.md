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

?src/starter.xpl? A simple pipeline with three steps

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

[illustrations: three steps in sequence, with and without ports showing]

---

## How to call a step

One type of step with a single input port is `p:identity` - it produces a document (or sequence of documents) without changes, on its single output port.

A step with two input ports is `p:xslt` - it accepts source documents on one port (`source`) and a stylesheet on another port (`stylesheet`), applies a transformation (based on the stylesheet) to the source documents, and produces a sequence of result documents on an output port, one for each of the sources.

[illustration: three steps in sequence, including an xslt step]

Steps have names and types. Their type is what you see (`p:add-attribute`, `identity`, `xslt`) and what you use to call them. Since they are called by type, steps can be anonymous, but it is also useful to give them names, with `@name`.

When you use a step in a pipeline, however, you can also give it a name, this making it possible to connect other steps to it, out of sequence as well as in sequence.

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

Ports go in only one direction: they are input or output, never both. (An `identity` step replicates its input on its output.)

The conventional name for the primary port is "source". The conventional name for the primary output port is "result". These names correspond with the uses of these terms in XSLT and XQuery.

So every port with an input is likely to have a 'source', while every port with an output is likely to have its 'result'.
It is sometimes useful for a step to have input but no output - `p:sink` being the simple example.

The 'source' and 'result' ports can carry sequences when the steps on which they are defined say so - and when permitted to be sequences they may also be empty (have no documents bound to them): a sequence with no members, not a single.

Ports apart from 'source' and 'result' will be secondary, and will have names indicating their roles in the operation of their steps - a good example is a 'schema' secondary input port for a validation step, which a processor uses to provide the schema.

---

## Reflection

A step with no input ports may nonetheless have inputs or dependencies, loading documents and data from outside the pipeline. This is a design feature of the language, and not in itself wrong or ill-advised.

Similarly a useful step may also have no output ports, or a port showing only tracebacks to a user to confirm operations at runtime (for example, on a terminal). Nonetheless it can build web sites, write results of data conversions to online or offline data stores, etc. - and we call these "side effects" even when they are the point of the exercise.

Then too, the entire reason to have ports is to pass data into and through the pipelines that declare them -- information sets that must start and end somewhere.

This two-sided power - that it is both a declarative and functional language whose operations are largely *abstracted*, and also an information processing engine that reads and writes data, is key to what makes XProc useful.

Think of it as nested black boxes, except with labeled hatches, and unlocked, with spot lighting and schematics available.

We put XProc to work reading and transforming data - in specified, testable ways - but we think of it in abstract terms that enable most of the chores (especially those related to memory and resource management) to be delegated to the processing engine to take care of.

---

## Those implicit connections

As mentioned, steps can always connect using implicit connections, even when they are anonymous (have no name to connect to).

This is possible due to a rule of processing: the XProc engine should assume, unless when given indications otherwise, that a primary input port will connect to the immediately preceding step's primary output port.

Consequently, an XProc pipeline can be designed as a straight sequence of steps, each of which hands off its results to the next step. These can be long, while remaining simple to construct and maintain.

The pipeline is simple but the operations within any step can be arbitrarily complex, especially if the step logic is implemented in a full-fledged data processing language such as XSLT or XQuery.

---

## Explicit connections

If processing requirements are too complex to address with a simple chain or sequence of steps, steps can be named and connections made to other steps, by binding to their ports by name.

On any step, input is bound using `p:with-input`. If given a `@pipe` attribute, or provided with a `p:pipe` element, the connection is made to an output port on another step. Other connections can be made by using `p:document` (nominates a document to be read from the file system), `p:inline` (for literal XML contents to be used, either as is or as template for embedded expressions), `p:empty` (for an explicitly 'stopped' connection).

A couple of these connectors can be added implicitly, using attributes as a shorthand notation in place of child elements. For example, an `@href` attribute is taken as shorthand for an element `p:document` with an `href`. If more than one document needs to be connected, the long syntax using elements is available.

Similarly with pipe connectors. Instead of `p:pipe` designating a `@port` and a `@step`, the output port of the connected step can be indicated using shorthand notation, as `pipe="output_port@connected_step"`.

(examples)
      
---

## Options

In addition to inputs and outputs (connection ports), steps can also have **options**.

These provide runtime configurations when invoking steps and pipelines.

Their values can be simple (string value flags) or complex (such as map objects, or expressions to be evaluated).

Its ports and options together provide an *interface* for using a step.

Options can be set on steps using abbreviated syntax (attributes) or long syntax (`p:with-option`)

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
