from django.db import models


class User(models.Model):
    name = models.CharField(max_length=255)
    surname = models.CharField(max_length=255)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=255)

    def __str__(self):
        return self.email


class Article(models.Model):
    image_url = models.URLField()
    url = models.URLField()
    category = models.CharField(max_length=64)
    source_name = models.CharField(max_length=512)
    title = models.CharField(max_length=512)
    description = models.CharField(max_length=2048)
    content = models.CharField(max_length=2048)
    author = models.CharField(max_length=512)
    post_date_time = models.DateTimeField()

    def __str__(self):
        return self.title


class Comment(models.Model):
    text = models.CharField(max_length=2048)
    author = models.CharField(max_length=512)
    article = models.ForeignKey(Article, on_delete=models.CASCADE)

    def __str__(self):
        return self.text
