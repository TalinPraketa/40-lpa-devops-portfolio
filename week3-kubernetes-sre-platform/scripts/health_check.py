import requests
import sys

URL = sys.argv[1] if len(sys.argv) > 1 else "http://localhost/healthz"

try:
    response = requests.get(URL, timeout=5)
    if response.status_code == 200:
        print("Application is healthy")
        sys.exit(0)
    print(f"Health check failed with status code {response.status_code}")
    sys.exit(1)
except Exception as exc:
    print(f"Health check failed: {exc}")
    sys.exit(1)
