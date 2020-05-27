import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import 'test.dart';

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
        title: Center(child: Text('nutrifrnd')),
        backgroundColor: Colors.tealAccent[700],
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
            backgroundColor: Colors.white30,
            backgroundImage: AssetImage('images/edited.png'),
            radius: 65.0,
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome to",
                style: TextStyle(
                  fontFamily: 'Philosopher',
                  fontSize: 22.0,
                ),
              ),
              Text(
                " nutrifrnd",
                style: TextStyle(
                  fontFamily: 'Philosopher',
                  color: Colors.teal[600],
                  fontSize: 22.0,
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
                  leading: Icon(
                    FontAwesomeIcons.google,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Sign-In with Google',
                      style: TextStyle(
                        fontSize: 18.0,
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
          color: Colors.grey[900],
          child: Column(
            children: <Widget>[
              ListTile(
                leading: GoogleUserCircleAvatar(
                  identity: _currentUser,
                ),
                title: Text(
                  'Hello, ',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  _currentUser.displayName ?? '',
                  style: TextStyle(
                      fontFamily: 'OleoScript',
                      fontSize: 17.0,
                      color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.teal[400],
                      onPressed: _handleSignOut,
                      child: Text('SIGN OUT'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ), //SignOut Button
        SizedBox(height: 80.0),
        Container(
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestPage()),
              );
            },
            child: Card(
              margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              color: Colors.pink[600],
              child: ListTile(
                title: Center(
                  child: Text(
                    'Take a Test',
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
