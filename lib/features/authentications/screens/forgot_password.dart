import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final String token;

  ForgotPassword({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
            toolbarHeight: 50,
            title: const Text("Reset Password"),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
              Navigator.pop(context);
            },
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(6),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 69,
                  height: 6,
                  color: const Color(0xFF304FFE),
                ),
              )
            ),
      ),
      body: SingleChildScrollView( 
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/fp1.png', height: 200),
                  const SizedBox(height: 30.0),
                  const Text(
                    'Enter your password and confirm password',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color.fromARGB(255, 77, 77, 77),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: 300,
                    child: Card(
                      color: const Color.fromARGB(0, 255, 255, 255),
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
                                suffixIcon: Icon(Icons.lock),
                                suffixIconColor: Color.fromARGB(255, 77, 77, 77),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 77, 77, 77), width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 77, 77, 77), width: 2.0),
                                  ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: _confirmPasswordController,
                              decoration: const InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
                                suffixIcon: Icon(Icons.lock),
                                suffixIconColor: Color.fromARGB(255, 77, 77, 77),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 77, 77, 77), width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color.fromARGB(255, 77, 77, 77), width: 2.0),
                                  ),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(onPressed: (){
                              String password = _passwordController.text;
                              String confirmPassword = _confirmPasswordController.text;
                              if(password == confirmPassword) {
                                // Call your backend API to reset the password with the token
                                print('Password reset with token: $token');
                              } else {
                                // Show an error message
                                print('Passwords do not match');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                              backgroundColor: const Color(0xFF304FFE),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                              foregroundColor: Colors.white,
                              elevation: 10,
                              shadowColor: Colors.black,
                            ),
                            child: const Text('Send'),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}
