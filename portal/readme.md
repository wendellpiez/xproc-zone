# XProc Zone - Portal

The Portal is a web site produced from this repository.

This folder contains the 'frame' of the site (source code), while other projects will populate its further reaches.

## Development

XHTML files are valid to HTML5 and to a [project portal Schematron](src/zone-portal-html.sch).

The Schematron is made to be strict, but extensible, for awareness of the edges.

A plain site serving XHTML can be delivered for testing and debugging from this directory. Use the script provided or your own plain web server on the port of your choice.

Parts of the web site not here will be produced by pipelines in projects, and may evolve over time.

## Publication

Pipelines in this directory produce a neighbor directory, [../docs/](../docs/..), containing a 'build': static outputs of pipelines that together produce the project portal as a plain web site using HTML, CSS, Javascript, SVG and other tech (XML/XSLT?) as appropriate for its various applications.

These pipelines are maintained and run from elsewhere in the repository. They can be run together using the pipeline [UPDATE-PUB.xpl](UPDATE-PUB.xpl), which will dispatch to other pipelines including [BUILD-PORTAL.xpl](BUILD-PORTAL.xpl), which builds the main site.

Alternatively, run these pipelines separately for development and debugging.

Currently we perform only a 'static build', that is, we do not update the publication automatically. This is more laborious than CI/CD, but offers more control. A mature publication system will run without making such frequent or radical updates to software, at which point an automated build makes sense.

TODO:

- Link checking - any link marked 'internal'? (nb: already checked with Schematron)
- Consider running under CI/CD for merge-time build

## Folder maintenance

When updating, take care to keep the ../pub/ directory clean in git since pipelines may refresh files or generate new ones, but typically will not delete files that are no longer wanted.

Avoid leftover clutter by deleting the directory and restoring with a fresh build. Unused files are now "gone" - except git has not been updated. This is not expected to be (much of) a problem since we anticipate adding, but not deleting or rearranging (much). But it could be a nuisance.

Here is a git command that will remove files deleted from the folder from git (in the current directory):

> git ls-files --deleted -z | xargs -0 git rm

After running this (inside `../pub/`), commit the branch and the files will be removed.

NB - since our publication model is static you can also make changes by renaming etc. to your heart's content - as long as git is clean, so are we.

## Serving the site from `localhost`

Serve this directory from a local web server for preview: everything should work.

After running updates, the same thing is true in the [../pub/](../pub/) directory - there you can preview what will be the live site, not its sources.

For example, if you have Python installed:

> c:\path\to\python\python.exe -m http.server 8080

Will host a web site on port 8080, with the file `index.html` (in the current directory) as [the site's home page](http://localhost:8080).

Other options include Node JS, Apache, and IIS. Any plain server.

The Powershell script [start-web-server.ps1](start-web-server.ps1) works on Windows after some setup - see the file.

-----
