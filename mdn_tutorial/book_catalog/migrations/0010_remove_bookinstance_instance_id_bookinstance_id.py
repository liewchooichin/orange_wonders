# Generated by Django 5.0.6 on 2024-06-18 03:38

import uuid
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('book_catalog', '0009_alter_bookinstance_status'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='bookinstance',
            name='instance_id',
        ),
        migrations.AddField(
            model_name='bookinstance',
            name='id',
            field=models.UUIDField(default=uuid.uuid4, help_text='Unique ID for this particular book across whole library', primary_key=True, serialize=False),
        ),
    ]
