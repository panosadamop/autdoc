import os
from dotenv import load_dotenv
load_dotenv()

if os.getenv("SOURCE_MODE") == "gitlab":
    from source_handlers.gitlab_handler import clone_or_pull, get_source_path
else:
    from source_handlers.local_handler import get_source_path

def prepare_source():
    if os.getenv("SOURCE_MODE") == "gitlab":
        clone_or_pull()
    return get_source_path()
