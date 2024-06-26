from django.db import models

# Add the conf settings when adding in the users borrowing books function
from django.conf import settings

# To check whether a book is overdue.
from datetime import date

# Create your models here.

from django.urls import reverse # Used in get_absolute_url() to get URL for specified ID

from django.db.models import UniqueConstraint # Constrains fields to unique values
from django.db.models.functions import Lower # Returns lower cased value of field

# Genre class
class Genre(models.Model):
    """Model representing a book genre."""
    name = models.CharField(
        max_length=200,
        unique=True,
        verbose_name="Genre",
        help_text="Enter a book genre (e.g. Science Fiction, French Poetry etc.)"
    )

    def __str__(self):
        """String for representing the Model object."""
        return self.name

    def get_absolute_url(self):
        """Returns the url to access a particular genre instance."""
        return reverse('genre-detail', args=[str(self.id)])

    class Meta:
        constraints = [
            UniqueConstraint(
                Lower('name'),
                name='genre_name_case_insensitive_unique',
                violation_error_message = "Genre already exists (case insensitive match)"
            ),
        ]
        ordering = ["name"]

# Book class
class Book(models.Model):
    """Model representing a book (but not a specific copy of a book)."""
    # on_delete=models.RESTRICT, which will prevent the book's associated author 
    # being deleted if it is referenced by any book.
    # By default on_delete=models.CASCADE, which means that if the author was 
    # deleted, this book would be deleted too! 
    title = models.CharField(max_length=200, help_text="Title of the book")
    author = models.ForeignKey('Author', on_delete=models.RESTRICT, null=True)
    
    class Meta:
        ordering = ['title']

    # Foreign Key used because book can only have one author, but authors can have multiple books.
    # In practice a book might have multiple authors, but not in this implementation.
    # Author as a string rather than object because it hasn't been declared yet in file.
    summary = models.TextField(
        max_length=1000, help_text="Enter a brief description of the book")
    
    isbn = models.CharField(verbose_name='ISBN',
                            max_length=13,
                            unique=True,
                            help_text='13 Character <a href="https://www.isbn-international.org/content/what-isbn'
                                      '">ISBN number</a>')

    # ManyToManyField used because genre can contain many books. Books can cover many genres.
    # Genre class has already been defined so we can specify the object above.
    genre = models.ManyToManyField(
        to=Genre, help_text="Select a genre for this book")
    # Main language of the book
    language = models.ForeignKey(
        to="Language",
        verbose_name='Language', on_delete=models.SET_NULL, null=True,
        help_text="Main language used in the book")

    def __str__(self):
        """String for representing the Model object."""
        return self.title

    def get_absolute_url(self):
        """Returns the URL to access a detail record for this book."""
        return reverse('book-detail', args=[str(self.id)])
    
    # This creates a string from the first three values of the genre field (if they exist)
    #  and creates a short_description that can be used in the admin site for this method.
    def display_genre(self):
        """Create a string for the Genre. This is required to display genre in Admin."""
        return ', '.join(genre.name for genre in self.genre.all()[:3])

    display_genre.short_description = 'Genre'


# BookInstance
# The BookInstance represents a specific copy of a book that someone might 
# borrow, and includes information about whether the copy is available or on 
# what date it is expected back, "imprint" or version details, and a unique id 
# for the book in the library.
import uuid # Required for unique book instances

class BookInstance(models.Model):

    """Model representing a specific copy of a book (i.e. that can be borrowed from the library)."""
    #id = models.UUIDField(primary_key=True, default=uuid.uuid4,
                          #help_text="Unique ID for this particular book across whole library")
    id = models.SmallAutoField(primary_key=True)
    book = models.ForeignKey(to='Book', on_delete=models.RESTRICT, null=True)
    imprint = models.CharField(max_length=200)
    due_back = models.DateField(null=True, blank=True)

    # Library users
    # This maps to the default User model from django.contrib.auth.models. 
    borrower = models.ForeignKey(settings.AUTH_USER_MODEL,
                                 on_delete=models.SET_NULL, null=True, blank=True)
    
    LOAN_STATUS = [
        ('m', 'Maintenance'),
        ('o', 'On loan'),
        ('a', 'Available'),
        ('r', 'Reserved'),
    ]

    status = models.CharField(
        max_length=1,
        choices=LOAN_STATUS,
        blank=True,
        default='m',
        help_text='Book availability',
    )

    class Meta:
        ordering = ['-due_back']
        permissions = (("can_mark_returned", "Set book as returned"), )

    def __str__(self):
        """String for representing the Model object."""
        return f"{self.book.title} ({self.id})"
    
    # Check for over due
    @property
    def is_overdue(self):
        """Determines if the book is overdue based on due date and current date."""
        return bool(self.due_back and date.today() > self.due_back)


    def display_title(self):
        """Display title of the book"""
        result = f"{self.book.title}"
        return result
    display_title.short_description = "Title of a book"

    def display_status(self):
        """Display status of each book instance"""
        result = self.LOAN_STATUS
        return result
    display_status.short_description = "Status of the book"

    def display_due_back(self):
        result = f"{self.due_back}"
        return result
    display_status.short_description = "Due back on this date"

# Author model
class Author(models.Model):
    """Model representing an author."""
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    date_of_birth = models.DateField(null=True, blank=True)
    date_of_death = models.DateField(verbose_name='died', null=True, blank=True)

    class Meta:
        ordering = ['first_name']

    def get_absolute_url(self):
        """Returns the URL to access a particular author instance."""
        return reverse('author-detail', args=[str(self.id)])

    def __str__(self):
        """String for representing the Model object."""
        return f'{self.first_name} {self.last_name}'

# Language model
class Language(models.Model):

    name = models.CharField(verbose_name="Language", 
                            max_length=200,
                            unique=True,
                            help_text="Main language used in the book",
                            blank=False, default="English")
    notes = models.TextField(verbose_name="Special notes",
                             max_length=256,
                             help_text="Like American English, Singlish, \
                             Simplified Chinese, Traditional Chinese, etc.",
                             blank=True, null=True)

    def get_absolute_url(self):
        """Return the url to access a particular language instance."""
        return reverse("language-detail", args=[str(self.id)])

    def __str__(self) -> str:
        """String for representing the Model object (in Admin site etc)."""
        return f"{self.name}"

    class Meta:
        constraints = [
            UniqueConstraint(
                Lower("name"),
                name="language_name_case_insensitive_unique",
                violation_error_message="Language already exists (case insensitive match)"
            ),
        ]
        ordering = ["name"]