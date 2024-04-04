import 'package:flutter/material.dart';
import 'package:flutter_application_1/dashboard.dart'; // Assuming this is the dashboard/home page
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/login.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class RegisterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Screen',
      home: RegistrationScreen(),
      theme: ThemeData(
        primaryColor: Color(0xFF27346A),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _passwordVisible = false;

  void _registerWithEmail() async {
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        final UserCredential user =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        if (user.user != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginApp()));
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message ?? 'Registration failed')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Passwords do not match")));
    }
  }

  // Future<void> _registerWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser != null) {
  //       final GoogleSignInAuthentication googleAuth =
  //           await googleUser.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken,
  //         idToken: googleAuth.idToken,
  //       );
  //       final UserCredential userCredential =
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //       if (userCredential.user != null) {
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => DashboardApp()));
  //       }
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Google sign-in failed')));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          height: MediaQuery.of(context).size.height,
          color: Color(0xFF27346A),
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
              SizedBox(height: 16.0),
              _buildTextInputField(
                controller: _confirmPasswordController,
                hintText: 'Confirm Password',
                icon: Icons.lock_outline,
                isPassword: true,
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  child: Text('Sign up', style: TextStyle(color: Colors.white)),
                  onPressed: _registerWithEmail,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    backgroundColor: Color.fromARGB(255, 95, 156, 247),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(double.infinity, 56),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset('assets/Or_Underline.png', height: 35),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 8.0),
              //   child: ElevatedButton.icon(
              //     icon: Image.asset('assets/google_logo.svg', height: 20),
              //     label: Text('Continue with Google'),
              //     onPressed: _registerWithGoogle,
              //     style: ElevatedButton.styleFrom(
              //       padding: EdgeInsets.symmetric(vertical: 6.0),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //       minimumSize: Size(double.infinity, 56),
              //     ),
              //   ),
              // ),
              SizedBox(height: 16.0),
              TextButton(
                child: Text('Already have an account? Sign in',
                    style: TextStyle(color: Colors.white70)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginApp()));
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
        keyboardType:
            isPassword ? TextInputType.text : TextInputType.emailAddress,
      ),
    );
  }
}
