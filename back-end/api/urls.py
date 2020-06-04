from django.urls import path, include
from .views import UserView, CommentView, ArticleView, UserOneView, UserUpdate

from api import views

urlpatterns = [
    path('users/', UserView.as_view()),
    path('comments/', CommentView.as_view()),
    path('articles/', ArticleView.as_view()),
    path('user/', UserOneView.as_view()),
    path('user/update', UserUpdate.as_view()),
]