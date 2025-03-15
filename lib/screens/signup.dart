import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'signin.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  Future<void> signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // ✅ Store user data in Firestore with XP, Level, and EcoPoints
      await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "xp": 0, // ✅ New users start with 0 XP
        "level": 1, // ✅ New users start at Level 1
        "ecoPoints": 0, // ✅ New users start with 0 EcoPoints
        "createdAt": Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Account Created Successfully!"),
        backgroundColor: Colors.green,
      ));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),

                // **EcoTrack Title**
                Text(
                  "EcoTrack",
                  style: TextStyle(
                    fontSize: screenHeight * 0.04,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // **Sign Up Illustration**
                Image.asset(
                  'assets/images/signup.png', // Ensure this image exists in assets/images
                  width: screenWidth * 0.8,
                ),
                SizedBox(height: screenHeight * 0.04),

                // **Full Name Input Field**
                buildTextField(Icons.person, "Full Name", nameController),
                SizedBox(height: screenHeight * 0.02),

                // **Email Input Field**
                buildTextField(Icons.email, "Email", emailController),
                SizedBox(height: screenHeight * 0.02),

                // **Password Input Field**
                buildTextField(Icons.lock, "Password", passwordController, isPassword: true),
                SizedBox(height: screenHeight * 0.03),

                // **Sign Up Button** (Creates account)
                SizedBox(
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: screenHeight * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.03),

                // **Already Have an Account? → Sign In**
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already having an account?",
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignInScreen()),
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // **Widget for Input Fields**
  Widget buildTextField(IconData icon, String hintText, TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white, // White background
        hintStyle: TextStyle(color: Colors.black54),
        contentPadding: EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: TextStyle(color: Colors.black),
    );
  }
}
