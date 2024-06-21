from django.test import Client
from django.test import TestCase

# This test is not tested at all. Why???

# Status code: 200
# Redirect chain: [('book_catalog/', 301)]
class HomepageTest(TestCase):
    @classmethod
    def redirect_to_book_catalog(self):
        assert("redirect to homepage")
        response = self.client.get(path="/", follow=True)
        print(f"Status code: {response.status_code}")
        print(f"Redirect chain: {response.redirect_chain}")
        # This should be wrong.
        self.assertRedirects(response, "book_catalog_00/")
        


