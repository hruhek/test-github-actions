from main import print_hi


def test_main(capsys):
    print_hi("Hrvoje")
    assert capsys.readouterr().out == "Hi, Hrvoje\n"
