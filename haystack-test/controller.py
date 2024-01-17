import torch
from haystack.utils import clean_wiki_text
from haystack.utils import convert_files_to_docs
from haystack.utils import fetch_archive_from_http
from haystack.utils import print_answers
from haystack.nodes import FARMReader, TransformersReader

doc_dir = "/elastic_controller/pages/text-as-page"
docs = convert_files_to_docs(dir_path=doc_dir, clean_func=clean_wiki_text, split_paragraphs=True)

from haystack.document_stores import ElasticsearchDocumentStore
# ========================================
document_store = ElasticsearchDocumentStore(
    host="localhost",  # Use the HTTPS scheme
    username="elastic",
    password="GPvaCsQYvSnI_EkU3vLV",
    index="full-clean-1",
    verify_certs=True,  # Set this to True if you want to verify the SSL certificate
    # ssl_show_warn=False,  # Set this to False if you don't want to show SSL warnings
)

document_store.write_documents(docs)

