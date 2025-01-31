import socket
import threading

SERVER_HOST = ''                 # Symbolic name meaning all available interfaces
SERVER_PORT = 50008             # Arbitrary non-privileged port

def handle_client(servicing_socket, client_addr, thread_id):
    with servicing_socket:
        print('thread ' + str(thread_id) + ' started to serving')
        while True:
            print('waiting to recieve data from, ', client_addr)
            data = servicing_socket.recv(1024)
            if not data:
                break
            print('recieved data is: ', repr(data))
        print('thread ' + str(thread_id) + ' done to serving ')


with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((SERVER_HOST, SERVER_PORT))
    s.listen(1)
    print(" i opened a listening socket,", SERVER_PORT)    
    i = 0
    
    while True: 
        print('i am waiting for a client to do TCP conection request')
        servicing_socket, client_addr = s.accept() # new socket for evry new connection
        print('everytime a new client connects let a new thread handle it')
        worker_thread = threading.Thread(target=handle_client, args=(servicing_socket, client_addr, i))
        i = i + 1
        worker_thread.start()
