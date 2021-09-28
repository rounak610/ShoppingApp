import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/pages/login_pg.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

final _formKey = GlobalKey<FormState>();

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  final _firestore = FirebaseFirestore.instance;
  late String email;
  late String password;
  bool _passwordVisible=true;
  bool _passwordVisible2=true;

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
                colors: [const Color(0xffFFE985), const Color(0xff58CFFB)],
              )
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'Sign Up',
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
                                  image: AssetImage('assets/images/signup.png')
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
                            color: Colors.black,
                          ),
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
                      controller: _password,
                      obscureText: _passwordVisible,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2.0),),
                          prefixIcon: Icon(Icons.lock_rounded,
                          color: Colors.black,
                          ),
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
                          hintText: 'Enter password (min lenght:6)',
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
                            return 'Please enter a password';
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
                      controller: _confirmpassword,
                      obscureText: _passwordVisible2,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2.0),),
                          prefixIcon: Icon(Icons.lock_rounded,
                          color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible2 = !_passwordVisible2;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: 'Re-enter password',
                        hintStyle: TextStyle(color: Colors.black),
                          labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'Please re-enter the password';
                        }
                        if(_password.text != _confirmpassword.text)
                          {
                            return 'Password do not match!!';
                          }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,20,0,0),
                    child: ElevatedButton(onPressed: () async {
                      if(_formKey.currentState!.validate())
                      {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing data')),
                        );
                      }
                      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((signedInUser){
                        _firestore.collection('users').add({'email':email, 'pass':password}).then((value){
                          if(signedInUser != null)
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                          }
                        })
                            .catchError((e){
                          print(e);
                        });
                      });
                    },
                      child: Text(
                        'Register',
                        style: GoogleFonts.robotoMono(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
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
}
