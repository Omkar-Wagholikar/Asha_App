from rest_framework.response import Response
from rest_framework.decorators import api_view

import requests
import json

from base.models import QueryLog
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
    x = requests.post("http://127.0.0.1:8000/check/", json = request.data)
    print(x.text)
    return Response(x.json())


class PdfFileView(APIView):
    def get(self, request, filename):
        # print(os.getcwd())

        # import base64
        # short_report = open( os.getcwd() + f"/pdf_files/{filename}", 'rb')
        # report_encoded = base64.b64encode(short_report.read())
        # return Response({
        #     'detail': filename, 
        #     'filename': report_encoded
        #     })
        # pdf_file = get_object_or_404(Path, "F:/Asha/Asha_drf/Asha_Srv/pdf_files/book-no-1-page-2.pdf")
        
        response = FileResponse(open( os.getcwd() + f"/pdf_files/{filename}",'rb'))
        response['Content-Disposition'] = f'inline; filename="{filename}"'
        
        return response