# Generated by Django 3.0.6 on 2020-06-03 19:15

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0005_article_category'),
    ]

    operations = [
        migrations.DeleteModel(
            name='Like',
        ),
    ]
