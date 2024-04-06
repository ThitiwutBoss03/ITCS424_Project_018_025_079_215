import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/register.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dashboard.dart';

// Login Page
class LoginApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      home: LoginScreen(),
      theme: ThemeData(
        primaryColor: Color(0xFF27346A),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class Logger {
  static bool isDebugMode = false; // Toggle this based on your environment

  static void log(String message) {
    if (isDebugMode) {
      print(message);
    }
  }

  static void error(String message, [Object? error]) {
    print('ERROR: $message');
    if (error != null) {
      print('Error Details: $error');
    }
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      clientId:
          '33592492352-b7ovqd6q71r1amtn2r6gbv45v1stu6js.apps.googleusercontent.com');
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  // Declare password visibility state here
  bool _passwordVisible = false;

Future<void> _loginWithEmail() async {
    try {
      // Attempt to sign in with email and password
      final UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Check if the user is successfully signed in
      if (user.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashboardApp()));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              e.message ?? 'Invalid email or password. Please try again.')));
    }
  }

  Future<void> _loginWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashboardApp()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to sign in with Google. Please try again.')));
      Logger.error('Google Sign-In Error', e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          height: MediaQuery.of(context).size.height,
          color: Color(0xFF27346A), // This sets the background color
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 60.0),
              Image.asset('assets/Logo.png', height: 150),
              SizedBox(height: 48.0),
              _buildTextInputField(
                controller: _emailController,
                hintText: 'Email',
                icon: Icons.email,
              ),
              SizedBox(height: 16.0),
              _buildTextInputField(
                controller: _passwordController,
                hintText: 'Password',
                icon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  child: Text('Sign in', style: TextStyle(color: Colors.white)),
                  onPressed: _loginWithEmail,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    backgroundColor:
                        Color.fromARGB(255, 95, 156, 247),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(double.infinity, 56),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  'assets/Or_Underline.png',
                  fit: BoxFit.contain,
                  height: 35,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton.icon(
                  icon: Image.asset('assets/google_logo.svg', height: 20),
                  label: Text('Continue with Google'),
                  onPressed: _loginWithGoogle,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(double.infinity, 56),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              TextButton(
                child: Text('Register here',
                    style: TextStyle(color: Colors.white70)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterApp()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _buildTextInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !_passwordVisible,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: Color(0xFF6F6F6F)),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Color(0xFF6F6F6F),
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : null,
          border: InputBorder.none,
        ),
        keyboardType: isPassword ? TextInputType.text : TextInputType.emailAddress,
      ),
    );
  }
}