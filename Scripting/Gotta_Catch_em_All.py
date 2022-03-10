# next scripting lesson

import socket
import re
import time

start_time = time.time()


class Gotta_Catch_em_All:

    def __init__(self):
        self.SERVER = "10.10.164.134" # IP-Maschine
        self.standart_Port = 3010
        self.next_PORT = 1337
        self.port_lib = {}
        self.number = 0

    def get_open_port(self):
        data = self.built_connection(self.standart_Port)
        data = data.decode('ascii')
        data = re.findall("\">(.+?)</a>", data)    
        return data

    def built_connection(self, PORT):
        try:
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
                s.connect((self.SERVER, PORT))
                request = "GET / HTTP/1.1\r\nHost:%s\r\n\r\n" % self.SERVER
                s.send(request.encode())
                data = s.recv(1024)
                s.close()
                return data
        except:
            return b"fail"

    def update_list(self, PORT):
        data = self.built_connection(PORT)
        data = data.decode('ascii')
        data = re.findall("GMT\\r\\n\\r\\n(.*)", data)
        if data != [] and data != "fail":
            self.port_lib[str(PORT)] = data[0].split()


    def do_the_math(self):
        if self.port_lib[str(self.next_PORT)][0] == 'add':
            self.number += float(self.port_lib[str(self.next_PORT)][1])
        elif self.port_lib[str(self.next_PORT)][0] == 'minus':
            self.number -= float(self.port_lib[str(self.next_PORT)][1])
        elif self.port_lib[str(self.next_PORT)][0] == 'multiply':
            self.number *= float(self.port_lib[str(self.next_PORT)][1])
        elif self.port_lib[str(self.next_PORT)][0] == 'divide':
            self.number /= float(self.port_lib[str(self.next_PORT)][1])

    def set_next_port(self):
        self.next_PORT = self.port_lib[str(self.next_PORT)][2]
    
    def view(self):
        print(str(self.number) 
        + " " + (self.port_lib[str(self.next_PORT)][0]) 
        + " " + (self.port_lib[str(self.next_PORT)][1])
        + " " +(self.port_lib[str(self.next_PORT)][2]))
    
    def start(self):
        print("--- start ---")
        while(True):
            data = self.get_open_port()
            if data != [] and data[0] not in self.port_lib.keys():
                self.update_list(int(data[0]))
            if str(self.next_PORT) in self.port_lib.keys():
                if self.port_lib[str(self.next_PORT)][0] == 'STOP':
                    print("--- %s seconds ---" % (time.time() - start_time))
                    break
                self.do_the_math()
                self.view()
                self.set_next_port() 

if __name__ == "__main__":
    a = Gotta_Catch_em_All()
    a.start()
