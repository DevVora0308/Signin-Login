import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:signin_form/screens//loginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool enabled = false;
  bool checked = false;
  bool _validate = false;
  String fullName, userName, emailId, mobileNo, _password;
  bool _passwordVisible = false;
  bool _registerd = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.amber,
        appBar: AppBar(
          title: Text('REGISTRATION'),
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
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange),
              ),
              border: OutlineInputBorder(),
            ),
            validator: validateName,
            onSaved: (String value) {
              fullName = value;
            },
          ),
        ),
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
              userName = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Email Id.:',
              hintText: "e.g abc@gmail.com",
              prefixIcon: Icon(Icons.email),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange),
              ),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
            EmailValidator.validate(value) ? null : "Invalid Email Address",
            onSaved: (String value) {
              emailId = value;
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
              _password = value;
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Mobile Number',
              prefixIcon: Icon(Icons.phone),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepOrange),
              ),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: validateMobile,
            onSaved: (String value) {
              mobileNo = value;
            },
            // onChanged: (value){
            //   setState(() {
            //     name=value;
            //   });
            // },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Text(
                "Send Notification",
                style: TextStyle(fontSize: 18),
              ),
              Switch(
                onChanged: (bool val) {
                  setState(() {
                    enabled = val;
                  });
                },
                activeColor: Colors.red,
                activeTrackColor: Colors.redAccent[400],
                value: enabled,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              CheckboxListTileFormField(
                title: Text(
                  "I agree",
                  style: TextStyle(fontSize: 18),
                ),
                onSaved: (bool value) {
                  checked = value;
                },
                validator: (bool value) {
                  if (value == true) {
                    return null;
                  } else {
                    return 'Accept terms to proceed';
                  }
                },
                activeColor: Colors.redAccent,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
          child: Row(
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  _sendToServer();
                },
                child: Text(
                  "Register",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                color: Colors.redAccent,
              ),
              SizedBox(
                width: 16,
              ),
              MaterialButton(
                onPressed: getLoginPage,
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                color: Colors.redAccent,
              ),
            ],
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

  String validateName(String value) {
    String pattern = r'(^[a-z A-Z,.\-]+$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Name cannot be Empty";
    } else if (!regExp.hasMatch(value)) {
      return "Name must have Alphabetic characters";
    }
    return null;
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

  String validatePassword(String value) {
    Pattern pattern = r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
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

  _sendToServer() {
    if (_key.currentState.validate()) {
      showMessageSnackBar("Registration Successfull!!");
      _registerd = true;
      _key.currentState.save();
    } else {
      setState(() {
        showMessageSnackBar("Please fill the valid Details!!");
        _registerd = false;
        _validate = true;
      });
    }
  }

  void getLoginPage() {
    if (_registerd) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginPage(
                    // registrationObject: this,
                    registeredUserName: userName,
                    registeredPassword: _password,
                  )));
    }
    else{
      showMessageSnackBar("Please Register First!!");
    }
  }
}
