// lib/custom_login_page.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wellth_app/components/gradient-button.dart';

class CustomLoginPage extends StatefulWidget {
  //Geens Modifications
  final Function()? onTap;

  /// Pass your Google OAuth clientId here.
  /// Added required on tap - geena
  const CustomLoginPage({super.key, required this.onTap});
  //final String clientId;

  @override
  State<CustomLoginPage> createState() => _CustomLoginPageState();
}

class _CustomLoginPageState extends State<CustomLoginPage> {
  final _emailCtrl = TextEditingController();
  final _pwCtrl    = TextEditingController();
  bool _loading    = false;
  String? _error;

  //sign in users
  void signIn() async {
    // show laoding circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),),
    );

  setState(() {
    _loading = true;
    _error = null;
  });
  if(_pwCtrl.text.trim().isEmpty){
      //pop loading cirlce
      if (context.mounted) Navigator.pop(context);
      //show error to user
      displayMessage("Please enter a password");
      return;
    }

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailCtrl.text.trim(),
      password: _pwCtrl.text.trim(),
    );
    // pop loading circle
    if (context.mounted) Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    // pop loading circle
    if (context.mounted) Navigator.pop(context);
    displayMessage(e.code);
    if (!mounted) return;
    setState(() {
      _error = e.message;
    });
  } finally {
    if (!mounted) return;
    setState(() {
      _loading = false;
    });
  }
}

// display dialog message
void displayMessage (String message){
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(message),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    final gradient = const LinearGradient(
      colors: [Colors.blue, Colors.purple, Colors.orange],
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Logo ---

            Align(
              alignment: Alignment.center,
              child: Container(
                width: 400,
                height: 220,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                 
                ),
                
                  child: Transform.scale(
                    scale: 1.0,
                    child: Image.asset(
                      'assets/wellthlogo fin.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                
              ),
            ),
            
            Container(
              width: 360,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //const SizedBox(height: 24),

                  // --- Title + gradient underline ---
                  Column(
                    children: [
                        Align(
                        alignment: const Alignment(-0.9, 1),
                        child: Text(
                          'Sign in',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontFamily: 'Inter',
                            fontSize: 32,
                            ),
                        ),
                      ),

                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Container(
                              height: 4,
                              width: 146,
                              decoration: BoxDecoration(
                              gradient: gradient,
                              borderRadius: BorderRadius.circular(2), // Add this line to round the edges
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- Email field with gradient border ---
                  Align(
                    alignment: Alignment(-0.9, 0),
                    child: Container(
                      height: 38,
                      width: 270,
                      decoration: BoxDecoration(
                        gradient: gradient.withOpacity(0.27),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(2), // Border thickness
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Username or Email',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- Password field with gradient border ---
                    Align(
                    alignment: Alignment(-0.9, 0),
                    child: Container(
                      height: 38,
                      width: 270,
                      decoration: BoxDecoration(
                      gradient: gradient.withOpacity(0.27),
                      borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(2), // Border thickness
                      child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _pwCtrl,
                        obscureText: true,
                        decoration: const InputDecoration(
                        labelText: 'Password',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                      ),
                      ),
                    ),
                    ),
                  const SizedBox(height: 16),

                  // --- Error message ---
                  if (_error != null) ...[
                    Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // --- Gradient “Log in” button ---
                  MyGradientbutton(
                    onTap: signIn, 
                    text: 'Log in'
                    ),
                    SizedBox(height: 16),
                  /*DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: null,
                      child: _loading
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Log in', style: const TextStyle(color: Colors.black)),
                    ),
                  ),

                  const SizedBox(height: 16),*/

                  // --- Google Sign‐in button ---
                  ElevatedButton.icon(
                    /*icon: Image.asset(
                      'assets/google_logo.png',
                      height: 24,
                      width: 24,
                    ),*/
                    label: const Text('Continue with Google',style: const TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    ),
                    onPressed: null,
                  ),

                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 8),

                  // --- Footer link ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('New member?'),

                      //----------Geens Modifications----------//
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(' Create an account',style: const TextStyle(color: Colors.blue)),
                      ),
                      /*TextButton(
                        onPressed: () async {
                          try {

                            // Navigate to profile setup
                            Navigator.pushReplacementNamed(context, '/register');
                          } catch (e) {
                            print("Registration error: $e");
                            // Handle error (e.g., show snackbar)
                          }
                        },*///temp comment out till here

                        //child: const Text('Create an account'),
                      //),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    
    );
    
  }
}