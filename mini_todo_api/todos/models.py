from django.db import models

class Todo(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField(default='')
    completed = models.BooleanField(default=False)
    can_level = models.IntegerField(default=0)
    duration_in_minutes = models.IntegerField(default=5)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title