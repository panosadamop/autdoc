
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
import os
import chromadb
from chromadb.utils.embedding_functions import OpenAIEmbeddingFunction

chroma_client = chromadb.PersistentClient(path=os.getenv("CHROMA_DB_PATH", "./vector_store"))
collection = chroma_client.get_or_create_collection(
    name="docs",
    embedding_function=OpenAIEmbeddingFunction(api_key=os.getenv("OPENAI_API_KEY"))
)

@csrf_exempt
def search_docs(request):
    if request.method != "POST":
        return JsonResponse({"error": "Only POST allowed"}, status=405)

    try:
        body = json.loads(request.body)
        query = body.get("query", "")
        if not query:
            return JsonResponse({"error": "Missing query"}, status=400)

        results = collection.query(query_texts=[query], n_results=3)
        return JsonResponse({"matches": results})
    except Exception as e:
        return JsonResponse({"error": str(e)}, status=500)
