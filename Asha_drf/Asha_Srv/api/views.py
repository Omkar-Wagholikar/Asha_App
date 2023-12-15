from rest_framework.response import Response
from rest_framework.decorators import api_view

import requests
import json

from base.models import QueryLog
from .serializers import QuerySerializer

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

    y = {
        "query": "malaria",
        "answers": [
            {
                "answer": "<p>Malaria is an illness caused   by the presence of malarial   parasite in the human body",
                "context": "<p>Malaria is an illness caused   by the presence of malarial   parasite in the human body.   It spreads through the bite of   mosquito. When a mosqui",
                "offsets_in_document": {
                    "start": 0,
                    "end": 90
                },
                "score": 0.023250412195920944,
                "meta": {
                    "name": "book-no-4-page-14.txt"
                }
            },
            {
                "answer": "blood film",
                "context": "ld be given to all fever cases if malaria is suspected after taking   blood film wherever possible. \n It should be given to all persons irrespective o",
                "offsets_in_document": {
                    "start": 128,
                    "end": 138
                },
                "score": 0.010698412545025349,
                "meta": {
                    "name": "book-no-4-page-15.txt"
                }
            },
            {
                "answer": "<p>",
                "context": "imaquine. \n Primaquine should not be given to infants and pregnant women \n<p>Whenever a case of fever is seen without any other sign/symptom   such as",
                "offsets_in_document": {
                    "start": 1120,
                    "end": 1123
                },
                "score": 0.0016254261136054993,
                "meta": {
                    "name": "book-no-4-page-15.txt"
                }
            }
        ]
    }
    
    return Response(x.json())