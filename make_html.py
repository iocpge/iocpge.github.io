import dominate
from dominate.tags import *

doc = dominate.document(title='iocpge')

with doc.head:
    meta(charset="utf-8")
    meta(name="viewport", content="width=device-width, initial-scale=1")
    link(rel='stylesheet', href='style.css')
    script(type='text/javascript', src='script.js')
    link(rel="icon",href="/favicon.ico")
    link(rel="icon",href="/favicon.svg",type="image/svg+xml")
    link(rel="apple-touch-icon",href="/apple-touch-icon.png")

with doc:
    h1("Hello !")
    with div(id='header').add(ol()):
        for i in ['home', 'about', 'contact']:
            li(a(i.title(), href='/%s.html' % i))

    with div():
        attr(cls='body')
        p("Let's start !")

print(doc)
