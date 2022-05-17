import 'package:flutter/material.dart';
import 'package:login_firebase/config/themes.dart';
import 'package:login_firebase/modules/register/register_screen.dart';
import 'package:login_firebase/widgets/components/app_button.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginScreen ({Key? key, required this.onClickedSignUp}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObsecure = true;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(child: _buildBody()),
      ),
    );
  }

  Widget _buildBody() {
    return _buildContent();
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 128),
          Center(
              child: Image.asset(
            "assets/image/logo-rise.png",
            width: 240,
          )),
          const SizedBox(height: 128),
          const Text("Email"),
          TextFormField(
            controller: usernameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) {
              if (email == null || email.isEmpty) {
                return "Email must not be empty";
              } else if (!email.isValidEmail()) {
                return "Email is not valid";
              }
              return null;
            },
            obscureText: false,
            decoration: const InputDecoration(
              hintText: "ex: denishdoe",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text("Password"),
          TextFormField(
            controller: passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (password) {
              if (password == "" || password!.isEmpty) {
                return "Password is required";
              } else if (password.length < 6) {
                return "Password must more than 6 character";
              }
              return null;
            },
            obscureText: _isObsecure,
            decoration: InputDecoration(
              hintText: "Enter your password",
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(
                    () {
                      _isObsecure = !_isObsecure;
                    },
                  );
                },
                icon:
                    Icon(_isObsecure ? Icons.visibility : Icons.visibility_off),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          AppButton(
            text: "Login",
            onPressed: (){},
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Want to use Roketin Attendance ?"),
              TextButton(
                  onPressed: () {
                    widget.onClickedSignUp();
                  },
                  child: const Text("Get it Now!"))
            ],
          )
        ],
      ),
    );
  }
}
