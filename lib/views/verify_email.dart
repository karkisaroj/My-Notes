import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Verify'),
      ),
      body: Column(
        children: [
          const Text("We've sent you an email verification message to your email address! please open it to verify your email address"),
          const Text("If you hadn't received a verification message email yet , press the button below"),
          TextButton(
            onPressed: () async{
              await AuthService.firebase().sendEmailVerification();
            }, child: const Text('Send email verification'),
            ),
            TextButton(
              onPressed: () async{
                AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute, 
                (route)=>false,
                );
              },
              child: Text("Restart"),
            )
        ],
        ),
    );
  }
}