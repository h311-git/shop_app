import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import '../providers/auth.dart';
import '../pages/products_page.dart';

class Login extends StatefulWidget {
  const Login({
    Key key,
    @required this.deviceSize,
  }) : super(key: key);

  final double deviceSize;
  @override
  _LoginState createState() => _LoginState();
}

enum Method {
  Login,
  Singnup,
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();
  final _passController = TextEditingController();
  bool _isloading = false;
  Map<String, String> _userCred = {
    'email': '',
    'password': '',
  };
  Method _loginMehtod = Method.Login;
  void _triggerMethod() {
    setState(() {
      _loginMehtod =
          _loginMehtod == Method.Login ? Method.Singnup : Method.Login;
    });
  }

  Future<void> _saveForm() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
    } else {
      return;
    }
    setState(() {
      _isloading = true;
    });
    if (_loginMehtod == Method.Singnup) {
      await Provider.of<Auth>(context, listen: false).signUp(
        _userCred['email'],
        _userCred['password'],
      );
    } else {
      await Provider.of<Auth>(context, listen: false).login(
        _userCred['email'],
        _userCred['password'],
      );
    }
    setState(() {
      _isloading = false;
    });
  }

  @override
  void dispose() {
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300,
          height: _loginMehtod == Method.Singnup
              ? widget.deviceSize * 0.62
              : widget.deviceSize * 0.48,
          margin: EdgeInsets.only(
            top: 60,
            right: 30,
            left: 30,
          ),
          child: Card(
            shadowColor: Colors.pink,
            color: Colors.white,
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(children: [
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: "email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onSaved: (email) {
                        _userCred['email'] = email;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (password) {
                        _userCred['password'] = password;
                      },
                      controller: _passController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      textInputAction: _loginMehtod == Method.Singnup
                          ? TextInputAction.next
                          : TextInputAction.done,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "Password",
                      ),
                    ),
                    if (_loginMehtod == Method.Singnup)
                      SizedBox(
                        height: 20,
                      ),
                    if (_loginMehtod == Method.Singnup)
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText: "Confirm Password",
                        ),
                        validator: (value) {
                          if (value != _passController.text) {
                            return "passwords do not match!";
                          }
                          return null;
                        },
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    _isloading
                        ? CircularProgressIndicator()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: double.infinity,
                              height: 55,
                              color: Theme.of(context).primaryColor,
                              child: ElevatedButton(
                                onPressed: _saveForm,
                                child: Text(
                                  _loginMehtod == Method.Login
                                      ? "Login"
                                      : "SignUp",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          )
                  ]),
                ),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: _triggerMethod,
          child: Text(
            _loginMehtod == Method.Login
                ? "Dont have any account yet?Sign Up"
                : "Login instead",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
