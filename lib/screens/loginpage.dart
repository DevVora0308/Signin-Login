import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String registeredUserName;
  final String registeredPassword;
  LoginPage({
    @required this.registeredUserName,
    @required this.registeredPassword,
  });
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _validate = false;
  String logInUserName, _logInPassword;
  bool _passwordVisible = false;
  bool _loggedIn = false;
  // RegistrationPage rp = new RegistrationPage();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.amber,
        appBar: AppBar(
          title: Text('LOGIN'),
          backgroundColor: Colors.red,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(15.0),
              child: Form(
                key: _key,
                autovalidate: _validate,
                child: formUI(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'User Name',
              prefixIcon: Icon(Icons.person),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange),
              ),
              border: OutlineInputBorder(),
            ),
            validator: validateUserName,
            keyboardType: TextInputType.text,
            onSaved: (String value) {
              setState(() {
                logInUserName = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange),
              ),
              border: OutlineInputBorder(),
            ),
            obscureText: !_passwordVisible,
            keyboardType: TextInputType.text,
            validator: validatePassword,
            onSaved: (String value) {
              setState(() {
                _logInPassword = value;
              });
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
          child: MaterialButton(
            onPressed: () {
              _sendToServer();
            },
            child: Text(
              "Log In",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }

  void showMessageSnackBar(String message) {
    final snackBar = new SnackBar(
      content: new Text("$message"),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  String validateUserName(String value){
    String pattern = r'(^[a-zA-Z]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "User-Name cannot be Empty";
    }else if (value.length < 3) {
      return "Insufficient User-Name length";
    } else if (!regExp.hasMatch(value)) {
      return "User-Name must have Alphabetic characters";
    }
    return null;
  }

  String validatePassword(String value){
    Pattern pattern =
        r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return "Invalid Passsword";
    } else
      return null;
  }

  String validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Mobile No. cannot be Empty";
    } else if (value.length != 10) {
      return "Must have 10 digits";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile Number must only have digits";
    }
    return null;
  }

  void checkDetails(){
    if(logInUserName==widget.registeredUserName && _logInPassword==widget.registeredPassword){
      setState(() {
        _loggedIn = true;
        showAlertDialog(_loggedIn);
      });
    }
    else{
      setState(() {
        _loggedIn = false;
        showAlertDialog(_loggedIn);
      });
    }
  }

  void showAlertDialog(bool status){
    if(status){
      _showAlertDialog("You are Logged In successfully !!");
    }
    else{
      _showAlertDialog("Invalid Credentials !!");
    }
  }

  _sendToServer() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      checkDetails();
    } else {
      setState(() {
        showMessageSnackBar("Please fill the valid Details!!");
        _loggedIn = false;
        _validate = true;
      });
    }
  }

  void _showAlertDialog(String message) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("STATUS"),
      content: Text("$message"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
