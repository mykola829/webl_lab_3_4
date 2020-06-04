from django.contrib import admin

from .models import User, Article, Comment


@admin.register(User)
class TrackAdmin(admin.ModelAdmin):
    list_display = ('name', 'surname', 'email')


@admin.register(Article)
class TrackAdmin(admin.ModelAdmin):
    list_display = ('title', 'url')


@admin.register(Comment)
class TrackAdmin(admin.ModelAdmin):
    list_display = ('author', 'article', 'text')