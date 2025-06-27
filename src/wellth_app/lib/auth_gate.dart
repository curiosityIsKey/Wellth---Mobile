import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'custom_login_page.dart';
import 'home.dart';

/// Wraps your app and decides whether to show the login page or HomeScreen.
class AuthGate extends StatelessWidget {
  const AuthGate({Key? key, required this.clientId}) : super(key: key);

  /// Your Google OAuth client ID from the Firebase console
  final String clientId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the user is NOT signed in, show the custom login page
        if (!snapshot.hasData) {
          return CustomLoginPage(clientId: clientId);
        }
        // Otherwise, show the home screen
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
