from django.template import Context, Template
c = Context({"name": "Stephane"})
t = Template("My name is {{ name }}.")
t.render(c)

# Whenever you’re using the same template source to render multiple contexts 
# like this, it’s more efficient to 
# create the Template object once, and then call render() on it multiple 
# times:
# Bad
for name in ('John', 'Julie', 'Pat'):
    t = Template('Hello, {{ name }}')
    print (t.render(Context({'name': name})))

# Good
t = Template('Hello, {{ name }}')
for name in ('John', 'Julie', 'Pat'):
    print (t.render(Context({'name': name})))

# Using object attributes with Template
from django.template import Template, Context
import datetime
d = datetime.date(1993, 5, 2)
d.year
1993
d.month
5
d.day
2
t = Template('The month is {{ date.month }} and the year is {{ date.year }}.')
c = Context({'date': d})
t.render(c)
'The month is 5 and the year is 1993.'

# To call methods on objects
>>> from django.template import Template, Context
>>> t = Template('{{ var }} -- {{ var.upper }} -- {{ var.isdigit }}')
>>> t.render(Context({'var': 'hello'}))
'hello -- HELLO -- False'
>>> t.render(Context({'var': '123'}))
'123 -- 123 -- True'

# To list indices
>>> from django.template import Template, Context
>>> t = Template('Item 2 is {{ items.2 }}.')
>>> c = Context({'items': ['apples', 'bananas', 'carrots']})
>>> t.render(c)
'Item 2 is carrots.'
>>> t = Template('Item 0 is {{ items.0.upper }}.')
>>> t.render(c)
'Item 0 is APPLES.'
