import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart'; // Allows Google sign-in
import 'package:flutter/material.dart';

import 'home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key, required this.clientId});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(                                       
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // Creates sign in screen
          return SignInScreen( 
            providers: [EmailAuthProvider(),
            GoogleProvider(clientId: "600688007911-843vqn9lh009cts01ik2503gvlepmupf.apps.googleusercontent.com"),
            ],
            // Create styling and logo display for narrow screens (iOS & Android)
            headerBuilder: (context, constraints, shrinkOffset) { 
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/flutterfire_300x.png'),
                ),
              );
            },
            // Adds subtitle depending on if screen is sign in or registration
            subtitleBuilder: (context, action) {                     
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to FlutterFire, please sign in!')
                    : const Text('Welcome to Flutterfire, please sign up!'),
              );
            },
            // Adds footer to sign in screen
            // Default terms and conditions statement
            footerBuilder: (context, action) {                       
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            // Adds widget to display logo image on widescreens (web and desktop)
            sideBuilder: (context, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/flutterfire_300x.png'),
                ),
              );
            }, 
          );
        }

        return const HomeScreen();
      },
    );                                                                
  }
}

// ```

// The headerBuilder argument requires a function of the type HeaderBuilder, which
// is defined in the FlutterFire UI package.

// ```dart

typedef HeaderBuilder = Widget Function(
 BuildContext context,
 BoxConstraints constraints,
 double shrinkOffset,
);
