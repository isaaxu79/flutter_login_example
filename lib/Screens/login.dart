import 'package:flutter/material.dart';
import 'package:login_app/Screens/home.dart';
import 'package:login_app/services/rest_api.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _email = TextEditingController();
  final _password = TextEditingController();
  bool  visible = false;

  Widget _button_facebook_login(){
    return Container(
      height: 40.0,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 1.0
          ),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: ImageIcon(AssetImage('assets/facebook.png')),
            ),
            SizedBox(width: 10.0,),
            Center(
              child: Text('Log in with facebook',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat'
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _button_login(){
    return Container(
      height: 40.0,
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        shadowColor: Colors.greenAccent,
        color: Colors.green,
        elevation: 7.0,
        child: GestureDetector(
          onTap: () => _log_in(),
          child: Center(
            child: Text('Login',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat'
              ),
            )
          ),
        ),
      ),
    );
  }

  Widget _recorvery_password(){
    return Container(
      alignment: Alignment(1.0, 1.0),
      padding: EdgeInsets.only(top: 15.0, left: 20.0),
      child: InkWell(
        child: Text('Forgot Password',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            decoration: TextDecoration.underline
          ),
        ),
      ),
    );
  }

  Widget _input_email_form(title){
    return TextField(
      controller: _email,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          color: Colors.grey
        ),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green))
      ),
    );
  }

  Widget _input_password_form(title){
    return TextField(
      controller: _password,
      obscureText: visible,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          color: Colors.grey
        ),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.green)),
        suffixIcon: IconButton(
          icon: Icon(
            visible ? Icons.visibility : Icons.visibility_off,
            color:  Theme.of(context).primaryColorDark,
          ),
          onPressed: (){
            setState(() {
              visible = !visible;
            });
          },
        )
      ),
    );
  }

  Widget _register(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('New to Spotify ?', 
          style: TextStyle(
            fontFamily: 'Montserrat'
          ),
        ),
        SizedBox(width: 5.0,),
        InkWell(
          onTap: (){
            //Navigator.of(context).pushNamed('/signup');
          },
          child: Text('Register',
            style: TextStyle(
              color: Colors.green,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline
            ),
          ),
        )
      ],
    );
  }
  
  Widget _form_log(){
    return Container(
      padding: EdgeInsets.only(top: 35.0, left: 25.0, right:25.0, bottom: 30.0),
      child: Column(
        children: <Widget>[
          _input_email_form('Email'),
          SizedBox(height: 20.0,),
          _input_password_form('Password'),
          SizedBox(height: 15.0),
          _recorvery_password(),
          SizedBox(height: 20.0),
          _button_login(),
          SizedBox(height: 20.0),
          _button_facebook_login(),

        ],
      )
    );
  }

  Widget _main_title(){
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(25.0, 120.0, 0.0, 0.0),
            child: Text('Hello', 
              style: TextStyle(
                fontSize: 80.0, fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(28.0, 185.0, 0.0, 0.0),
            child: Text('There', 
            style: TextStyle(
              fontSize: 80.0, 
              fontWeight: FontWeight.bold)),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(235.0, 185.0, 0.0, 0.0),
            child: Text('.',
              style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold, color: Colors.green),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _main_title(),
          _form_log(),
          _register() 
        ],
      )
    );
  }  

  void _log_in(){
    final body={
      "username" : _email.text,
      "password" : _password.text
    };
    ApiService.login(body).then((sucess){
      if (sucess){
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => HomeScreen())
        );
      }else{
        showDialog(
          builder: (context) => AlertDialog(
            title: Text('No se pudo iniciar sesion, verifica tus datos'),
            actions: <Widget>[
              FlatButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Ok'),) 
            ],
          ),
          context: context
        );
        return;
      }
    });
  }
}