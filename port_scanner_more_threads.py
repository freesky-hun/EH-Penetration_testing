import socket
import sys
import threading
import time

# Function for port scanning
def scan_port(ip, port):
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(1)
        result = sock.connect_ex((ip, port))
        if result == 0:
            print(f"Port {port} is open")
        sock.close()
    except KeyboardInterrupt:
        sys.exit()
    except:
        pass

# Main program
if __name__ == "__main__":
    if len(sys.argv) != 5:
        print("Usage: python port_scanner.py <target_IP> <start_port> <end_port> <num_threads>")
        sys.exit(1)

    target_ip = sys.argv[1]
    start_port = int(sys.argv[2])
    end_port = int(sys.argv[3])
    num_threads = int(sys.argv[4])

    print(f"Port scanning target: {target_ip}")
    print(f"Scanning ports {start_port} through {end_port} with {num_threads} threads...")

    start_time = time.time()

    for port in range(start_port, end_port + 1):
        while threading.active_count() > num_threads:
            pass
        thread = threading.Thread(target=scan_port, args=(target_ip, port))
        thread.start()

    for thread in threading.enumerate():
        if thread != threading.current_thread():
            thread.join()

    end_time = time.time()
    elapsed_time = end_time - start_time
    print(f"Scanning completed in {elapsed_time:.2f} seconds.")