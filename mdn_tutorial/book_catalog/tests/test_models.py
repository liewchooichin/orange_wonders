from django.test import TestCase

# Create your tests here.
# You should NOT normally include print() functions in your tests as shown below. 

# Test the Author model

from book_catalog.models import Author

class AuthorModelTest(TestCase):
    @classmethod
    def setUpTestData(cls):
        # Set up non-modified objects used by all test methods
        Author.objects.create(first_name='Big', last_name='Bob')

    def test_first_name_label(self):
        author = Author.objects.get(id=1)
        field_label = author._meta.get_field('first_name').verbose_name
        self.assertEqual(field_label, 'first name')
    
    def test_last_name_label(self):
        author = Author.objects.get(id=1)
        field_label = author._meta.get_field('last_name').verbose_name
        self.assertEqual(field_label, 'last name')

    def test_date_of_birth_label(self):
        author = Author.objects.get(id=1)
        field_label = author._meta.get_field('date_of_birth').verbose_name
        self.assertEqual(field_label, 'date of birth')

    def test_date_of_death_label(self):
        author = Author.objects.get(id=1)
        field_label = author._meta.get_field('date_of_death').verbose_name
        self.assertEqual(field_label, 'died')
        
    def test_first_name_max_length(self):
        author = Author.objects.get(id=1)
        max_length = author._meta.get_field('first_name').max_length
        self.assertEqual(max_length, 100)

    def test_last_name_max_length(self):
        author = Author.objects.get(id=1)
        max_length = author._meta.get_field('last_name').max_length
        self.assertEqual(max_length, 100)

    def test_object_name_is_first_name_last_name(self):
        author = Author.objects.get(id=1)
        expected_object_name = f'{author.first_name} {author.last_name}'
        self.assertEqual(str(author), expected_object_name)

    def test_get_absolute_url(self):
        author = Author.objects.get(id=1)
        # This will also fail if the urlconf is not defined.
        self.assertEqual(author.get_absolute_url(), '/book_catalog/author/1/')










# Sample test classes
class MyTestClass(TestCase):
    @classmethod
    def setUpTestData(cls):
        # setUpTestData: Run once to set up non-modified data for all class methods. You'd use this to 
        # create objects that aren't going to be modified or changed in any of the test methods.
        pass

    def setUp(self):
        # setUp: Run once for every test method to set up clean data. is It is called before every 
        # test function to set up any objects that may be modified by the test (every test function 
        # will get a "fresh" version of these objects).
        pass

    def tearDown(self):
        # tearDown: It is called immediately after the test method has been called and the result 
        # recorded. This method isn't particularly useful for database tests, since the TestCase base 
        # class takes care of database teardown for you.
        pass

    def test_false_is_false(self):
        #print("Method: test_false_is_false.")
        self.assertFalse(False)

    def test_true_is_true(self):
        #print("Method: test_false_is_true.")
        self.assertTrue(True)

    def test_one_plus_one_equals_two(self):
        #print("Method: test_one_plus_one_equals_two.")
        self.assertEqual(1 + 1, 2)
