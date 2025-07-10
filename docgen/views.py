
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import os
from watcher.file_watcher import prepare_source
from diff.git_diff import get_changed_files
from docgen_core.doc_generator import generate_documentation
from docgen_core.diagram_generator import generate_mermaid_diagram

@csrf_exempt
def gitlab_webhook(request):
    if request.method != "POST":
        return JsonResponse({"error": "Only POST allowed"}, status=405)

    secret = os.getenv("GITLAB_WEBHOOK_SECRET", "")
    sig_header = request.headers.get("X-Gitlab-Token")
    if secret and sig_header != secret:
        return JsonResponse({"error": "Unauthorized"}, status=401)

    src_dir = prepare_source()
    changed = get_changed_files(src_dir, extensions=[".sql", ".java", ".py", ".bpmn"])
    results = {}

    os.makedirs("generated_docs", exist_ok=True)

    for rel_path in changed:
        file_path = os.path.join(src_dir, rel_path)
        md_file = os.path.join("generated_docs", rel_path.replace("/", "_").replace(".", "_") + ".md")
        diagram_file = os.path.join("generated_docs", rel_path.replace("/", "_") + "_diagram.mmd")

        try:
            with open(file_path, "r", encoding="utf-8") as f:
                content = f.read()

                # Only generate if .md does not exist
                if not os.path.exists(md_file):
                    doc = generate_documentation(rel_path, content)
                    results[rel_path] = "Documentation created"
                else:
                    results[rel_path] = "Skipped (already documented)"

                # Only generate diagram if not already there
                if not os.path.exists(diagram_file):
                    diagram = generate_mermaid_diagram(rel_path, content)
                    if diagram:
                        with open(diagram_file, "w") as d:
                            d.write(diagram)
        except Exception as e:
            results[rel_path] = f"Error: {str(e)}"

    return JsonResponse({"status": "checked", "results": results})
