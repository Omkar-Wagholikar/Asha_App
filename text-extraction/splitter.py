from PyPDF2 import PdfWriter, PdfReader
# C:/Users/DELL/Desktop/Asha/pdfs/book-no-1.pdf
# C:/Users/DELL/Desktop/Asha/pdf-pages

def splitPages(readPath, writePath, fileName):
    inputpdf = PdfReader(open(readPath + "/" + fileName, "rb"))

    for i in range(len(inputpdf.pages)):
        output = PdfWriter()
        output.add_page(inputpdf.pages[i])
        with open(writePath + "/" + fileName[:-4] + "-page-%s.pdf" % (i+1), "wb") as outputStream:
            output.write(outputStream)


# # # # Clear the folder
import os
def clearFolder(folder_path):
    for filename in os.listdir(folder_path):
        file_path = os.path.join(folder_path, filename)
        try:
            if os.path.isfile(file_path):
                os.remove(file_path)
        except Exception as e:
            print(f"Error deleting {file_path}: {e}")

    print("All files in the folder have been deleted.")

readPath = "F:/Asha/Asha_pdfs/pdfs/"
writePath = "F:/Asha/Asha_ui/asha_fe/assets/pdfs"

clearFolder(writePath)
# splitPages(readPath, writePath, "asha_ncd.pdf")
for i in range(1, 8):
    print(i)
    splitPages(readPath, writePath, "book-no-" + str(i) + ".pdf")