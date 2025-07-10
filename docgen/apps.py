from django.apps import AppConfig
from django.conf import settings
import threading

class DocgenConfig(AppConfig):
    name = 'docgen'

    def ready(self):
        if settings.DEBUG:
            from watcher.file_watcher import prepare_source
            from diff.git_diff import get_changed_files
            from docgen_core.doc_generator import generate_documentation
            from docgen_core.diagram_generator import generate_mermaid_diagram
            import os

            def run_doc_generation():
                try:
                    print("🔁 AutoDocAI DEBUG mode: Generating documentation...")
                    src_dir = prepare_source()
                    changed = get_changed_files(src_dir, extensions=[".sql", ".java", ".py", ".bpmn"])

                    for rel_path in changed:
                        file_path = os.path.join(src_dir, rel_path)
                        with open(file_path, "r", encoding="utf-8") as f:
                            content = f.read()
                            generate_documentation(rel_path, content)
                            diagram = generate_mermaid_diagram(rel_path, content)
                            if diagram:
                                with open(f"generated_docs/{rel_path.replace('/', '_')}_diagram.mmd", "w") as d:
                                    d.write(diagram)
                    print("✅ Documentation generated on startup.")
                except Exception as e:
                    print("⚠️ Auto-generation failed:", e)

            # Run async to avoid blocking Django startup
            threading.Thread(target=run_doc_generation).start()
