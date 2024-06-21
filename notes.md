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


