from django.db import models

# Create your models here.
class QueryLog(models.Model):
    query_id = models.AutoField(primary_key=True)
    query_text = models.TextField(default="Q")
    answer_text = models.TextField(default="A")
    timestamp = models.DateTimeField(auto_now_add=True)
    imageResponse = models.BooleanField(default=False)
    user = models.TextField(default="-")

    def enterData(self, query_text, answer_text, imageResponse, user):
        self.query_text = query_text
        self.answer_text = answer_text
        self.imageResponse = imageResponse
        if user != "":
           self.user = user
        return
    
    def __str__(self):
        return self.query_text

class ErrorLog(models.Model):
    error_id = models.AutoField(primary_key=True)
    error_text = models.TextField(default = "E")
    timestamp = models.DateTimeField(auto_now_add = True)
    user = models.TextField(default = "-")

    def enterData(self, error_text, user):
        self.error_text = error_text
        if user != "":
            self.user = user
        return
    
    def __str__(self):
        return self.error_text
