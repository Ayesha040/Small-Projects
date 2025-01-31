import socket

SERVER_HOST = ''                     # Bind to all available interfaces
SERVER_PORT = 50008                  # Arbitrary non-privileged port

# Create a UDP socket
with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as server_socket:
    server_socket.bind((SERVER_HOST, SERVER_PORT))
    print(f"Server is listening on port {SERVER_PORT}")

    while True:
        print('waiting to receive message from client...')
        # Receive message from client
        data, client_address = server_socket.recvfrom(1024)
        print(f"received message: {data.decode()} from {client_address}")
        
        # Send response back to client
        response = b"Message received!"
        server_socket.sendto(response, client_address)
        print(f"response sent to {client_address}")
