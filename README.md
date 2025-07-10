
# AutoDocAI

A Django-based tool that auto-generates technical documentation for your source code using OpenAI, Mermaid, and ChromaDB.

---

## Features

- 📡 GitLab and Local source integration
- 🧠 AI-generated documentation
- 🧾 Markdown + Mermaid (.mmd) output
- 🔍 Semantic search with RAG (Chroma)
- 🖥 Minimal Django UI + Mermaid viewer
- 🐳 Docker + Jenkins compatible

---

## Setup (Local)

```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

Configure `.env` with:
```
OPENAI_API_KEY=...
SOURCE_MODE=gitlab
GITLAB_REPO_URL=https://...
GITLAB_BRANCH=main
GITLAB_WEBHOOK_SECRET=...
CHROMA_DB_PATH=./vector_store
LOCAL_SOURCE_DIR=../my_project
```

Run the app:
```bash
python manage.py runserver
```

---

## Docker

```bash
docker build -t autodocai .
docker run -p 8000:8000 --env-file .env autodocai
```

---

## Jenkins

Use the included `Jenkinsfile` to set up CI/CD pipeline.

---

## Endpoints

- `POST /webhook/gitlab/` → Generate docs on Git changes
- `GET /docs/` → View generated markdown
- `POST /search/` → Semantic RAG search
- `GET /view-mermaid/` → Render Mermaid diagrams

---

## Mermaid Diagram Viewer

```html
<script type="module">
  import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
  mermaid.initialize({ startOnLoad: true });
</script>
```
