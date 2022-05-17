import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/config/themes.dart';
import 'package:login_firebase/widgets/components/app_button.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  static const String routeName = "/confirmationScreen";

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: _buildBody()));
  }

  Widget _buildBody() {
    return _buildContent();
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const SizedBox(
            height: 64,
          ),
          Center(
              child: Image.asset(
            "assets/image/checklist-rise.png",
            width: 160,
          )),
          const Text("Register Success", style: AppTheme.title1,),
          const SizedBox(height: 16,),
          const Text(
            "You have succesfully registered an account at Roketin Attendance. Please check your email, you need to confirm your acount clicking the link we have sent you.",
            style: TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          Expanded(child: Container()),
          AppButton(
            text: "Okay",
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
          const SizedBox(height: 64,)
        ],
      ),
    );
  }
}
