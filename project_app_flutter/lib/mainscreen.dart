import 'package:flutter/material.dart';
import 'home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: Center(child: Text('Nutrifrnd')),
        backgroundColor: Colors.deepPurple[700],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Card(
                  color: Colors.green[400],
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ), //Log In
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                'OR',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ), //Or
            Container(
              child: FlatButton(
                onPressed: () {},
                child: Card(
                  color: Colors.red,
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      child: Icon(
                        FontAwesomeIcons.google,
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: Text(
                        'Sign-In with Google',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'SourceSansPro',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
