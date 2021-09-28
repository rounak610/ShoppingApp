import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/pages/catalog_pg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}
final _formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {

  bool _passwordVisible=true;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [const Color(0xff9FA4C4), const Color(0xffB3CDD1)],
              )
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'Login',
                style: GoogleFonts.robotoMono(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                    child: Container(
                      width: 220,
                      height: 180,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/login.png')
                    )
                      )
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 8),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      autofocus: true,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2.0),),
                          prefixIcon: Icon(Icons.mail_rounded,
                            color: Colors.black,),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: 'Enter email-id',
                          hintStyle: TextStyle(color: Colors.black),
                          labelText: 'Email-Id',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value){
                        setState(() {
                          email=value;
                        });
                      },
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'Please enter your email-id';
                        }
                        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value))
                        {
                          return 'Please enter a valid email-id';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 8),
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      autofocus: true,
                      obscureText: _passwordVisible,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2.0),),
                          prefixIcon: Icon(Icons.lock_rounded,
                            color: Colors.black,),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: 'Enter password',
                          hintStyle: TextStyle(color: Colors.black),
                          labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      onChanged: (value){
                        setState(() {
                          password=value;
                        });
                      },
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'Please enter the password';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,20,0,0),
                    child: ElevatedButton(onPressed: () {
                      if(_formKey.currentState!.validate())
                        {
                          _signin(email, password);
                        }
                    },
                      child: Text(
                        'Login',
                        style: GoogleFonts.robotoMono(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 15,
                            color: Colors.white
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states)
                          {
                            if (states.contains(MaterialState.pressed))
                              return Colors.deepOrange;
                            return Colors.black;
                          }
                          ),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )
                          )
                    ),
                  ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _signin(String _email, String _password) async {
    try
    {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CatalogPage()));
    }
    on FirebaseAuthException catch (error)
    {
      Fluttertoast.showToast(msg: 'Wrong credentials!!\n   Please try again',gravity: ToastGravity.TOP);
    }
  }
}

