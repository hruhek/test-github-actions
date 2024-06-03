from sample.main import make_request, print_hi


def test_main(capsys):
    print_hi("Hrvoje")
    assert capsys.readouterr().out == "Hi, Hrvoje\n"


def test_make_request(requests_mock):
    requests_mock.get("http://test.com", text="data")
    assert 200 == make_request("http://test.com")
