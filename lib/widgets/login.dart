import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import '../providers/auth.dart';

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

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final _key = GlobalKey<FormState>();
  final _passController = TextEditingController();
  bool _isloading = false;
  Map<String, String> _userCred = {
    'email': '',
    'password': '',
  };
  Method _loginMethod = Method.Login;

  void _triggerMethod() {
    if (_loginMethod == Method.Login) {
      setState(() {
        _loginMethod = Method.Singnup;
      });
      _animationController.forward();
    } else {
      setState(() {
        _loginMethod = Method.Login;
      });
      _animationController.reverse();
    }
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

    if (_loginMethod == Method.Singnup) {
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

  AnimationController _animationController;
  Animation<double> _opacityAnimation;
  Animation<Offset> _slideAnimation;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, -0.5),
      end: Offset(0.0, 0.0),
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    super.initState();
  }

  @override
  void dispose() {
    _passController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
          width: 300,
          height: _loginMethod == Method.Singnup
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
                        labelText: "Email",
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
                      textInputAction: _loginMethod == Method.Singnup
                          ? TextInputAction.next
                          : TextInputAction.done,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelText: "Password",
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      constraints: BoxConstraints(
                        minHeight: _loginMethod == Method.Login ? 0 : 80,
                        maxHeight: _loginMethod == Method.Login ? 0 : 120,
                      ),
                      curve: Curves.easeIn,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: TextFormField(
                            enabled: _loginMethod == Method.Singnup,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              labelText: "Confirm Password",
                            ),
                            validator: _loginMethod == Method.Singnup
                                ? (value) {
                                    if (value != _passController.text) {
                                      return "passwords do not match!";
                                    }
                                    return null;
                                  }
                                : null,
                          ),
                        ),
                      ),
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
                                  _loginMethod == Method.Login
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
            _loginMethod == Method.Login
                ? "Dont have any account yet?Sign Up"
                : "Login instead",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
