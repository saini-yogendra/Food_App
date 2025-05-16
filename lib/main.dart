// import 'package:flutter/material.dart';
// import 'package:foodapp/Page/auth/login_screen.dart';
// import 'package:foodapp/Page/auth/signup_screen.dart';
// import 'package:foodapp/Screen/app_main_screen.dart';
// import 'package:foodapp/Screen/profile_screen.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
//
// import 'Screen/onboarding_screen.dart';
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Supabase.initialize(
//     url: "https://hwznlqxrzgptgmhvmoso.supabase.co",
//     anonKey:
//         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh3em5scXhyemdwdGdtaHZtb3NvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU2NTgyNjUsImV4cCI6MjA2MTIzNDI2NX0.ebvfwg_8xkJh3iJVxwzYSkbKqiGJnMVQUd8Aa5pLEmo",
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ProviderScope(
//       child: MaterialApp(debugShowCheckedModeBanner: false, home: AuthCheck()),
//     );
//   }
// }
//
// class AuthCheck extends StatelessWidget {
//   final supabase = Supabase.instance.client;
//   AuthCheck({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: supabase.auth.onAuthStateChange,
//       builder: (context, snapshot) {
//         final session = supabase.auth.currentSession;
//         if (session != null) {
//           return AppMainScreen();
//         } else {
//           return LoginScreen();
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodapp/Page/auth/login_screen.dart';
import 'package:foodapp/Screen/app_main_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://hwznlqxrzgptgmhvmoso.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh3em5scXhyemdwdGdtaHZtb3NvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDU2NTgyNjUsImV4cCI6MjA2MTIzNDI2NX0.ebvfwg_8xkJh3iJVxwzYSkbKqiGJnMVQUd8Aa5pLEmo",
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthCheck(),
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final session = supabase.auth.currentSession;
        if (session != null) {
          return const AppMainScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
