import 'package:flutter/material.dart';

class SendEmailForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  SendEmailForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
            toolbarHeight: 50,
            title: const Text("Forgot Password"),
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
              child:Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/fp.png', height: 200),
                  const SizedBox(height: 30.0),
                  const Text(
                    'Enter your email to reset your password',
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
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
                                suffixIcon: Icon(Icons.email),
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
                            const SizedBox(height: 20),
                            ElevatedButton(onPressed: (){
                              String email = _emailController.text;
                              print('Password reset email sent to: $email');
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


