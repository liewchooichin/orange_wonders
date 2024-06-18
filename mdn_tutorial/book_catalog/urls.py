from django.urls import path
from . import views

# The name='index' is the name of this index page,
# This is the name used in reversed URL mapping.
urlpatterns = [
    path(route= "", view=views.index, name='index'),
]

