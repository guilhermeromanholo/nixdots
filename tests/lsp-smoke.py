"""Check that each configured server can complete a real LSP handshake."""

import json
import os
import selectors
import subprocess
import sys
import time


def send(process, message):
    payload = json.dumps(message).encode()
    process.stdin.write(f"Content-Length: {len(payload)}\r\n\r\n".encode() + payload)
    process.stdin.flush()


def initialize(command):
    with subprocess.Popen(command, stdin=subprocess.PIPE, stdout=subprocess.PIPE) as process:
        send(process, {
            "jsonrpc": "2.0", "id": 1, "method": "initialize",
            "params": {"processId": os.getpid(), "rootUri": None, "capabilities": {}},
        })
        deadline = time.monotonic() + 30
        pending = b""
        selector = selectors.DefaultSelector()
        selector.register(process.stdout, selectors.EVENT_READ)
        try:
            while time.monotonic() < deadline:
                if not selector.select(timeout=1):
                    continue
                chunk = os.read(process.stdout.fileno(), 65536)
                if not chunk:
                    raise RuntimeError(f"{command}: exited before initialize response")
                pending += chunk
                while b"\r\n\r\n" in pending:
                    headers, body = pending.split(b"\r\n\r\n", 1)
                    length = next(int(line.split(b":", 1)[1]) for line in headers.split(b"\r\n") if line.lower().startswith(b"content-length:"))
                    if len(body) < length:
                        break
                    response = json.loads(body[:length])
                    pending = body[length:]
                    if response.get("id") == 1 and "method" not in response:
                        assert "capabilities" in response.get("result", {}), response
                        print(f"LSP initialize OK: {command}")
                        return
            raise TimeoutError(f"{command}: initialize timed out")
        finally:
            selector.close()
            process.terminate()
            try:
                process.wait(timeout=5)
            except subprocess.TimeoutExpired:
                process.kill()


if __name__ == "__main__":
    initialize(sys.argv[1:])
