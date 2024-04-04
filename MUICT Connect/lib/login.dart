import 'package:flutter/material.dart';
import 'package:flutter_application_1/register.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Declare password visibility state here
  bool _passwordVisible = false;

  void _loginWithEmail() {
    // Insert registration logic
  }

  Future<void> _loginWithGoogle() async {
    // Insert Google sign-in logic
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
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 60.0),
              Image.asset('assets/Logo.png', height: 150),
              SizedBox(height: 48.0),
              // Email input
              // Email input
              _buildTextInputField(
                controller: _emailController,
                hintText: 'Email',
                icon: Icons.email,
              ),
              SizedBox(height: 16.0),
              // Password input
              _buildTextInputField(
                controller: _passwordController,
                hintText: 'Password',
                icon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 20.0),
              // Sign Up Button
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 8.0), // Match the padding of the text fields
                child: ElevatedButton(
                  child: Text('Sign in', style: TextStyle(color: Colors.white)),
                  onPressed: _loginWithEmail,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    backgroundColor:
                        Color.fromARGB(255, 95, 156, 247), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Match the border radius of the text fields
                    ),
                    minimumSize: Size(double.infinity,
                        56), // Button minimum size, matches the height of text fields
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(
                  'assets/Or_Underline.png',
                  fit: BoxFit.contain,
                  height: 35, // Adjust the height of the logo as needed
                ),
              ),
              // Google Sign In Button
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 8.0), // Match the padding of the text fields
                child: ElevatedButton.icon(
                  icon: Image.asset('assets/google_logo.svg', height: 20),
                  label: Text('Continue with Google'),
                  onPressed: _loginWithGoogle,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(double.infinity,
                        56), // Button minimum size, matches the height of text fields
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
    // State for password visibility
    bool _passwordVisible = false;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword &&
            !_passwordVisible, // Toggles based on the isPassword and _passwordVisible state
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon, color: Color(0xFF6F6F6F)),
          // Add the suffix icon if this is a password field
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Color(0xFF6F6F6F),
                  ),
                  onPressed: () {
                    // Update the state upon pressing the icon
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                )
              : null, // No icon if not a password
          border: InputBorder.none,
        ),
        keyboardType:
            isPassword ? TextInputType.text : TextInputType.emailAddress,
      ),
    );
  }
}