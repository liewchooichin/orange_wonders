from django.template import Template, Context
from django.http import HttpResponse
from datetime import datetime, timedelta



def current_datetime(request):
    now = datetime.now()
    # This is the first demo of how to use views.
    #html = f"<html><body><p>It is now </p></body></html> {now}"
    # Next, using Template to render a page
    t = Template("<html><body>It is now {{ current_date }}. </body></html>")
    c = Context({'current_date': now})
    html = t.render(c)
    return HttpResponse(html)

def hours_ahead(request, offset):
    offset = int(offset)
    assert False
    dt = datetime.now() + timedelta(hours=offset)
    html = f"<html><body>In {offset} hour(s), it will be {dt}.</body></html>"
    return HttpResponse(html)