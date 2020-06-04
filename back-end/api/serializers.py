from rest_framework import serializers

from api.models import User, Article, Comment


class UserSerializer(serializers.ModelSerializer):

    class Meta:
        model = User
        fields = ['name', 'surname', 'email', 'password', 'id']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        return User.objects.create(**validated_data)


class ArticleSerializer(serializers.ModelSerializer):

    class Meta:
        model = Article
        fields = ['image_url', 'source_name', 'url', 'category', 'title', 'description', 'content', 'author', 'post_date_time', 'id']

    def create(self, validated_data):
        return Article.objects.create(**validated_data)


class CommentSerializer(serializers.ModelSerializer):

    class Meta:
        model = Comment
        fields = ['text', 'article', 'author', 'id']

    def create(self, validated_data):
        return Comment.objects.create(**validated_data)


