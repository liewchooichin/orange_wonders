from django.urls import path, re_path
from . import views

# The name='index' is the name of this index page,
# This is the name used in reversed URL mapping.
# pk: primary key
urlpatterns = [
    path(route= "", view=views.index, name="index"),
    path(route="books/", view=views.BookListView.as_view(), name="books"),
    # path(route="book/<int:pk>", view=views.BookDetailView.as_view(), name='book-detail'),
    # The path can also be written like this:
    re_path(route=r'^books/(?P<pk>\d+)$', view=views.BookDetailView.as_view(), name='book-detail'),
    path(route="authors/", view=views.AuthorListView.as_view(), name="authors"),
    path(route="author/<int:pk>", view=views.AuthorDetailView.as_view(), name="author-detail"),
]

