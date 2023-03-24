def fix_text(text):
    text = text.replace('"a', 'ä')
    text = text.replace('"o', 'ö')
    text = text.replace('"u', 'ü')
    return text

input = "Aktivit¨atsdiagramm"
print(fix_text(input))