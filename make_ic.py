#!/usr/bin/env python3
import dominate
from dominate.tags import *
import os


doc = dominate.document(title='IC')

with doc.head:
    meta(name="title", content="Informatique commune")
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


# HEADERS and TOC
with doc:
    with div(id="header"):
        h1("Informatique commune")
        h2("Cours et TP / MPSI, PCSI, MP, PC")

    with div(id='toc').add(ol()):
        for i in [['Introduction', 'intro'],['Semestre 1', 's1'], ['Semestre 2', 's2'], ['Semestre 3', 's3']]:
            li(a(i[0], href='#%s' % i[0]))


# INTRODUCTION
files_and_links =[]
current_files = sorted(os.listdir("ic/"))
for file in current_files:
   if os.path.isfile("ic/"+str(file)) and file.endswith('.pdf'):
       file_name = str(file).replace("_"," ").replace(".pdf", "")
       files_and_links.append([file_name, "ic/"+str(file)])

with doc:
    with div(id="Introduction"):
        h2("Introduction")
        ul(li(a(file_name, href=link), __pretty=False) for file_name, link in files_and_links)
        
        
# SEMESTERS
semesters = sorted(os.listdir("ic/"))
for semester in semesters:
    if os.path.isdir("ic/"+str(semester)):
        current_sem = "ic/"+str(semester)+"/"
        #print("Current semester --> ",current_sem)
        tps = {}
        tpdirs = sorted(os.listdir(current_sem))
        for tpdir in tpdirs:
            #print("TP Directory  --> ",tpdir)
            current_tp =  str(current_sem)+str(tpdir)+"/"
            if os.path.isdir(current_tp):
                files_and_links =[]
                current_files = sorted(os.listdir(current_tp))
                for file in current_files:
                    if os.path.isfile(current_tp+str(file)) and file.endswith('.pdf'):
                        if "solutions" in file:
                            file_name = "sujet et solutions"
                        elif "sujet" in file:
                            file_name = "sujet"
                        elif "Cours" in file:
                            file_name = "cours"
                        else:
                            pass
                        files_and_links.append([file_name, current_tp+str(file)])
                tp_name=str(tpdir).replace("_"," ") 
                tps[tp_name]=files_and_links
        with doc:
            sem = str(semester).replace("_", " ")
            with div(id=sem):
                #print(sem)
                h2(sem)
                for tp,files_and_links in tps.items():
                    with div(id=tp):
                        h3(tp)
                        ul(li(a(file_name, href=link), __pretty=False) for file_name, link in files_and_links)


print(doc)
