
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';

class VerifyExailView extends StatefulWidget {
  const VerifyExailView({super.key});

  @override
  State<VerifyExailView> createState() => _VerifyExailViewState();
}

class _VerifyExailViewState extends State<VerifyExailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Verify'),
      ),
      body: Column(
        children: [
          const Text("We've sent you an email verification message to your email address! please open it to verify your email address"),
          const Text("If you havn't received a verification message email yet , press the button below"),
          TextButton(
            onPressed: () async{
              final user=FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            }, child: const Text('Send email verification'),
            ),
            TextButton(
              onPressed: () async{
                await FirebaseAuth.instance.signOut();
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