# To test author create view

from django.test import TestCase
from django.urls import reverse

from django.contrib.contenttypes.models import ContentType
from django.contrib.auth.models import Permission 

from book_catalog.models import Author, Book, BookInstance
import datetime

from django.contrib.auth import get_user_model
User = get_user_model()

class AuthorCreateViewTest(TestCase):
    """Test case for the AuthorCreate view (Created as Challenge)."""

    def setUp(self):
        # Create a user
        test_user1 = User.objects.create_user(
            username='testuser1', password='1X<ISRUkw+tuK')
        test_user2 = User.objects.create_user(
            username='testuser2', password='2HJ1vRV0Z&3iD')

        test_user1.save()
        test_user2.save()

        content_typeBook = ContentType.objects.get_for_model(Book)

        permAddBook = Permission.objects.get(
            codename="add_book",
            content_type=content_typeBook,
        )

        content_typeAuthor = ContentType.objects.get_for_model(Author)
        permAddAuthor = Permission.objects.get(
            codename="add_author",
            content_type=content_typeAuthor,
        )


        test_user2.user_permissions.add(permAddBook, permAddAuthor)
        test_user2.save()

        # Create a book
        test_author = Author.objects.create(
            first_name='John', last_name='Smith')

    def test_redirect_if_not_logged_in(self):
        response = self.client.get(reverse('author-create'))
        self.assertRedirects(
            response, '/accounts/login/?next=/book_catalog/author/create/')

    def test_forbidden_if_logged_in_but_not_correct_permission(self):
        login = self.client.login(
            username='testuser1', password='1X<ISRUkw+tuK')
        response = self.client.get(reverse('author-create'))
        self.assertEqual(response.status_code, 403)

    def test_logged_in_with_permission(self):
        login = self.client.login(
            username='testuser2', password='2HJ1vRV0Z&3iD')
        response = self.client.get(reverse('author-create'))
        self.assertEqual(response.status_code, 200)

    def test_uses_correct_template(self):
        login = self.client.login(
            username='testuser2', password='2HJ1vRV0Z&3iD')
        response = self.client.get(reverse('author-create'))
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, 'book_catalog/author_form.html')

    def test_form_date_of_death_initially_set_to_expected_date(self):
        login = self.client.login(
            username='testuser2', password='2HJ1vRV0Z&3iD')
        response = self.client.get(reverse('author-create'))
        self.assertEqual(response.status_code, 200)

        expected_initial_date = datetime.date(1900, 11, 11)
        response_date = response.context['form'].initial['date_of_death']
        response_date = datetime.datetime.strptime(
            response_date, "%d/%m/%Y").date()
        self.assertEqual(response_date, expected_initial_date)

    def test_redirects_to_detail_view_on_success(self):
        login = self.client.login(
            username='testuser2', password='2HJ1vRV0Z&3iD')
        response = self.client.post(reverse('author-create'),
                                    {'first_name': 'Christian Name', 'last_name': 'Surname'})
        # Manually check redirect because we don't know what author was created
        self.assertEqual(response.status_code, 302)
        self.assertTrue(response.url.startswith('/book_catalog/author/'))