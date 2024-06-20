"""
URL configuration for simple_date project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, re_path
from simple_date import views


urlpatterns = [
    path('admin/', admin.site.urls),
]

# Add the current_datetime function view
urlpatterns += [
    path(route='time/', view=views.current_datetime, name='current_datetime'),
    re_path(route=r'^time/plus/(?P<offset>[0-9]{1,2})/$', view=views.hours_ahead, name='hours_ahead'),
]

