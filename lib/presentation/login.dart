import 'package:flutter/material.dart';
import 'package:project/presentation/Home.dart';
import 'package:project/presentation/User/registerUser.dart';
import 'package:project/presentation/organizer/HomeOrga.dart';
import 'package:project/presentation/organizer/registerOrga.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPageUser extends StatefulWidget {
  final bool isOrganizer;

  const LoginPageUser({Key? key, required this.isOrganizer}) : super(key: key);

  @override
  State<LoginPageUser> createState() => _LoginPageUserState();
}

class _LoginPageUserState extends State<LoginPageUser> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 @override
  void initState() {
    super.initState();
    // Initialize controllers here
    _emailController.text = '';
    _passwordController.text = '';
  }
  Future<void> signInWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful")),
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => widget.isOrganizer ? HomeOrganizer() : Home(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No user found")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Wrong password or email")),
        );
      }
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String loginType = widget.isOrganizer ? 'organizer' : 'user';
    String title = 'You are login in as $loginType';

    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    signInWithEmailAndPassword();
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 16.0),
              widget.isOrganizer
                  ? TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterOrgPage(),
                          ),
                        );
                      },
                      child: Text(
                          'Don\'t have an account? Register now for organizer'),
                    )
                  : TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                      child: Text('Don\'t have an account? Register now for user'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
