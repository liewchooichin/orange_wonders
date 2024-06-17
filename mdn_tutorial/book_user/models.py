from django.db import models
from datetime import date
#from ..book_catalog import BookInstance

# Create your models here.
class BookUser(models.Model):
    BookUserId = models.SmallAutoField(primary_key=True)
    # Name must have a value
    BookUserName = models.CharField(max_length=64, help_text="Your username", verbose_name="Username",
                                    blank=False, unique=True)
    # Email can be blank and default null=NULL
    BookUserEmail = models.EmailField(max_length=64, help_text="Your username", verbose_name="Email",
                                    blank=True, null=True, unique=False)
    
    # User subscription group
    FREE = 0
    BASIC = 1
    PREMIUM = 2
    GROUP_CHOICES = {
        FREE: "Free",
        BASIC: "Basic",
        PREMIUM: "Premium",
    }
    BookUserGroup = models.PositiveSmallIntegerField(help_text="Your subscription plan", verbose_name="Subscription plan",
                                     blank=False, default=FREE, choices=GROUP_CHOICES)

    # Expiration date of subscription
    # Expiration date cannot be blank
    FREE_GROUP_VALIDITY = date(year=2026, month=12, day=31)
    BookUserValidityDate = models.DateField(help_text="Subscription is valid till this date", verbose_name="Expiration date",
                                            blank=False, default=FREE_GROUP_VALIDITY)
    
    # One-to-many relationship
    # One user can borrow many books.
    # A user can have no books borrowed.
    # A book can have no borrowers.
    """
    BookUserLoan = models.ManyToManyField(BookInstance, 
                                     verbose_name="Number of books borrowed",
                                     blank=True, null=True)
    """

    # Metadata class
    class Meta:
        ordering = ["BookUserGroup"]
        verbose_name = "Book users"

    # A string describing itself
    def __str__(self):
        return f"Username: {self.BookUserName}, subscription plan: {self.BookUserGroup}"


