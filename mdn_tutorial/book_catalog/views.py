from typing import Any
from django.db.models.query import QuerySet
from django.shortcuts import render
from .models import Book, Author, BookInstance, Genre

# Create your views here.

def index(request):
    """View function for home page of site."""
    # Generate counts of some of the main objects
    num_books = Book.objects.all().count()
    num_instances = BookInstance.objects.all().count()

    # Available books (status = 'a')
    num_instances_available = BookInstance.objects.filter(status__exact='a').count()

    # The 'all()' is implied by default.
    num_authors = Author.objects.all().count()

    # Genre available
    num_genre = Genre.objects.all().count()

    # Books that contain a particular word (case insensitive)
    featured_books = Book.objects.filter(title__contains="angels")[0].title
    # This line will give [title1, title2]
    #featured_books = [book.title for book in featured_book_list]
    # Trying various python code.
    #for i, book in enumerate(featured_book_list):
    #    featured_books += f"{book.title}, "

    context = {
        'num_books': num_books,
        'num_instances': num_instances,
        'num_instances_available': num_instances_available,
        'num_authors': num_authors,
        'num_genre': num_genre,
        'featured_books': featured_books,
        'title_of_page': "Local Library at The End of the River",
    }

    # Render the HTML template index.html with the data in the context variable
    return render(request=request, 
                  template_name='index.html', context=context)

# Using Class ListView

from django.views import generic

# Within the template, we can access the list of books with template variable
# <the_model_name>_list, e.g. book_list.
# The generic views look for templates in /application_name/the_model_name_list.html
#  (catalog/book_list.html in this case) inside the application's 
# /application_name/templates/ directory (/catalog/templates/).
class BookListView(generic.ListView):
    model = Book
    paginate_by = 10

# Book Detail View
class BookDetailView(generic.DetailView):
    model = Book


# Author List View
class AuthorListView(generic.ListView):
    model = Author
    paginate_by = 3

# Author Detail View
class AuthorDetailView(generic.DetailView):
    model = Author
    """
    def get_context_data(self, **kwargs: Any) -> dict[str, Any]:
        # Call the base implementation first to get the context
        name = BookListView.get_context_data("author")
        title = BookListView.get_context_data("title")
        # call the base implementation first to get the context
        context = super(AuthorListView, self).get_context_data(**kwargs)
        context['book_title'] = title
        return context
    """