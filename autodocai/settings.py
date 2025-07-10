from pathlib import Path
from dotenv import load_dotenv
from django.urls import path, include
from django.contrib import admin

load_dotenv()

BASE_DIR = Path(__file__).resolve().parent.parent

urlpatterns = [
    path('', include('docgen.urls')),  # Routes to your main app
]

SECRET_KEY = 'django-insecure-autodocai-secret-key'
DEBUG = True
ALLOWED_HOSTS = ['*']

INSTALLED_APPS = [
    'django.contrib.contenttypes',
    'django.contrib.staticfiles',
    'docgen',
]

MIDDLEWARE = [
    'django.middleware.common.CommonMiddleware',
]

ROOT_URLCONF = 'autodocai.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [BASE_DIR / 'docgen' / 'templates'],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [],
        },
    },
]

WSGI_APPLICATION = 'autodocai.wsgi.application'

STATIC_URL = '/static/'
STATICFILES_DIRS = [
    BASE_DIR / "generated_docs",
]

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'