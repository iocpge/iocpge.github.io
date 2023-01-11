#!/usr/bin/env python3
import dominate
from dominate.tags import *
import os
import re


doc = dominate.document(title='OPT INFO')

with doc.head:
    meta(name="title", content="Option informatique")
    meta(name="viewport", content="width=device-width, initial-scale=1")
    link(rel='stylesheet', href='style.css')
    #link(rel='stylesheet', href="https://latex.now.sh/style.css")
    link(rel="stylesheet", href="prism.css")
    link(rel="stylesheet", href="fr.css")
    script(type='text/javascript', src="prism.min.js")
    #script("MathJax = {tex: { tags: 'ams'}};")
    #script(id="MathJax-script", _async=True, src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js")
    script(type='text/javascript', id="Local scripts", src='script.js')
    link(rel="icon", href="/favicon.ico")
    link(rel="icon", href="/favicon.svg", type="image/svg+xml")
    link(rel="apple-touch-icon", href="/apple-touch-icon.png")
    script(type='text/javascript', src='pseudocode.renderElement(document.getElementById("algorithm"));')


# HEADERS and TOC
with doc:
    with div(id="header"):
        h1("Option informatique")
        h2("Cours et TP / MPSI, MP, MP*")

    with div(id='toc').add(ol()):
        for i in [['Divers', 'divers'],['Semestre 2', 's2'], ['Semestre 3', 's3'], ['Semestre 4', 's4']]:
            li(a(i[0], href='#%s' % i[0]))

nre = re.compile(r"""(_\d+_(\d+|[A-Za-z]+)_)""")
nredivers = re.compile(r"""(_\d+_)""")
lre = re.compile(r"""(_[a-z]+_)""")
yt = re.compile(r"""Screencast-""")

# DIVERS
files_and_links =[]
current_files = sorted(os.listdir("optinfo/Divers"))
for file in current_files:
   if os.path.isfile("optinfo/Divers/"+str(file)) and file.endswith('.pdf'):
       file_name = lre.sub(" - ", file, 1)
       file_name = file_name.replace("_"," ").replace(".pdf", "").replace("web","").replace("cm","")
       files_and_links.append([file_name, "optinfo/Divers/"+str(file)])

with doc:
    with div(id="divers"):
        h2("Divers")
        ol(li(a(file_name, href=link), __pretty=False) for file_name, link in files_and_links)
        
        
# SEMESTERS
semesters = sorted([filename for filename in os.listdir("optinfo/") if filename.startswith("Semestre")])
for semester in semesters:
    if os.path.isdir("optinfo/"+str(semester)):
        current_sem = "optinfo/"+str(semester)+"/"
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
                       # if "solutions" in file:
                       #     file_name = "sujet et solutions"
                       # elif "sujet" in file:
                       #     file_name = "sujet"
                       # elif "Cours" in file:
                       #     file_name = "cours"
                       # else:
                       #     pass
                        file_name = nre.sub(" - ", file)
                        file_name = file_name.replace("_"," ").replace(".pdf", "").replace("web","").replace("cm","")
                        files_and_links.append([file_name, current_tp+str(file)])
                    elif os.path.isfile(current_tp+str(file)) and file.startswith("Screencast"):
                        address = file.split("-")[-1]
                        link= "https://youtu.be/"+address
                        title = file.split("-")[-2]
                        files_and_links.append(["Screencast : "+title, link])
                    elif os.path.isfile(current_tp+str(file)) and not file.startswith('.'):
                        file_name = file.replace("_"," ")
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
