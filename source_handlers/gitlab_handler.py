import os
import subprocess

GITLAB_REPO = os.getenv("GITLAB_REPO_URL")
GITLAB_BRANCH = os.getenv("GITLAB_BRANCH", "main")
CLONE_DIR = "./gitlab_repo"

def clone_or_pull():
    if not os.path.exists(CLONE_DIR):
        subprocess.run(["git", "clone", "-b", GITLAB_BRANCH, GITLAB_REPO, CLONE_DIR])
    else:
        subprocess.run(["git", "-C", CLONE_DIR, "pull"])

def get_source_path():
    return CLONE_DIR
