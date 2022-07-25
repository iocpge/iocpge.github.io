#!/usr/bin/env python3
import dominate
from dominate.tags import *
import math

doc = dominate.document(title='iocpge')

with doc.head:
    meta(name="title", content="Informatique en CPGE")
    meta(name="viewport", content="width=device-width, initial-scale=1")
    # link(rel='stylesheet', href='style.css')
    link(rel='stylesheet', href="https://latex.now.sh/style.css")
    link(rel="stylesheet", href="https://latex.now.sh/prism/prism.css")
    link(rel="stylesheet", href="https://latex.now.sh/lang/fr.css")
    link(rel="stylesheet", href="https://cdn.jsdelivr.net/npm/pseudocode@latest/build/pseudocode.css")
    script(type='text/javascript', src="https://cdn.jsdelivr.net/npm/pseudocode@latest/build/pseudocode.js")
    script(type='text/javascript', src="https://cdn.jsdelivr.net/npm/prismjs/prism.min.js")
    script("MathJax = {tex: { tags: 'ams'}};")
    script(id="MathJax-script", _async=True, src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js")
    script(type='text/javascript', id="Local scripts", src='script.js')
    link(rel="icon", href="/favicon.ico")
    link(rel="icon", href="/favicon.svg", type="image/svg+xml")
    link(rel="apple-touch-icon", href="/apple-touch-icon.png")
    script(type='text/javascript', src='pseudocode.renderElement(document.getElementById("algorithm"));')

with doc:
    with div(id="header"):
        h1("Informatique en CPGE")

    with div(id="abstract"):
        attr(cls="abstract")
        h2("Résumé")
        p("""Tout ce qu'il faut savoir et savoir faire pour réussir les épreuves d'informatique sereinement: 
        cours, travaux pratiques sur machine, quizz, devoirs et corrigés. 
        """)

    with div(id='topages').add(ol()):
        for i in [['Informatique commune', 'ic'], ['Option informatique (MPSI/MP/MP*)', 'optinfo']]:
            li(a(i[0], href='/%s.html' % i[1]))


print(doc)
