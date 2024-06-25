import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exception.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/utilities/show_error_dialogs.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}
class _LoginViewState extends State<LoginView> {
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
        title: Text('Login'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter your email',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              hintText: 'Enter your password',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                
                final userCredential =
                await AuthService.firebase().login(
                  email: email,
                  password: password,
                );
                final user=AuthService.firebase().currentUser;
                if(user?.isEmailVerified??false) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                     (Route)=>false,
                     );
                }else{
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyEmailRoutes,
                    (Route)=>false,
                  );
                }
                
              }on UserNotFoundAuthException{
                  await showErrorDialog(
                      context,
                      'Email not verified',
                  );
              }
              on WrongPasswordAuthException{
                  await showErrorDialog(context, 'Wrong password',);
              }
              on GenericAuthException{
                await showErrorDialog(
                      context,
                      'Authentication error',
                  );
              }    
            }, child: const Text('Login'),
          ),
          TextButton(onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              registerRoute,
                  (Route) => false,
            );
          },
            child: Text('Dont have a account yet?  Register here!'),
          )
        ],
      ),
    );
  }
}
