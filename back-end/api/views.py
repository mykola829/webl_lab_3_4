from django.http import HttpResponseBadRequest
from rest_framework.response import Response
from rest_framework.views import APIView
from .models import User, Comment, Article
from .serializers import UserSerializer, ArticleSerializer, CommentSerializer
from django.core.exceptions import ObjectDoesNotExist
from django.http import Http404


class UserView(APIView):

    def get(self, request):
        users = User.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response({"users": serializer.data})

    def post(self, request):
        user = request.data
        serializer = UserSerializer(data=user)
        user_saved = None
        if serializer.is_valid(raise_exception=True):
            user_saved = serializer.save()
        return Response({"success": f"User created successfully"})


class UserOneView(APIView):
    
    def post(self, request):
        try:
            email, password = request.data['email'], request.data['password']
        except KeyError:
            raise Http404;

        try:
            user = User.objects.get(email=email, password=password)
        except ObjectDoesNotExist:
            raise Http404;

        serializer = UserSerializer(user)
        return Response(serializer.data)


class UserUpdate(APIView):

    def post(self, request):
        print(request.data)
        users = User.objects.get(id=request.data['id'])
        users.name = request.data['name']
        users.surname = request.data['surname']
        users.save()
        return Response()


class ArticleView(APIView):

    def get(self, request):
        articles = Article.objects.all()
        serializer = ArticleSerializer(articles, many=True)
        return Response({"articles": serializer.data})

    def post(self, request):
        article = request.data
        serializer = ArticleSerializer(data=article)
        article_saved = None
        if serializer.is_valid(raise_exception=True):
            article_saved = serializer.save()
        return Response({"success": f"Article created successfully"})


class CommentView(APIView):

    def get(self, request):
        comments = Comment.objects.all()
        serializer = CommentSerializer(comments, many=True)
        return Response({"comments": serializer.data})

    def post(self, request):
        comment = request.data
        serializer = CommentSerializer(data=comment)
        comment_saved = None
        if serializer.is_valid(raise_exception=True):
            comment_saved = serializer.save()
        return Response({"success": f"Comment created successfully"})
