import requests


def print_hi(name):
    print(f"Hi, {name}")


def make_request(url):
    r = requests.get(url)
    return r.status_code


if __name__ == "__main__":
    print_hi("PyCharm")
    status = make_request("https://httpbin.org/get")
    print(status)
