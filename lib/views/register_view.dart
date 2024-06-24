import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/utilities/show_error_dialogs.dart';



class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
              ),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  final user=FirebaseAuth.instance.currentUser;
                  user?.sendEmailVerification();
                  Navigator.of(context).pushNamed(verifyEmailRoutes);

                    showErrorDialog(context,'The password is too weak.');
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    showErrorDialog(context,'The password is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    showErrorDialog(context,'The email is already in use by another account.');
                  } else if (e.code == 'invalid-email') {
                    showErrorDialog(context,'The email address is not valid.');
                  }else{
                    showErrorDialog(context,'Error:${e.message}',
                    );
                  }
                }catch(e) {
                await showErrorDialog(
                      context, 
                      e.toString(),
                  );
              }
              },
              child: const Text('Register'),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute, 
                  (Route)=> false,
                  );
              }, child:const Text('Already registered? Login here!'),
              )
          ],
        ),
      ),
    );
  }
}
