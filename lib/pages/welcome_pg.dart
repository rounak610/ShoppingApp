import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/pages/login_pg.dart';
import 'package:shopping_app/pages/signup_pg.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [const Color(0xff79F1A4), const Color(0XFF0E5CAD)],
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
           // backgroundColor: Colors.grey[800],
            title: Text(
              'Shopping App',
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/welcome.png')
                      )
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(100,70,0,0),
                      child: ElevatedButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                      },
                        child: Text(
                          'Login',
                          style: GoogleFonts.robotoMono(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
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
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40,69,0,0),
                      child: ElevatedButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                      },
                        child: Text(
                          'Register',
                          style: GoogleFonts.robotoMono(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
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
                          )
                        ),
                      ),
                  ],
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
