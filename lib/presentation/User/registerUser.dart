import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/presentation/login.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();

  Future<void> _createUserWithEmailAndPasswordAndRole(
      String fullname, String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentReference userDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid);

      await userDocRef.set({
        'fullname': fullname,
        'email': email,
        'role': 'user',
        'followedE': [],
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign up successful!'),
          duration: Duration(seconds: 3),
        ),
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPageUser(isOrganizer: false),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The password provided is too weak'),
            duration: Duration(seconds: 3),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The account already exists for that email'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('Unexpected error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: Color(0xFF090580)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: Stack(
                children: [
                  Positioned(
                    left: 207,
                    top: 105,
                    child: SizedBox(
                      width: 158,
                      child: Text(
                        'AZA ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1982C4),
                          fontSize: 60,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 19,
                    top: 60,
                    child: Container(
                      width: 176,
                      height: 139,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://s3-alpha-sig.figma.com/img/0155/7b11/fc9dd2b402d3a90b43bafba48fced020?Expires=1705276800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=lq5SAac0XtuS9b61wGXo6M3iu7xb7SZge-i-3a7PqxM70l5-~lolwwbSF-xJjD~Q2xgJW~z3BrAT46rv4lAA6AanBMgKnMj~9PLlv5URSjrBwLN6b~EHaBJgPpVS0BxmvssrfKCJdKYlSLjp0NX~MDQ41VJgdK4~M54Rn40L9-vD5AvzWkkVIpVhDs-k9W4ka9hy0hga4n1Y8h1sGP9V6d15DIITJz5OkkJSPnsMT-SEaPsnpvamcPVDxjSxFF54W5~Y-7APL5VsH0gu~EE-o97k3IcYYMchg49n1F4M3TIvy2VjlqvcIlPAmcObSKDOFCJ6tcpB-Xfsg5K3loBq4Q__"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 195,
                    top: 60,
                    child: Text(
                      'Welcome to',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
              Container(
              width: double.infinity,
              height: 554,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
              ),
              child: Stack(
                children: [
                   Positioned(
                    left: 72,
                    top: 350,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate back to the login page
                        Navigator.pop(context);
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: 'Log in',
                              style: TextStyle(
                                color: Color(0xFF090580),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 50,
                    child: Container(
                      width: 350,
                      padding: const EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Full Name
                          TextField(
                            controller: fullnameController,
                            decoration: InputDecoration(
                              hintText: "Full Name",
                              fillColor: Colors.grey[200],
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 15),

                          // Email
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              fillColor: Colors.grey[200],
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 15),

                          // Password
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Password",
                              fillColor: Colors.grey[200],
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 15),

                          // Confirm Password
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              fillColor: Colors.grey[200],
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 417,
                    child: GestureDetector(
                      onTap: () {
                        _createUserWithEmailAndPasswordAndRole(
                          fullnameController.text,
                          emailController.text,
                          passwordController.text,
                        );
                      },
                      child: Container(
                        width: 350,
                        padding: const EdgeInsets.only(top: 6, bottom: 7),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Color(0xFF090580),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 5),
                            Text(
                              'Sign up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Text(
                    'Copyright © 2023 AZA',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
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