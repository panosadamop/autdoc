
pipeline {
    agent any
    environment {
        VENV_DIR = "venv"
    }
    stages {
        stage('Clone') {
            steps {
                git 'https://your-git-repo-url.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                sh 'python -m venv $VENV_DIR'
                sh './$VENV_DIR/bin/pip install -r requirements.txt'
            }
        }
        stage('Run Tests') {
            steps {
                sh './$VENV_DIR/bin/python manage.py check'
            }
        }
        stage('Run Server') {
            steps {
                sh './$VENV_DIR/bin/python manage.py runserver 0.0.0.0:8000 &'
            }
        }
    }
}
