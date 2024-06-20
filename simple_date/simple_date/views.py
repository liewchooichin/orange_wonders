from django.http import HttpResponse
from datetime import datetime, timedelta

def current_datetime(request):
    now = datetime.now()
    html = f"<html><body><p>It is now </p></body></html> {now}"
    return HttpResponse(html)

def hours_ahead(request, offset):
    offset = int(offset)
    assert False
    dt = datetime.now() + timedelta(hours=offset)
    html = f"<html><body>In {offset} hour(s), it will be {dt}.</body></html>"
    return HttpResponse(html)