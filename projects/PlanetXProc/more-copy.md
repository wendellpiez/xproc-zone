# More copy

Draft copy and scraps

## XPath

XPath has come a long way since 1998.

Since XPath 2.0 (over 20 years as I write) it has supported XDM data types, regular expressions, sequence and set operations, and more.

Since [version 3.1](https://www.w3.org/TR/xpath-functions-31/), XPath builds in support for maps and arrays, making it easier to use with JSON data.

With XPath 4.0, the same path navigation syntax will be possible over data structures derived from arbitary sources - at the level of syntax, no more difference between XML and other forms of structured data. 

## Compound steps

XProc has a few built-in steps including the *compound steps*, which have some special capabilities.

Each compound step provides a different way of deploying a pipeline (i.e., an arrangement of steps) over an input document or sequence of documents.

For example, the step `p:for-each` executes a series of steps (enclosed in the `p:for-each` element) over a sequence of inputs, not together but distinctly ("for each").

The other compound steps are `p:group`, `p:choose` (with `p:when` and `p:otherwise`, `p:if`, `p:try` with `p:catch`, and `p:viewport`.

Together and separately, these permit XProc to branch its operations and to synthesize pipelines to coordinate not only provided resources, but resources produced dynamically by means of pipelines. 

## `p:with-input` is a plug

Elements in XProc are either steps, or they are the connectors and supporting apparatus.

Among the most important connectors is the one that configures the inputs (binds the input ports) of steps when they are used: `p:with-input`.

All connections in XProc are one-way. Think of `p:with-input` as a *plug*. It connects the input port on the step to an output port on a connected step.

It is possible to imagine XProc working the other way around, with each step saying where to direct its outputs instead of where it gets its inputs. But such pipelines turn out to be harder to read and understand.

---

## Some steps

See the Step List on the site!

| Step  | Application | input ports (primary, secondary)  | output ports (primary, secondary)  | options (bold if required)
|---|---|---|---|---|
| p:delete   | Delete matched nodes  | **source**  | **result**  | **match**
|   |   |   |   |
| p:compare  | Compare two documents | **source**, alternate  | **result**, differences | fail-if-not-equal, method, parameters  |


