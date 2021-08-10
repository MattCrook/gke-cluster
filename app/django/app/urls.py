from django.contrib import admin
from django.urls import path
from django.conf.urls import include
from .views import *


app_name = 'app'

urlpatterns = [
    path('login/', mock_login, name='mock_login'),
    path('logout/', mock_logout, name='mock_logout')
]
