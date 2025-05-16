import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodapp/Core/Provider/cart_provider.dart';
import 'package:foodapp/Core/Provider/favorite_provider.dart';
import 'package:foodapp/Service/auth_service.dart';
AuthService authService = AuthService();
class ProfileScreen extends ConsumerWidget {
   ProfileScreen({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  authService.logout(context);
                  ref.invalidate(favoriteProvider);
                  ref.invalidate(cartProvider);
                },
                child: const Icon(Icons.exit_to_app),
            )
          ],
        ),
      ),
    );
  }
}
