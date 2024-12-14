import 'package:bookdisc_app/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
    Firebase.initializeApp();
    _userCtrl = TextEditingController();
    _passCtrl = TextEditingController();
  }

  @override
  void dispose(){
    _userCtrl.dispose();
    _passCtrl.dispose();
    FirebaseAuth.instance.signOut();
    super.dispose();
  }

  bool _validateLogin(String usrn, String pswd){

    bool validLogin = true;
    FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
        if (user == null) {
          print('User is currently signed out');
        } else {
          validLogin = true;
          print('User is signed in');
          print(user.uid);

        }
      });
    
    // Return Validation by FirebaseAuth
    print(validLogin);
    return validLogin;

    /*  Validation with HardCoded Values
    if ((usrn == usernameHC) && (pswd == passwordHC)){
      return true;
    }
    return false;
    */
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
              onPressed: () async{
                try {
                  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _userCtrl.text,
                    password: _passCtrl.text
                  );
                  
                  // Login Valid, open into App
                  print('DEBUG: open homscreen from valid login');
                  _openHomeScreen(context);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found'){
                    print('No user found for that email');
                  } else if (e.code == 'wrong-password'){
                    print('Wrong password provided for that user');
                  }
                } catch (e) {
                  print(e);
                }
                
                // FirebaseAuth User is Signed in, enter the app
                if (FirebaseAuth.instance.currentUser != null){
                  _openHomeScreen(context);
                }

                // FirebaseAuth Sign in Valid, Logs In, -> then open App
                /*
                if (_validateLogin(_userCtrl.text, _passCtrl.text)){
                  print('DEBUG: Opening App through _validateLogin and _openHomeScreen');
                  _openHomeScreen(context);
                }
                */
              }

                /*
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
              */
            ),

            ElevatedButton(
              child: Text('Register'),
              onPressed: () async{
                try{
                  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _userCtrl.text,
                    password: _passCtrl.text
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak password'){
                    print('The password provided is too weak');
                  } else if (e.code == 'email-already-in-use'){
                    print('The account already exists for that email');
                  }
                } catch (e){
                  print(e);
                }
              }
            ),

            ElevatedButton(
              child: Text('Sign Out'),
              onPressed: () async{
                try{
                  await FirebaseAuth.instance.signOut();
                } catch (e) {
                  print(e);
                }
              }
            ),

          ],
        )
        
      ),
    );
  }
}