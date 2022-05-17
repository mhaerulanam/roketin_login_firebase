import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/config/themes.dart';
import 'package:login_firebase/main.dart';
import 'package:login_firebase/widgets/components/app_button.dart';

class RegisterScreen extends StatefulWidget {
  final Function() onClickedSignIn;

  const RegisterScreen({Key? key, required this.onClickedSignIn})
      : super(key: key);

  static const String routeName = "/registerScreenRoute";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obsecurePassword = true;
  bool _obsecureConfirmPassword = true;

  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final numberPhoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBody(),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            widget.onClickedSignIn();
          },
        ),
      ),
    );
  }

  Widget _buildBody() {
    return _buildContent();
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleSection(),
            const SizedBox(
              height: 24,
            ),
            _buildForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Username"),
          TextFormField(
            controller: usernameController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: false,
            keyboardType: TextInputType.text,
            validator: (username) {
              if (username == "" || username!.isEmpty) {
                return "Username is required";
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "ex: denishdoe",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text("Password"),
          TextFormField(
            controller: passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            validator: (password) {
              if (password == "" || password!.isEmpty) {
                return "Password is required";
              } else if (password.length < 4) {
                return "Password must more than 4 character";
              }
              return null;
            },
            obscureText: _obsecurePassword,
            decoration: InputDecoration(
              hintText: "Enter your password",
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(
                    () {
                      _obsecurePassword = !_obsecurePassword;
                    },
                  );
                },
                icon: Icon(_obsecurePassword
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text("Confirm Password"),
          TextFormField(
            controller: confirmPasswordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.text,
            validator: (confirmPassword) {
              if (confirmPassword == null || confirmPassword.isEmpty) {
                return "Confirm password must not be empty";
              } else if (confirmPassword != passwordController.text) {
                return "Confirm password must match with password";
              }
              return null;
            },
            obscureText: _obsecureConfirmPassword,
            decoration: InputDecoration(
              hintText: "Enter your password",
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(
                    () {
                      _obsecureConfirmPassword = !_obsecureConfirmPassword;
                    },
                  );
                },
                icon: Icon(_obsecureConfirmPassword
                    ? Icons.visibility
                    : Icons.visibility_off),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text("Number Phone"),
          TextFormField(
            controller: numberPhoneController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (phone) {
              if (phone == null || phone.isEmpty) {
                return "Phone number must not be empty";
              } else if (phone.length < 11) {
                return "Phone number is not valid";
              }
              return null;
            },
            obscureText: false,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "ex: 082313324xxx",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text("Email"),
          TextFormField(
            controller: emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.emailAddress,
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
              hintText: "ex: denishdoe@roketin.com",
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
          AppButton(
            text: "Register",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                signUp();
              }
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account ?"),
              TextButton(
                  onPressed: () {
                    widget.onClickedSignIn();
                  },
                  child: const Text("Back to login"))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Register", style: AppTheme.title1),
        Text("Make an account"),
      ],
    );
  }

  Future signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(
        content: Text(e.message.toString()),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
