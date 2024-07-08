import 'package:flutter/material.dart';
import 'package:myapp/features/authentication/screens/login_page.dart';

class ForgotPassword extends StatefulWidget {
  final String token;

  const ForgotPassword({super.key, required this.token});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Reset Your Password",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  "Enter your new password and confirm it.",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 90.0),
                Center(
                  child: Image.asset(
                    'assets/images/rp.png',
                    height: 320.0,
                  ),
                ),
                const SizedBox(height: 30.0),
                Card(
                  color: const Color.fromARGB(0, 255, 255, 255),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'Password',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: 'Please Enter Your Password',
                            filled: true,
                            fillColor: const Color(0xFFF3F4F8),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                          obscureText: !_passwordVisible,
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Confirm Password',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            hintText: 'Please Enter Your Password Again',
                            filled: true,
                            fillColor: const Color(0xFFF3F4F8),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8.0)),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _confirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _confirmPasswordVisible = !_confirmPasswordVisible;
                                });
                              },
                            ),
                          ),
                          obscureText: !_confirmPasswordVisible,
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                              String password = _passwordController.text;
                              String confirmPassword = _confirmPasswordController.text;
                              if (password == confirmPassword) {
                                // Call your backend API to reset the password with the token
                                print('Password reset with token: ${widget.token}');
                              } else {
                                // Show an error message
                                print('Passwords do not match');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                              backgroundColor: const Color(0xFF304FFE),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              foregroundColor: Colors.white,
                              elevation: 5,
                            ),
                            child: const Text('Change Password'),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
