# Generated by Django 5.0 on 2024-01-07 04:24

from django.db import migrations


class Migration(migrations.Migration):
    dependencies = [
        ("base", "0007_errorlog_user"),
    ]

    operations = [
        migrations.DeleteModel(
            name="User",
        ),
    ]