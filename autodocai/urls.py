from django.urls import path

from docgen import views, views_ui, views_rag

urlpatterns = [
    path("webhook/gitlab/", views.gitlab_webhook),
    path("docs/", views_ui.list_docs),
    path("search/", views_rag.search_docs),
    path('', views_ui.home),
]
