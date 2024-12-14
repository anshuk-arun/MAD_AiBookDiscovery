import 'package:bookdisc_app/HomeScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _userCtrl;
  late TextEditingController _passCtrl;
  String usernameHC = "personA";
  String passwordHC = "pass1234";

  @override
  void initState(){
    super.initState();
    _userCtrl = TextEditingController();
    _passCtrl = TextEditingController();
    
  }

  @override
  void dispose(){
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  bool _validateLogin(String usrn, String pswd){
    if ((usrn == usernameHC) && (pswd == passwordHC)){
      return true;
    }
    return false;
  }

  void _openHomeScreen(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ai Book Discovery - Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextField(
              controller: _userCtrl,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
              onSubmitted: (String value) async {
                //usernameHC = value;
              },
            ),
            TextField(
              controller: _passCtrl,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              onSubmitted: (String value) async {
                //passwordHC = value;
              },
            ),
            
            ElevatedButton(
              child: Text('DEBUG: Check login details'),
              onPressed: () async{
                await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Thanks!'),
                      content: Text(
                          '''
                          Input Login ${_userCtrl.text}
                          Input Pass ${_passCtrl.text}
                          HC Username ${usernameHC}
                          HC Password ${passwordHC}
                          '''),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),

            ElevatedButton(
              child: Text('Login'),
              onPressed: (){
                if (_validateLogin(_userCtrl.text, _passCtrl.text)){
                  _openHomeScreen(context);
                }
                else{
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('ERROR: Incorrect Login Details!!'),
                        content: Text(
                            '''
                            Input Login ${_userCtrl.text}
                            Input Pass ${_passCtrl.text}
                            HC Username ${usernameHC}
                            HC Password ${passwordHC}
                            '''),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),

          ],
        )
        
      ),
    );
  }
}