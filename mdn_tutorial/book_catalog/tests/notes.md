# Notes on test

# 

# Note: The skeleton test file /catalog/tests.py was created automatically when 
# we built the Django skeleton website. It is perfectly "legal" to put all your 
# tests inside it, but if you test properly, you'll quickly end up with a very 
# large and unmanageable test file.

# Delete the skeleton file as we won't need it.

# Reference

[Writing and running tests](https://docs.djangoproject.com/en/5.0/topics/testing/overview/)

## Run test

```
python3 manage.py collectstatic
```

## Specifying test files

```
# Run all the tests in the animals.tests module
$ ./manage.py test animals.tests

# Run all the tests found within the 'animals' package
$ ./manage.py test animals

# Run just one test case class
$ ./manage.py test animals.tests.AnimalTestCase

# Run just one test method
$ ./manage.py test animals.tests.AnimalTestCase.test_animals_can_speak
```

You can also provide a path to a directory to discover tests below that directory:

`$ ./manage.py test animals/`

You can specify a custom filename pattern match using the -p (or --pattern) option, if your test files are named differently from the test*.py pattern:

`$ ./manage.py test --pattern="tests_*.py"`

## help

```
(.venv) $ python manage.py test --keepdb --v 3 book_catalog.tests.test_models
usage: manage.py test [-h] [--noinput] [--failfast] [--testrunner TESTRUNNER] [-t TOP_LEVEL] [-p PATTERN]
                      [--keepdb] [--shuffle [SEED]] [-r] [--debug-mode] [-d] [--parallel [N]] [--tag TAGS]
                      [--exclude-tag EXCLUDE_TAGS] [--pdb] [-b] [--no-faulthandler] [--timing]
                      [-k TEST_NAME_PATTERNS] [--version] [--verbosity {0,1,2,3}] [--settings SETTINGS]
                      [--pythonpath PYTHONPATH] [--traceback] [--no-color] [--force-color]
                      [test_label ...]
```

## Do NOT capitalize the first letter

 The test was written expecting the label definition to follow Django's convention of **not** capitalizing the first letter of the label (Django does this for you).

## Skeleton

```
class YourTestClass(TestCase):
    @classmethod
    def setUpTestData(cls):
        print("setUpTestData: Run once to set up non-modified data for all class methods.")
        pass

    def setUp(self):
        print("setUp: Run once for every test method to set up clean data.")
        pass

    def test_false_is_false(self):
        print("Method: test_false_is_false.")
        self.assertFalse(False)

    def test_false_is_true(self):
        print("Method: test_false_is_true.")
        self.assertTrue(False)

    def test_one_plus_one_equals_two(self):
        print("Method: test_one_plus_one_equals_two.")
        self.assertEqual(1 + 1, 2)
```