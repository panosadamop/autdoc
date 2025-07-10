
import os
from openai import OpenAI
from chromadb.utils.embedding_functions import OpenAIEmbeddingFunction
import chromadb

OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")
CHROMA_DB_PATH = os.getenv("CHROMA_DB_PATH", "./vector_store")

client = OpenAI(api_key=OPENAI_API_KEY)
chroma_client = chromadb.PersistentClient(path=CHROMA_DB_PATH)
embedding_function = OpenAIEmbeddingFunction(api_key=OPENAI_API_KEY)

collection = chroma_client.get_or_create_collection(name="docs", embedding_function=embedding_function)

def generate_documentation(file_path: str, content: str) -> str:
    prompt = f"""Generate documentation for the following file:

### File: {file_path}
### Content:
{content}
"""    
    response = client.chat.completions.create(
        model="gpt-4",
        messages=[{"role": "user", "content": prompt}],
        temperature=0.3
    )
    doc = response.choices[0].message.content
    store_documentation(file_path, doc)
    return doc

def store_documentation(file_path: str, doc: str):
    os.makedirs("generated_docs", exist_ok=True)
    clean_name = file_path.replace("/", "_").replace(".", "_")
    with open(f"generated_docs/{clean_name}.md", "w") as f:
        f.write(doc)
    collection.add(documents=[doc], ids=[file_path])
