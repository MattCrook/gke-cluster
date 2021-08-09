from django.contrib import admin
from django.urls import path
from django.conf.urls import include
from rest_framework import routers
from app import views

router = routers.DefaultRouter()
# router.register(r'users', UserViewSet)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api-auth/', include('rest_framework.urls')),
    path('', views.index, name='index'),


]
