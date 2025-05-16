// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:foodapp/Page/auth/signup_screen.dart';
// import 'package:foodapp/Screen/onboarding_screen.dart';
// import 'package:foodapp/Widgets/my_button.dart';
//
// import '../../Service/auth_service.dart';
// import '../../Widgets/snack_bar.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController passcontroller = TextEditingController();
//
//   final AuthService _authService = AuthService();
//   bool isLoading = false;
//   bool isPasswordHidden = true;
//
//
//   void _login() async{
//     String email = emailcontroller.text.trim();
//     String password = passcontroller.text.trim();
//
//
//
//     if (!mounted) return;
//     setState(() {
//       isLoading = true;
//     });
//     final result = await _authService.login(email, password);
//     if (result ==null) {
//       setState(() {
//         isLoading = false;
//       });
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OnboardingScreen()));
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//       showSnackBar(context, "Signup failed: $result",Colors.red);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         minimum: EdgeInsets.only(top: 15.0),
//         child: Padding(
//           padding: EdgeInsets.all(15),
//           child: Column(
//             children: [
//               Image.asset(
//                 "assets/images/login.png",
//                 width: double.maxFinite,
//                 height: 400,
//                 fit: BoxFit.cover,
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: emailcontroller,
//                 decoration: InputDecoration(
//                   labelText: "Email",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: passcontroller,
//                 decoration: InputDecoration(
//                   labelText: "Password",
//                   border: OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     onPressed: () {
//                       setState(() {
//                         isPasswordHidden = !isPasswordHidden;
//                       });
//                     },
//                     icon: Icon(isPasswordHidden ? Icons.visibility_off :
//                     Icons.visibility),
//                   ),
//                 ),
//                 obscureText: isPasswordHidden,
//               ),
//               SizedBox(height: 20),
//               isLoading ?
//               Center(
//                 child: CircularProgressIndicator(),) :
//
//               SizedBox(
//                 width: double.maxFinite,
//                 child: MyButton(onTap: _login, buttontext: "Login"),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Don't have an Account?",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (_) => SignupScreen()),
//                       );
//                     },
//                     child: Text(
//                       " Signup here",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                         letterSpacing: -1,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:foodapp/Page/auth/signup_screen.dart';
import 'package:foodapp/Screen/onboarding_screen.dart';
import 'package:foodapp/Widgets/my_button.dart';
import '../../Service/auth_service.dart';
import '../../Widgets/snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  final AuthService _authService = AuthService();
  bool isLoading = false;
  bool isPasswordHidden = true;

  void _login() async {
    String email = emailcontroller.text.trim();
    String password = passcontroller.text.trim();

    if (!mounted) return;
    setState(() {
      isLoading = true;
    });

    final result = await _authService.login(email, password);

    if (result == null) {
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => OnboardingScreen()));
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "Login failed: $result", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 20),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.35,
                child: Image.asset(
                  "assets/images/login.png",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: passcontroller,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      });
                    },
                    icon: Icon(
                      isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              isLoading
                  ? CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                child: MyButton(onTap: _login, buttontext: "Login"),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an Account?", style: TextStyle(fontSize: 16)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => SignupScreen()),
                      );
                    },
                    child: Text(
                      " Signup here",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
