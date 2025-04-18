# Django Site Demo

This is a minimal working example of a Django site using a [Django reusable apps], see [`django-app-demo`](https://github.com/rgaiacs/django-app-demo). The goal here is to explore best practices to develop the Django site and the Django reusable apps.

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

## Explanation

[Django reusable apps] are Django apps that are [packaged](https://packaging.python.org/en/latest/). Because of this, we can configure the container to have the [Django reusable apps] bind mounted as a volume to make it a Django app.

When we run `python manage.py`, Python's [`sys.path`](https://docs.python.org/3/library/sys.html#sys.path) is configured to have the directory where `manage.py` is located as the first place to search for modules. This allow us to replace the `django-app-demo` installed in the container with the local copy.

## Limitations

## Visual Studio Code

1. The Git plugin from Visual Studio Code **ONLY** supports extra repositories if they are submodules.

    **Solution**: use two Visual Studio Code windows.

[Django reusable apps]: https://docs.djangoproject.com/en/5.2/intro/reusable-apps/
