# My Notes

## Using GitHub

Need to remove email privacy protection for the git push to work.

```
git config --global user.name=liewchooichin
git config --global user.email=liewchooichin@gmail.com
```

### …or push an existing repository from the command line

```
git remote add origin https://github.com/liewchooichin/orange_wonders.git
git branch -M main
git push -u origin main
```

### …or create a new repository on the command line

```
echo "# orange_wonders" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/liewchooichin/orange_wonders.git
git push -u origin main
```

## To monitor the changes in the git origin/main branch

```
git branch --set-upstream-to=origin/<branch> main
git branch --set-upstream-to=origin/main main
```

## In the VSCode virtual env

The Python interpreter is:
`/usr/bin/python3`

## DB problem

If database models has some problems, use DW Browser to export the sql file. Then import the data back in accordingly.

For bulk insert: 

```
INSERT INTO target [(field1[, field2[, …]])] 
    [IN externaldatabase] 
    SELECT [source.]field1[, field2[, …] 
    FROM tableexpression

-- Example:
INSERT INTO "book_catalog_bookinstance" ("imprint","due_back", "status", "book_id")
SELECT "Everday Classic", "2024-06-01", "a", book_catalog_book.id
FROM book_catalog_book;

```

## Base template

Base template can look like this:

```
<!DOCTYPE html>
<html lang="en">
  <head>
    {% block title %}
      <title>Local Library</title>
    {% endblock %}
  </head>
  <body>
    {% block sidebar %}
      <!-- insert default navigation text for every page -->
    {% endblock %}
    {% block content %}
      <!-- default content text (typically empty) -->
    {% endblock %}
  </body>
</html>
```

Other templates that `extends` from the base template:

```
{% extends "base_generic.html" %}

{% block content %}
  <h1>Local Library Home</h1>
  <p>
    Welcome to LocalLibrary, a website developed by
    <em>Mozilla Developer Network</em>!
  </p>
{% endblock %}
```

## Template variables and template tags (functions)

- Variables are enclosed in double braces ({{ num_books }}),
    - The variables are from render()--context=context.
    
- Tags are enclosed in single braces with percentage signs ({% extends "base_generic.html" %}).

## Python venv

To activate the python environment created from venv:

`source .venv/bin/activate`

## What is `__init__.py`

The `__init__.py` should be an empty file (this tells Python that the directory is a package).

## Deployment checklist

Use this to checklist the deployment:
 `python manage.py check --deploy`

```
(.venv) $ python manage.py check --deploy
System check identified some issues:

WARNINGS:
?: (security.W004) You have not set a value for the SECURE_HSTS_SECONDS setting. If your entire site is served only over SSL, you may want to consider setting a value and enabling HTTP Strict Transport Security. Be sure to read the documentation first; enabling HSTS carelessly can cause serious, irreversible problems.
?: (security.W008) Your SECURE_SSL_REDIRECT setting is not set to True. Unless your site should be available over both SSL and non-SSL connections, you may want to either set this setting True or configure a load balancer or reverse-proxy server to redirect all connections to HTTPS.
?: (security.W009) Your SECRET_KEY has less than 50 characters, less than 5 unique characters, or it's prefixed with 'django-insecure-' indicating that it was generated automatically by Django. Please generate a long and random value, otherwise many of Django's security-critical features will be vulnerable to attack.
?: (security.W012) SESSION_COOKIE_SECURE is not set to True. Using a secure-only session cookie makes it more difficult for network traffic sniffers to hijack user sessions.
?: (security.W016) You have 'django.middleware.csrf.CsrfViewMiddleware' in your MIDDLEWARE, but you have not set CSRF_COOKIE_SECURE to True. Using a secure-only CSRF cookie makes it more difficult for network traffic sniffers to steal the CSRF token.
?: (security.W018) You should not have DEBUG set to True in deployment.
?: (security.W020) ALLOWED_HOSTS must not be empty in deployment.
```

