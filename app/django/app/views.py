from django.shortcuts import render, redirect, reverse
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.messages import error, success, INFO
from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
import os



def index(request):
    user = request.user
    token = Token.objects.get(user_id=user.id) if user is not None and user.is_authenticated else "none"

    POD_NAME = os.environ.get('POD_NAME')
    POD_NAMESPACE = os.environ.get('POD_NAMESPACE')
    NODE_NAME = os.environ.get('NODE_NAME')
    POD_IP = os.environ.get('POD_IP')
    POD_SERVICE_ACCOUNT_NAME = os.environ.get('SERVICE_ACCOUNT')
    HOSTNAME = os.environ.get('HOSTNAME')
    HOST_IP = os.environ.get('HOST')

    template = 'index.html'
    context = {
        'token': token,
        'POD_NAME': POD_NAME,
        'POD_NAMESPACE': POD_NAMESPACE,
        'NODE_NAME': NODE_NAME,
        'POD_IP': POD_IP,
        'POD_SERVICE_ACCOUNT_NAME': POD_SERVICE_ACCOUNT_NAME,
        'HOSTNAME': HOSTNAME,
        'HOST_IP': HOST_IP
    }

    return render(request, template, context)


def mock_login(request):
    if request.method == 'POST':
        username = request.POST['username']
        password = request.POST['password']
        is_existing_user = User.objects.filter(email=username).exists()
        if is_existing_user:
            email = User.objects.get(email=username).email
            user = authenticate(request, username=email, password=password)
            if user is not None:
                login(request, user)
                return redirect(index)
            else:
                error_message = "Please try again."
                messages.add_message(request, messages.ERROR, error_message)
                return redirect(reverse('app:mock_login'))
        else:
            new_user = User.objects.create_user(
                email=username,
                password=password,
                first_name='Dummy',
                last_name='User',
                username=username
                )

            token = Token.objects.create(user=new_user)
            login(request, new_user)
            return redirect(index)
    else:
        template = 'login.html'
        context = {}
        return render(request, template, context)


def mock_logout(request):
    logout(request)
    return redirect(index)
