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

