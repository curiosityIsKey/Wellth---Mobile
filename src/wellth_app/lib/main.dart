import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';                  // Added from codelab
import 'package:flutter/material.dart';

import 'app.dart';
import 'firebase_options.dart';                                     // Added from codelab

// TODO(codelab user): Get API key
const clientId = 'YOUR_CLIENT_ID';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp(clientId: clientId));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => MyAppState(),
//       child: MaterialApp(
//         title: 'Namer App',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
//         ),
//         home: MyHomePage(),
//       ),
//     );
//   }
// }

// class MyAppState extends ChangeNotifier {
//   var current = WordPair.random();
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var appState = context.watch<MyAppState>();

//     return Scaffold(
//       body: Column(
//         children: [Text('A random DOPE idea:'), 
//         Text(appState.current.asLowerCase),
        
//         ElevatedButton(
//           onPressed: () {
//             print('button pressed!');
//           },
//           child: Text('Next'),
//         ),
        
//         ],
//       ),
//     );
//   }
// }