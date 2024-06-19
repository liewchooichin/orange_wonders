from django.contrib import admin

# Register your models here.
from .models import Author, Genre, Book, BookInstance, Language

# Register a ModelAdmin class
#admin.site.register(Author)

# Use default admin
admin.site.register(Genre)
#admin.site.register(Book)
#admin.site.register(BookInstance)

admin.site.register(Language)

# Inline Book detail to the AuthorAdmin
class BookInline(admin.TabularInline):
    model = Book
    # To NOT list the three extra rows
    extra = 0

# Define the admin class
class AuthorAdmin(admin.ModelAdmin):
    list_display = ('last_name', 'first_name', 'date_of_birth', 'date_of_death')
    # filter must be a list or a tuple
    list_filter = ['last_name']
    fields = ['first_name', 'last_name', ('date_of_birth', 'date_of_death')]
    # To exclude a field:
    #exclude = ['date_of_birth']
    inlines = [BookInline]

# Register the admin class with the associated model
admin.site.register(Author, AuthorAdmin)


# The @register decorator to register the models (this does 
# exactly the same thing as the admin.site.register() syntax):

# Inline editing of associated records
# TabularInline: horizontal
# StackedInline: vertical
class BooksInstanceInline(admin.TabularInline):
    model = BookInstance
    # To NOT list the three extra rows
    extra = 0

# Register the Admin classes for Book using the decorator
@admin.register(Book)
class BookAdmin(admin.ModelAdmin):
    # Paginate for admin site
    list_per_page = 10
    
    list_display = ('title', 'author', 'display_genre')
    # the list must be a list or a tuple
    list_filter = ['author']
    inlines = [BooksInstanceInline]

# Register the Admin classes for BookInstance using the decorator
@admin.register(BookInstance)
class BookInstanceAdmin(admin.ModelAdmin):
    # Paginate for admin site
    list_per_page = 10
    
    # This can list the display
    list_display = ('display_title', 'status', 'due_back', 'borrower')
    list_filter = ('status', 'due_back')
    # Using fieldsets to group the information:
    
    fieldsets = (
        (None, {
            'fields': ('book', 'imprint')
        }),
        ('Availability', {
            'fields': ('status', 'due_back', 'borrower')
        }),
    )
    



