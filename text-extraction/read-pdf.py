import PyPDF2
 
pdfFileObj = open('pdfs/book-no-1.pdf', 'rb')
pdfReader = PyPDF2.PdfReader(pdfFileObj)
print(pdfReader.pages)
for p in range(13, 13+31-14):
    pageObj = pdfReader.pages[p]
    f = open(f"text-as-page/page{p}.txt", "w")
    f.write(pageObj.extract_text().replace("", ""))

    f.close()
# print(pageObj.extractText())
pdfFileObj.close()