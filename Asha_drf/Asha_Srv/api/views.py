from rest_framework.response import Response
from rest_framework.decorators import api_view

import requests
import json

from base.models import QueryLog, ErrorLog

from .serializers import *

from django.http import FileResponse, HttpResponse
from django.shortcuts import get_object_or_404
from rest_framework.views import APIView
from rest_framework.response import Response
from pathlib import Path

import os

@api_view(['GET'])
def getData(request):
    items = QueryLog.objects.all()
    serial = QuerySerializer(items, many = True)
    
    return Response(serial.data)

@api_view(["POST"])
def addQuery(request):
    serial = QuerySerializer(data = request.data)
    if serial.is_valid():
        serial.save()
    else:
        return Response({"Status":"error"})
    return Response({"Status":"Success"})

@api_view(["POST", "GET"])
def answer(request):
    print({"query":request.data["query"]})
    x = requests.post("http://127.0.0.1:7000/check/", json = request.data)
    print(x.text)
    log = QueryLog()
    # log.query_text = request.data["query"]
    # log.answer_text = x.text
    # log.imageResponse = False
    try:
        log.enterData(
            query_text=request.data["query"], 
            answer_text=x.text, 
            imageResponse=False, 
            user=request.data["user"]
        )
    except:
        log.enterData(
            query_text=request.data["query"], 
            answer_text=x.text, 
            imageResponse=False, 
            user=""
        )
    finally:
        log.save()
    return Response(x.json())

@api_view(["GET","POST"])
def reportError(request):
    print("error received")
    err = ErrorLog()
    try:
        err.enterData(
            error_text=request.data["error"], 
            user=request.data["user"]
        )
    except:
        err.enterData(
            error_text=request.data["error"], user=""
        )
    finally:
        err.save()
    return Response({"message":"Error has been registered"})

class PdfFileView(APIView):
    def get(self, request, filename):
        
        response = FileResponse(open( os.getcwd() + f"/pdf_files/{filename}",'rb'))
        response['Content-Disposition'] = f'inline; filename="{filename}"'
        
        return response