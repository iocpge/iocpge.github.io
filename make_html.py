#!/usr/bin/env python3
import dominate
from dominate.tags import *

doc = dominate.document(title='iocpge')#, encoding='utf-8')#, lang='fr')

with doc.head:
    meta(name="viewport", content="width=device-width, initial-scale=1")
    #link(rel='stylesheet', href='style.css')
    link(rel='stylesheet', href="https://latex.now.sh/style.css")
    link(rel="stylesheet", href="https://latex.now.sh/prism/prism.css")
    link(rel="stylesheet", href="https://latex.now.sh/lang/fr.css")

    script(type='text/javascript', src="https://cdn.jsdelivr.net/npm/prismjs/prism.min.js")
    script(type='text/javascript', id="MathJax-script", _async=True, src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js")
    script(type='text/javascript', id="Local scripts",  src='script.js')
    link(rel="icon",href="/favicon.ico")
    link(rel="icon",href="/favicon.svg",type="image/svg+xml")
    link(rel="apple-touch-icon",href="/apple-touch-icon.png")

with doc:
    with div(id="Author"):
        attr(cls="author")
        p("Olivier Reynet")
    with div(id="abstract"):
        attr(cls="abstract")
        h2("Résumé")     
    with div(id='header').add(ol()):
        for i in ['home', 'about', 'contact']:
            li(a(i.title(), href='/%s.html' % i))

    with div():
        attr(cls='body')
        p("Let's start !")

print(doc)
