import datetime
from datetime import date

from django import forms

from django.core.exceptions import ValidationError
# If translation is needed in future.
#from django.utils.translation import gettext_lazy as _
from django.utils.translation import gettext_lazy

class RenewBookForm(forms.Form):
    renewal_date = forms.DateField(
        label="Renewal date",
        help_text="Enter a date between now and 4 weeks (default 3). Format: YYYY-MM-DD")

    def clean_renewal_date(self):
        data = self.cleaned_data['renewal_date']

        # My extra code to check if the data is indeed of the correct data type
        # before doing any further checking.
        if (type(data) == date) is False:
            raise ValidationError(
                gettext_lazy('Invalid date - date is not in the correct format. \
                             Format YYYY-MM-DD'))

        # Check if a date is not in the past.
        if data < datetime.date.today():
            raise ValidationError(gettext_lazy('Invalid date - renewal date is in past'))

        # Check if a date is in the allowed range (+4 weeks from today).
        if data > datetime.date.today() + datetime.timedelta(weeks=4):
            raise ValidationError(gettext_lazy('Invalid date - renewal date is more than 4 weeks'))

        # Remember to always return the cleaned data.
        return data


# Another way to create a form from a model
# This is only valid if the field comes from a SINGLE model
from django.forms import ModelForm

from book_catalog.models import BookInstance

class RenewBookModelForm(ModelForm):
    class Meta:
        model = BookInstance
        fields = ['due_back']
        labels = {'due_back': gettext_lazy('New renewal date')}
        help_texts = {'due_back': gettext_lazy('Enter a date between now and 4 weeks (default 3).')}
        error_message = {'due_back': ('Date format is YYYY-MM-DD')}

    def clean_due_back(self):
       data = self.cleaned_data['due_back']

       # Check if a date is not in the past.
       if data <= datetime.date.today():
           raise ValidationError(gettext_lazy('Invalid date - renewal date is in past'))

       # Check if a date is in the allowed range (+4 weeks from today).
       if data > datetime.date.today() + datetime.timedelta(weeks=4):
           raise ValidationError(gettext_lazy('Invalid date - renewal date is more than 4 weeks'))

       # Remember to always return the cleaned data.
       return data