#!/usr/bin/env python3
import dominate
from dominate.tags import *
import math


doc = dominate.document(title='iocpge')


with doc.head:
    meta(name="viewport", content="width=device-width, initial-scale=1")
    #link(rel='stylesheet', href='style.css')
    link(rel='stylesheet', href="https://latex.now.sh/style.css")
    link(rel="stylesheet", href="https://latex.now.sh/prism/prism.css")
    link(rel="stylesheet", href="https://latex.now.sh/lang/fr.css")
    link(rel="stylesheet", href="https://cdn.jsdelivr.net/npm/pseudocode@latest/build/pseudocode.css")
    script(type='text/javascript', src="https://cdn.jsdelivr.net/npm/pseudocode@latest/build/pseudocode.js")
    script(type='text/javascript', src="https://cdn.jsdelivr.net/npm/prismjs/prism.min.js")
    script("MathJax = {tex: { tags: 'ams'}};")
    script(id="MathJax-script", _async=True, src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js")
    script(type='text/javascript', id="Local scripts",  src='script.js')
    link(rel="icon",href="/favicon.ico")
    link(rel="icon",href="/favicon.svg",type="image/svg+xml")
    link(rel="apple-touch-icon",href="/apple-touch-icon.png")
    script(type='text/javascript', src='pseudocode.renderElement(document.getElementById("algorithm"));')

with doc:
    with div(id="Title"):
        attr(cls="title")
        p("Informatique en CPGE")

    with div(id="Author"):
        attr(cls="author")
        p("Io Cpge")

    with div(id="abstract"):
        attr(cls="abstract")
        h2("Résumé")
        p("Tout ce qu'il faut savoir et savoir faire pour réussir les épreuves d'informatique sereinement.")
    with div(id='header').add(ol()):
        for i in [['Informatique pour tous (IPT)', 'ipt'], ['Option informatique (MPSI/MP/MP*)', 'Optinfo']]:
            li(a(i[0].title(), href='/%s.html' % i[1]))

    with div():
        attr(cls='body')
        p("Let's start !")

    with div(id = "codex").add(pre()):
        code( """
import math
s = math.sqrt(3)
for i in range(5):
    print(s)
print(3)"""
            , cls="language-python")

    with div(id = "eqex"):
        p("in line equation \(X^3 = X^2 +1\)")
        p('\[ e^{i \pi} + 1 = 0 \]')
        p("""\\begin{equation}
              \int_0^\infty \\frac{x^3}{e^x-1}\,dx = \\frac{\pi^4}{15}
              \label{eq:sample}
           \\end{equation} """)
        p("Cette équation est référencée \eqref{eq:sample}")

    with div(id='algorithm'):
        attr(style="display:hidden;")
        pre( """
        \\begin{algorithmic}
        \PRINT \\texttt{'hello world'}
        \end{algorithmic}
        """)


print(doc)

