
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          const Text('Please verify your email address'),
          TextButton(
            onPressed: () async{
              final user=FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            }, child: const Text('Send email verification'),
            )
        ],
        ),
    );
  }
}