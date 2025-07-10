from django.shortcuts import render
import os
from django.http import HttpResponse

def list_docs(request):
    doc_dir = "generated_docs"
    os.makedirs(doc_dir, exist_ok=True)
    docs = [f for f in os.listdir(doc_dir) if f.endswith(".md")]
    return render(request, "index.html", {"docs": docs})

def home(request):
    return HttpResponse("<h1>Welcome to AutoDocAI</h1><p><a href='/docs/'>View Docs</a></p>")
