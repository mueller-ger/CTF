### First Pyhton script
import base64

def encoding(file_name):
    base64_bytes=file_name.encode('ascii')
    message_bytes=base64.b64decode(base64_bytes)
    message = message_bytes.decode('ascii')
    return message

Encodedfile=open("b64.txt", "r")
Encodedfile=Encodedfile.read()

for i in range(0,50):
    Encodedfile = encoding(Encodedfile)

print(Encodedfile)

