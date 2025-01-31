
import socket

SERVER_HOST = 'jet.cs.utexas.edu'    # The remote host
SERVER_PORT = 50008                  # The port used by the server
MESSAGE = b'Hello, world!'

# Create a UDP socket
with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as client_socket:
    print('client is sending UDP message')
    
    # Send message to the server
    client_socket.sendto(MESSAGE, (SERVER_HOST, SERVER_PORT))
    print('message sent to server')

    # Receive response from the server
    data, server = client_socket.recvfrom(1024)
    print('received from server:', data.decode())
