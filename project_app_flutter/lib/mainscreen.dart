import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import 'secondary_mainscreen.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['profile', 'email']);

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GoogleSignInAccount _currentUser;
  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Nutrifrnd')),
        backgroundColor: Colors.green[400],
      ),
      body: SafeArea(child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_currentUser != null) {
      return _signin();
    } //Secondary Main Page
    else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50.0),
          CircleAvatar(
            backgroundImage: AssetImage('images/icon.jpg'),
            radius: 60.0,
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome to",
                style: TextStyle(
                  fontFamily: 'Rubik',
                  fontSize: 20.0,
                ),
              ),
              Text(
                " Nutrifrnd",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 150.0,
          ),
          Container(
            child: FlatButton(
              onPressed: _handleSignIn,
              child: Card(
                color: Colors.red[600],
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
      );
    } //SignIn Page
  }

  Widget _signin() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          color: Colors.black38,
          margin: EdgeInsets.only(top: 0.0),
          child: ListTile(
            leading: GoogleUserCircleAvatar(
              identity: _currentUser,
            ),
            title: Text(
              'Hello, ',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _currentUser.displayName ?? '',
              style: TextStyle(
                fontSize: 17.0,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          child: RaisedButton(
            color: Colors.green[500],
            onPressed: _handleSignOut,
            child: Text('SIGN OUT'),
          ),
        ), //SignOut Button
        SizedBox(height: 80.0),
        Container(
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondaryScreen()),
              );
            },
            child: Card(
              margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              color: Colors.pink[600],
              child: ListTile(
                title: Center(
                  child: Text(
                    'Explore the App',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Basic',
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ), //Explore Button
        Container(
          child: FlatButton(
            onPressed: _launchURL,
            child: Card(
              margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              color: Colors.pink[600],
              child: ListTile(
                title: Center(
                  child: Text(
                    'Get Your Diet Plan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: 'Basic',
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() async {
    _googleSignIn.disconnect();
  }

  _launchURL() async {
    const url = 'https://bit.ly/nutrifrnds';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
