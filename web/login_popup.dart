//TODO: copyright
import 'dart:html';

class LoginPopup {
  String username;
  String password;
  DialogElement popup;
  InputElement user;
  InputElement pword;
  SpanElement message;
  SpanElement errmsg;
  bool loggedIn = false;


  LoginPopup() {
    popup = document.querySelector('#login-popup');
    user = document.querySelector('#user');
    pword = document.querySelector('#pword');
    message = document.querySelector('#message');
    errmsg = document.querySelector('#error');
    if (!loggedIn) popup.showModal();

  }

  void onSubmit() {
    username = user.text;
    password = pword.text;
    print('User: $username, Pword: $password');
    message.text = 'Username: $username, Password: $password';
    if ((user != "jim") || (password != "foo"))
      errmsg.text = "Error: invalid username or password";
    loggedIn = true;
  }
}

void main() {
  new LoginPopup();
}
