#!/usr/bin/env python3
import dominate
from dominate.tags import *
import os


doc = dominate.document(title='INFO LINKS')

with doc.head:
    meta(name="title", content="Liens")
    meta(name="viewport", content="width=device-width, initial-scale=1")
    link(rel='stylesheet', href='style.css')
    # link(rel='stylesheet', href="https://latex.now.sh/style.css")
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


# HEADERS and TOC
with doc:
    with div(id="header"):
        h1("Lire, écouter et regarder")
        h2("")

    with div(id='toc').add(ol()):
        for i in [['Podcasts', 'Podcasts'], ['Vidéos', 'videos'], ['Sujets et rapports des concours','concours']]:
            li(a(i[0], href='#%s' % i[0]))


# Podcasts

titles_and_links =  []
titles_and_links.append(("Claire Mathieu - France culture - La méthode scientifique - Les algorithmes ? Les algorithmes d'approximation ?","https://www.radiofrance.fr/franceculture/podcasts/la-methode-scientifique/grand-entretien-avec-claire-mathieu-specialiste-des-algorithmes-3854762"))

titles_and_links.append(("Gérard Berry -  Série - Où va l'informatique ? - France culture","https://www.radiofrance.fr/franceculture/podcasts/serie-ou-va-l-informatique"))

titles_and_links.append(("Le premier des algorithmes : la numération positionnelle décimale -  Fibonacci, une suite qui vaut de l'or - France culture","https://www.franceculture.fr/emissions/la-methode-scientifique/fibonacci-une-suite-qui-vaut-de-lor"))

with doc:
    with div(id="Podcasts"):
        h3("Podcasts")
        ul(li(a(title, href=link), __pretty=False) for title, link in titles_and_links)

# Vidéos 

titles_and_links =  []
titles_and_links.append(("Xavier Leroy - Le logiciel, entre esprit et matière - Leçon inaugurale - Collège de France","https://www.college-de-france.fr/site/xavier-leroy/inaugural-lecture-2018-11-15-18h00.htm"))
with doc:
    with div(id="videos"):
        h3("Vidéos")
        ul(li(a(title, href=link), __pretty=False) for title, link in titles_and_links)

# Concours

titles_and_links =  []
titles_and_links.append(("Sujets et rapports du concours Centrale Supélec","https://www.concours-centrale-supelec.fr/CentraleSupelec"))
titles_and_links.append(("Sujets et rapports du concours CCINP","https://www.concours-commun-inp.fr/fr/epreuves/annales.html"))
titles_and_links.append(("Sujets et rapports du concours Commun Mines Ponts","https://www.concoursminesponts.fr/page8/page8.html"))
titles_and_links.append(("Sujets et rapports du concours Polytechnique","https://www.polytechnique.edu/admission-cycle-ingenieur/documentation/sujets-rapports-statistiques"))
titles_and_links.append(("Sujets et rapports du concours ENS Sciences","https://www.ens.psl.eu/une-formation-d-exception/admission-concours/concours-voie-cpge/concours-voie-cpge-sciences-0"))
with doc:
    with div(id="concours"):
        h3("Concours (annales)")
        ul(li(a(title, href=link), __pretty=False) for title, link in titles_and_links)


print(doc)
