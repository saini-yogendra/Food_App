import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/Page/auth/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService{
  final supabase = Supabase.instance.client;
  Future<String?> signup(String email, String password) async{
    try{
      final response = await supabase.auth.signUp(
          password: password,
          email: email
      );
      if (response.user != null) {
        return null;
      }
      return "An unkonown error occur";

    } on AuthException catch (e) {
      return e.message;
    } catch (e){
      return "Error:$e";
    }
  }

  // login function
  Future<String?> login(String email, String password) async{
    try{
      final response = await supabase.auth.signInWithPassword(
          password: password,
          email: email
      );
      if (response.user != null) {
        return null;
      }
      return "Invalid email or password";

    } on AuthException catch (e) {
      return e.message;
    } catch (e){
      return "Error:$e";
    }
  }


  // logout function
  Future<void> logout(BuildContext context) async{
    try{
      await supabase.auth.signOut();
      if (!context.mounted) return;
      Navigator.of(context,).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen(),),);
    } catch(e) {
      print("Logout error $e");
    }
  }



}