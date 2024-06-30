import 'package:flutter/material.dart';
import 'forgot_password.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( 
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/logo-bima.png', height: 100,),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: 300,
                child: Card(
                  color: const Color.fromARGB(0, 255, 255, 255),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Align(
                          alignment: Alignment.centerLeft,
                        child: Text(
                          'Login to your Account',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Color.fromARGB(255, 77, 77, 77),
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        ),
                        const SizedBox(height: 20.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            children: <Widget>[
                              TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Username',
                                  labelStyle: TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
                                  suffixIcon: Icon(Icons.person),
                                  suffixIconColor: Color.fromARGB(255, 77, 77, 77),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 77, 77, 77), width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 77, 77, 77), width: 2.0),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 20.0),
                              TextField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
                                  suffixIcon: Icon(Icons.key),
                                  suffixIconColor: Color.fromARGB(255, 77, 77, 77),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 77, 77, 77), width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 77, 77, 77), width: 2.0),
                                  ),
                                ),
                                obscureText: true,
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                      context, 
                                      MaterialPageRoute(builder: (context) => ForgotPasswordScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Forgot password ? Click here',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 77, 77, 77),
                                    ),
                                  ),
                                ) 
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // String email = _emailController.text;
                              // String password = _passwordController.text;
                              // For now, just print the email and password
                              // print('Email: $email, Password: $password');
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                              backgroundColor: const Color(0xFF050C9C),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                // shadows: 
                              ),
                              foregroundColor: Colors.white,
                              elevation: 10,
                              shadowColor: Colors.black,
                            ),
                            child: const Text('Login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ),
              ],
            )
        ),
      ),
      ),
    );
  }
}
