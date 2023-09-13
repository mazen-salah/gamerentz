import 'package:flutter/material.dart';
import 'package:gamerentz/controllers/auth_controller.dart';
import 'package:gamerentz/utils/helper_widgets.dart';
import 'package:gamerentz/utils/show_snackBar.dart';
import 'package:gamerentz/views/auth/register_screen.dart';
import 'package:gamerentz/views/screens/main_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 300,
            ),
            verticalSpace(10),
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const LoginForm(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Need an Account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BuyerRegisterScreen(),
                      ),
                    );
                  },
                  child: const Text('Register'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  late String email;
  late String password;
  bool _isLoading = false;

  void _loginUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final loginResult = await _authController.loginUsers(email, password);

      setState(() {
        _isLoading = false;
      });

      if (loginResult == 'success') {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const MainScreen(),
          ),
        );
        
      } else {
        if (!mounted) return;
        showSnack(context, loginResult);
      }
    } else {
      showSnack(context, 'Please fill in all fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              } else {
                return null;
              }
            },
            onChanged: (value) {
              email = value;
            },
            decoration: const InputDecoration(
              labelText: 'Enter Email Address',
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              } else {
                return null;
              }
            },
            onChanged: (value) {
              password = value;
            },
            decoration: const InputDecoration(
              labelText: 'Enter Password',
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              _loginUser();
            },
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        'Login',
                        style: TextStyle(
                          letterSpacing: 5,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
