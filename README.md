# Justin Vasel's Curriculum Vitae

![GitHub (pre-)release](https://img.shields.io/github/release/justinvasel/curriculum-vitae/all.svg)
![Travis](https://img.shields.io/travis/justinvasel/curriculum-vitae.svg)


This is my current Curriculum Vitae. I've made some slight modifications to the
`res.cls` class and renamed it `cv.cls`. Other than that it's a fairly
barebones template. If you want fancy font and color support you'll have to do
some surgery or look elsewhere.


## Requirements

A modern version of LaTeX. The Makefile uses `pdflatex`, so you should have that
installed if you want to make things easy, otherwise you can typeset manually.


## Usage

Usage is easiest through the use of the Makefile.

```shell
# Typeset the CV and clean up LaTeX junk
make

# Typeset the CV and leave LaTeX junk behind
make pdf

# Clean up LaTeX junk
make clean

# Clean up LaTeX junk and CV pdf file (only source code left behind)
make nuke
```

## Packages Used

To work out of the box, make sure you have these packages installed.

 * **xcolor** — More colors! And how!
 * **hyperref** — Formatting hyperlinks
 * **amsmath** — Mathematics
 * **babel** — Special character typesetting (you may not need this)
 * **etaremune** — Reverse enumerate (requires two typesets)


## Contributions

Pull requests for structure, formatting, etc. will be considered on a
case-by-case basis. This is of course my personal CV, so content changes will
not be accepted.


## License

The modifications to `cv.cls` are subject to the copyright established by the
original author:

> Copyright (c) 1988 by Michael DeCorte
> Permission to copy all or part of this work is granted, provided
> that the copies are not made or distributed for resale, and that
> the copyright notice and this notice are retained.
>
> THIS WORK IS PROVIDED ON AN "AS IS" BASIS.  THE AUTHOR PROVIDES NO
> WARRANTY WHATSOEVER, EITHER EXPRESS OR IMPLIED, REGARDING THE WORK,
> INCLUDING WARRANTIES WITH RESPECT TO ITS MERCHANTABILITY OR FITNESS
> FOR ANY PARTICULAR PURPOSE.

All other files are my own creations and are licensed under the MIT License
(See [LICENSE.md](LICENSE.md)).
