# Echo client program
import socket
import time

SERVER_HOST = 'jet.cs.utexas.edu'    # The remote host
SERVER_PORT = 50008            # The same port as used by the server
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as client_socket:
    print('client is sending TCP connection request')
    client_socket.connect((SERVER_HOST, SERVER_PORT))
    print('server has accepted my tcp connection request')
    
    for i in range(3):
        print('sending Hello World to server')
        client_socket.sendall(b'Hello, world! ')


