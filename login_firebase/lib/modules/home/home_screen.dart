import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/config/themes.dart';
import 'package:login_firebase/widgets/components/app_button.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_page';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(child: Text("Signed in as :")),
              const SizedBox(height: 4,),
              Text(user.email!),
              const SizedBox(height: 16,),
              AppButton(
              text: "Logout",
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              options: const ButtonOptions(
                width: double.infinity,
                height: 48,
                textStyle: TextStyle(color: Colors.white),
                color: AppTheme.primaryColor,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: 12,
              ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}
