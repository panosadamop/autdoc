import subprocess

def get_changed_files(repo_dir, extensions=None):
    try:
        result = subprocess.run(
            ["git", "-C", repo_dir, "diff", "--name-only", "HEAD~1", "HEAD"],
            capture_output=True,
            text=True,
            check=True
        )
        changed_files = result.stdout.strip().split("\n")
        if extensions:
            changed_files = [f for f in changed_files if any(f.endswith(ext) for ext in extensions)]
        return changed_files
    except subprocess.CalledProcessError as e:
        print("Git diff error:", e)
        return []
