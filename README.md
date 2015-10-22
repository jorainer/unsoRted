<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#orgheadline4">1. Description</a>
<ul>
<li><a href="#orgheadline1">1.1. Functions related to data analysis</a></li>
<li><a href="#orgheadline2">1.2. Visualizations</a></li>
<li><a href="#orgheadline3">1.3. Other utilities</a></li>
</ul>
</li>
<li><a href="#orgheadline9">2. Development</a>
<ul>
<li><a href="#orgheadline5">2.1. Authors</a></li>
<li><a href="#orgheadline8">2.2. <span class="todo nilTODO">TODO</span> s</a>
<ul>
<li><a href="#orgheadline6">2.2.1. <span class="todo nilTODO">TODO</span> File <code>annotation.R</code>, function <code>getAnnotation</code>: speed up the call.</a></li>
<li><a href="#orgheadline7">2.2.2. <span class="todo nilTODO">TODO</span> File <code>annotation.R</code>: implement annotations for our custom CDFs: automatically download them.</a></li>
</ul>
</li>
</ul>
</li>
</ul>
</div>
</div>

---

[![Travis-CI Build Status](https://travis-ci.org/jotsetung/unsoRted.svg?branch=master)](https://travis-ci.org/jotsetung/unsoRted)

# Description<a id="orgheadline4"></a>

This R package contains some unsorted utilities and functions that might make life easier in the day-to-day use of R for data analysis.

## Functions related to data analysis<a id="orgheadline1"></a>

-   `getAnnotation`: retrieves an annotation data.frame for a given (Affymetrix based) `ExpressionSet`. For more informations see the according help.

-   `getAnnotationForIDs`: retrieves a data.frame with annotations for the provided feature (probe set) ids. For more informations see the according help.

-   `getRepPS`: returns a representative probe set for a gene based on some criteria. For more informations see the according help.

-   `hyperGGeneric`: performs a category analysis on any user provided definition of categories. For more informations see the according help.

## Visualizations<a id="orgheadline2"></a>

-   `plotCategoryBar` and `plotCategoryBars`: visualization of category enrichment analysis results.

-   `modColor`, `shiftColor` and `invertColor`: invert or shift colors in RGB or HSV color space.

## Other utilities<a id="orgheadline3"></a>

-   `convertTxt2Xls`: converts a text file with tabular content to a Microsoft Excel spreadsheet. For more informations see the according help.

-   `load.from.http`: loads a RData file from a remote server (e.g. http or ftp server). For more informations see the according help.

-   `pastedmatch`: value matching allowing e.g. `;` separated values. For more informations see the according help.

-   `read.table.from.http`: loads and reads a table from a remote (e.g. http or ftp) server. For more informations see the according help.

# Development<a id="orgheadline9"></a>

Please add new functions or improve existing ones. New functions should be documented (`Rd` format) and listed in this document (`README.org`) as well as in `man/unsoRted-package.Rd`. This file should then be exported as a markdown (`md`) file (best performed in Emacs org-mode `c-c c-e`).

## Authors<a id="orgheadline5"></a>

-   Daniel Bindreither
-   Johannes Rainer

(please add your name to this (`README.org`) file if you edit the code or add new functionality).

## TODO s<a id="orgheadline8"></a>

### TODO File `annotation.R`, function `getAnnotation`: speed up the call.<a id="orgheadline6"></a>

### TODO File `annotation.R`: implement annotations for our custom CDFs: automatically download them.<a id="orgheadline7"></a>