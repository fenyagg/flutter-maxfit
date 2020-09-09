import 'package:flutter/material.dart';
import 'package:flutter_app/domain/appUser.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthorizationPage extends StatefulWidget {
  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 20);
    var secondControlPoint =
        Offset(size.width - (size.width / 50), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email;
  String _password;
  bool showLogin = true;
  AuthService _authService = AuthService();

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.only(top: 100),
      child: Container(
        child: Align(
          child: Text('MAXFIT',
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ),
    );
  }

  Widget _input(
      {Icon icon,
      String hint,
      TextEditingController controller,
      bool obscure}) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(fontSize: 20, color: Colors.white),
        decoration: InputDecoration(
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white30),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white54, width: 1)),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: IconTheme(
                data: IconThemeData(color: Colors.white),
                child: icon,
              ),
            )),
      ),
    );
  }

  Widget _button({String label, void onClick()}) {
    return RaisedButton(
      // splashColor: Theme.of(context).primaryColor,
      // highlightColor: Theme.of(context).primaryColor,
      color: Colors.white,
      child: Text(
        label,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
            fontSize: 20),
      ),
      onPressed: onClick,
    );
  }

  Widget _form({String label, void onSubmit()}) {
    return Container(
        child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 20, top: 10),
          child: _input(
              controller: _emailController,
              hint: 'Email',
              icon: Icon(Icons.email),
              obscure: false),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: _input(
              controller: _passwordController,
              hint: 'Password',
              icon: Icon(Icons.lock),
              obscure: true),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: _button(label: label, onClick: onSubmit),
          ),
        )
      ],
    ));
  }

  Widget _bottomWave() {
    return Expanded(
      child: Align(
        child: ClipPath(
          child: Container(
            color: Colors.white,
            height: 300,
          ),
          clipper: BottomWaveClipper(),
        ),
        alignment: Alignment.bottomCenter,
      ),
    );
  }

  void _loginButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) return;

    AppUser user = await _authService.signInWithEmailAndPassword(
        _email.trim(), _password.trim());

    if (user == null) {
      Fluttertoast.showToast(
          msg: "Can't sign in, please check your email/password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  void _registerButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) return;

    AppUser user = await _authService.registerWithEmailAndPassword(
        _email.trim(), _password.trim());

    if (user == null) {
      Fluttertoast.showToast(
          msg: "Can't register you, please check your email/password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          _logo(),
          SizedBox(
            height: 20,
          ),
          (showLogin
              ? Column(
                  children: [
                    _form(label: 'LOGIN', onSubmit: _loginButtonAction),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        child: Text(
                          'Not registered yet ? Register!',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            showLogin = false;
                          });
                        },
                      ),
                    )
                  ],
                )
              : Column(
                  children: [
                    _form(label: 'Register', onSubmit: _registerButtonAction),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        child: Text(
                          'Already registered ? Login!',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        onTap: () {
                          setState(() {
                            showLogin = true;
                          });
                        },
                      ),
                    )
                  ],
                )),
          SizedBox(
            height: 50,
          ),
          _bottomWave(),
        ],
      ),
    );
  }
}
