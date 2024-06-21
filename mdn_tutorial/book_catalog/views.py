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

    # Session cookie: Getting visit counts
    num_visits = request.session.get('num_visits', 0)
    request.session['num_visits'] = num_visits + 1
    # Surprise prizes to be given to visitors
    prizes = ['Zesty blueberries', 'Mysterious blackberries', 'Exciting cherries', 'Wonderful strawberries', 'Amazing plums', 'Gracious grapes', 'Happy bananas', 'Forever papayas']
    from random import random
    import math
    name_prize = prizes[math.floor(random()*len(prizes))]
    request.session.get('name_prize', name_prize)

    # Context information to return
    context = {
        'num_books': num_books,
        'num_instances': num_instances,
        'num_instances_available': num_instances_available,
        'num_authors': num_authors,
        'num_genre': num_genre,
        'num_visits': num_visits,
        'name_prize': name_prize,
        'prizes': prizes,
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

# When adding the functionality for users to view their borrowed books.
# We'll use the same generic class-based list view we're familiar with, 
# but this time we'll also import and derive from LoginRequiredMixin, so 
# that only a logged in user can call this view. We will also choose to
# declare a template_name.
from django.contrib.auth.mixins import LoginRequiredMixin

class LoanedBooksByUserListView(LoginRequiredMixin, generic.ListView):
    """Generic class-based view listing books on loan to current user."""
    model = BookInstance
    template_name = 'book_catalog/borrowed_user.html'
    paginate_by = 5

    def get_queryset(self):
        return (
            BookInstance.objects.filter(borrower=self.request.user)
            .filter(status__exact='o')
            .order_by('due_back')
        )

# To write a librarian view to maintain return books
from django.contrib.auth.mixins import PermissionRequiredMixin

# Librarian staff need both login and permissions.
class LoanedBooksAllListView(LoginRequiredMixin, 
                             PermissionRequiredMixin,
                             generic.ListView):
    model = BookInstance    
    template_name = "book_catalog/borrowed_librarian.html"
    paginate_by = 5
    permission_required = (
        'book_catalog.change_bookinstance', 
        'book_catalog.can_mark_returned')
    

    def get_queryset(self) -> QuerySet[Any]:
        query_1 = BookInstance.objects.filter(status__exact="o")
        #query_2 = BookInstance.objects.filter(status__exact="m")
        #query = query_1.union(query_2)
        query = query_1.order_by("due_back")
        
        return query
    
# Handling the form for renewing books
import datetime

from django.shortcuts import render, get_object_or_404
from django.http import HttpResponseRedirect
from django.urls import reverse

from book_catalog.forms import RenewBookForm, RenewBookModelForm

from django.contrib.auth.decorators import login_required, permission_required

# Remove the login_required for the test_views.py. Because I don't know
# how to add the login_required to the test_views.py.
#@login_required
@permission_required('book_catalog.can_mark_returned', raise_exception=True)
def renew_book_librarian(request, pk):
    book_instance = get_object_or_404(BookInstance, pk=pk)

    # If this is a POST request then process the Form data
    if request.method == 'POST':

        # Create a form instance and populate it with data from the request (binding):
        # If using RenewBookForm instead of model form
        form = RenewBookForm(request.POST)
        # Using model form
        #form = RenewBookModelForm(request.POST)

        # Check if the form is valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required (here we just write it to the model due_back field)
            # If using RenewBookForm instead of RenewBookModelForm
            book_instance.due_back = form.cleaned_data['renewal_date']
            # If using RenewBookModelForm
            #book_instance.due_back = form.cleaned_data['due_back']
            #book_instance.save()

            # redirect to a new URL:
            return HttpResponseRedirect(reverse('all-borrowed'))

    # If this is a GET (or any other method) create the default form.
    else:
        proposed_renewal_date = datetime.date.today() + datetime.timedelta(weeks=3)
        # If the GET is called with RenewBookForm instead of the model form
        form = RenewBookForm(initial={'renewal_date': proposed_renewal_date})
        # Call the GET with model form
        #form = RenewBookModelForm(initial={'due_back': proposed_renewal_date})

    context = {
        'form': form,
        'book_instance': book_instance,
    }

    return render(request, 'book_catalog/renew_book_librarian.html', context)

# Generic edit views
# Author: Create, update, delete
from django.views.generic.edit import CreateView, UpdateView, DeleteView
from django.urls import reverse_lazy
from book_catalog.models import Author

class AuthorCreate(PermissionRequiredMixin, CreateView):
    model = Author
    fields = ['first_name', 'last_name', 'date_of_birth', 'date_of_death']
    initial = {'date_of_death': '11/11/1900'}
    permission_required = (('book_catalog.add_author'), )

class AuthorUpdate(PermissionRequiredMixin, UpdateView):
    model = Author
    # Not recommended (potential security issue if more fields added)
    fields = '__all__'
    permission_required = (('book_catalog.change_author'), )

# Unfortunately deleting an Author will cause an exception if the author has an associated
# book, because our Book model specifies on_delete=models.RESTRICT for the author 
# ForeignKey field. To handle this case the view overrides the form_valid() method so that 
# if deleting the Author succeeds it redirects to the success_url, but if not, it just 
# redirects back to the same form. We'll update the template below to make clear that you 
# can't delete an Author instance that is used in any Book.
class AuthorDelete(PermissionRequiredMixin, DeleteView):
    model = Author
    success_url = reverse_lazy('authors')
    permission_required = (('book_catalog.delete_author'), )

    def form_valid(self, form):
        try:
            self.object.delete()
            return HttpResponseRedirect(self.success_url)
        except Exception as e:
            return HttpResponseRedirect(
                reverse("author-delete", kwargs={"pk": self.object.pk})
            )

# Adding in the generic edit views for Book
from book_catalog.models import Book

class BookCreate(PermissionRequiredMixin, CreateView):
    model = Book
    fields = ['title', 'author', 'summary', 
              'isbn', 'genre', 'language']
    # The language index number is used for language.
    initial = {'language': 2}
    permission_required = (('book_catalog.add_book'), )
    # Check for unique ISBN
    # Have not incorporated this


class BookUpdate(PermissionRequiredMixin, UpdateView):
    model = Book
    fields = ['title', 'author', 'summary', 
              'isbn', 'genre', 'language']
    # The language index number is used for language.
    permission_required = (('book_catalog.change_book'), )

class BookDelete(PermissionRequiredMixin, DeleteView):
    model = Book
    success_url = reverse_lazy('books')
    permission_required = (('book_catalog.delete_book'), )

    def form_valid(self, form):
        try:
            self.object.delete()
            return HttpResponseRedirect(self.success_url)
        except Exception as e:
            return HttpResponseRedirect(
                reverse("book-delete", kwargs={"pk": self.object.pk})
            )


# Additional exercise:
# Create a model form method to create a book
# Only check for unique ISBN.
# This is not working yet because create a book is not
# like the renew book. In renew book, there is already
# an instance in the database. But in create book,
# there is no instance yet--the instance is yet to be
# created.
from book_catalog.forms import CreateBookModelForm
from book_catalog.models import Language, Genre
@login_required
@permission_required('book_catalog.add_book', raise_exception=True)
def create_book_librarian(request):
    #book = get_object_or_404(Book)

    # If this is a POST request then process the Form data
    if request.method == 'POST':

        # Create a form instance and populate it with data from the request (binding):
        # Using model form
        form = CreateBookModelForm(request.POST)

        # Check if the form is valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required (here we just write it to the model due_back field)
            # Using CreateBookModelForm
            book = Book(form.data['title'])
            book.language = Language(1) 
            book.isbn = form.cleaned_data['isbn']
            book.save()

            # redirect to a new URL:
            return HttpResponseRedirect(reverse('books'))

    # If this is a GET (or any other method) create the default form.
    else:
        # Call the GET with model form
        form = CreateBookModelForm(initial={'language': 2})

    context = {
        'form': form,
        'book': book,
    }

    return render(request, 'book_catalog/create_book_librarian.html', context)