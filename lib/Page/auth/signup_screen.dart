// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:foodapp/Page/auth/login_screen.dart';
// import 'package:foodapp/Service/auth_service.dart';
// import 'package:foodapp/Widgets/my_button.dart';
// import 'package:foodapp/Widgets/snack_bar.dart';
//
// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});
//
//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController passcontroller = TextEditingController();
//
//   final AuthService _authService = AuthService();
//   bool isLoading = false;
//   bool isPasswordHidden = true;
//
//
//   void _signup() async{
//     String email = emailcontroller.text.trim();
//     String password = passcontroller.text.trim();
//
//
//
//     if (!email.contains(".com")) {
//       showSnackBar(context, "Invalid email.",Colors.red);
//     }
//     setState(() {
//       isLoading = true;
//     });
//     final result = await _authService.signup(email, password);
//     if (result ==null) {
//       setState(() {
//         isLoading = false;
//       });
//       showSnackBar(context, "Signup Successfully! Turn to login",Colors.green);
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
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
//                 "assets/images/signup.png",
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
//                         Icons.visibility),
//                   ),
//                 ),
//                 obscureText: isPasswordHidden,
//               ),
//               SizedBox(height: 20),
//               isLoading ?
//                   Center(
//                     child: CircularProgressIndicator(),) :
//
//               SizedBox(
//                 width: double.maxFinite,
//                 child: MyButton(onTap: _signup, buttontext: "SignUp"),
//               ),
//               SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Already have an Account?",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (_) => LoginScreen()),
//                       );
//                     },
//                     child: Text(
//                       " Login here",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.blue,
//                         letterSpacing: -1,
//                       ),
//                     ),
//                   )
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
import 'package:foodapp/Page/auth/login_screen.dart';
import 'package:foodapp/Service/auth_service.dart';
import 'package:foodapp/Widgets/my_button.dart';
import 'package:foodapp/Widgets/snack_bar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  final AuthService _authService = AuthService();

  bool isLoading = false;
  bool isPasswordHidden = true;

  void _signup() async {
    String email = emailcontroller.text.trim();
    String password = passcontroller.text.trim();

    if (!email.contains(".com")) {
      showSnackBar(context, "Invalid email.", Colors.red);
      return;
    }

    setState(() {
      isLoading = true;
    });

    final result = await _authService.signup(email, password);

    setState(() {
      isLoading = false;
    });

    if (result == null) {
      showSnackBar(context, "Signup Successfully! Turn to login", Colors.green);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    } else {
      showSnackBar(context, "Signup failed: $result", Colors.red);
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/signup.png",
                width: double.infinity,
                height: size.height * 0.35,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailcontroller,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passcontroller,
                obscureText: isPasswordHidden,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
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
              const SizedBox(height: 25),
              isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                child: MyButton(onTap: _signup, buttontext: "SignUp"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an Account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      " Login here",
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
