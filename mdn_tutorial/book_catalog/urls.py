from django.urls import path, re_path
from . import views

# When the views are classes, they must be called via .as_view().

# The name='index' is the name of this index page,
# This is the name used in reversed URL mapping.
# pk: primary key
urlpatterns = [
    path(route= "", view=views.index, name="index"),
    path(route="books/", view=views.BookListView.as_view(), name="books"),
    # path(route="book/<int:pk>/", view=views.BookDetailView.as_view(), name='book-detail'),
    # The path can also be written like this:
    re_path(route=r'^books/(?P<pk>\d+)/$', view=views.BookDetailView.as_view(), name='book-detail'),
    path(route="authors/", view=views.AuthorListView.as_view(), name="authors"),
    path(route="author/<int:pk>/", view=views.AuthorDetailView.as_view(), name="author-detail"),
    path(route="mybooks/", view=views.LoanedBooksByUserListView.as_view(), name="my-borrowed"),
    path(route="allborrowed/", view=views.LoanedBooksAllListView.as_view(), name="allborrowed"),
    path(route="bookinstance/<int:pk>/renew/", view=views.renew_book_librarian, name="renew-book-librarian"),
]

# When adding in generic edit views for authors
urlpatterns += [
    path('author/create/', views.AuthorCreate.as_view(), name='author-create'),
    path('author/<int:pk>/update/', views.AuthorUpdate.as_view(), name='author-update'),
    path('author/<int:pk>/delete/', views.AuthorDelete.as_view(), name='author-delete'),
]

# When adding in generic edit views for books
urlpatterns += [
    path('books/create/', views.BookCreate.as_view(), name='book-create'),
    path('books/<int:pk>/update/', views.BookUpdate.as_view(), name='book-update'),
    path('books/<int:pk>/delete/', views.BookDelete.as_view(), name='book-delete'),
    # using model form to create book
    path('books/create-model/', views.create_book_librarian, name='book-create-model'),
]

