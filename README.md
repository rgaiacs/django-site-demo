# Django Site Demo

This is a minimal working example of a Django site using a [Django reusable apps](https://docs.djangoproject.com/en/5.2/intro/reusable-apps/), see [`django-app-demo`](https://github.com/rgaiacs/django-app-demo). The goal here is to explore best practices to develop the Django site and the Django reusable apps.

## Usage

1.  Clone https://github.com/rgaiacs/django-app-demo

    ```bash
    git clone git@github.com:rgaiacs/django-app-demo.git
    ```
2.  Start the container

    ```bash
    docker compose up
    ```
3.  Open http://localhost:8000/ with your web browser.

## Limitations

### Django's `runserver`

1.  The auto-reloader from Django's `runserver` does **NOT** keep track of `django-app-demo` and will not restart when `django-app-demo` changes.
2.  The auto-reloader from Django's `runserver` does **NOT** reload any "external" modules.

## Visual Studio Code

1. The Git plugin from Visual Studio Code **ONLY** supports extra repositories if they are submodules.

    **Solution**: use two Visual Studio Code windows.
