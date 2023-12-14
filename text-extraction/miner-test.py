
import PyPDF2

def read_pdf(pdf_path):
    with open(pdf_path, 'rb') as file:
        pdf_reader = PyPDF2.PdfReader(file)
        text = ''
        
        for page_num in range(len(pdf_reader.pages)):
            page = pdf_reader.pages[page_num]
            text += page.extract_text()
        
    return text

def save_to_text(text, output_path):
    with open(output_path, 'w', encoding='utf-8') as output_file:
        output_file.write(text)

if __name__ == "__main__":
    pdf_path = 'C:/Users/DELL/Desktop/Asha/pdf-pages/book-no-1-page-101.pdf'
    output_path = 'C:/Users/DELL/Desktop/book-no-1-page-101.txt'

    pdf_text = read_pdf(pdf_path)
    save_to_text(pdf_text, output_path)
