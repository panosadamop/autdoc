
import os

def get_source_path():
    return os.getenv("LOCAL_SOURCE_DIR", "../main_project")
