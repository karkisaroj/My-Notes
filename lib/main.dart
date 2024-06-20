import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/Verify_Email.dart';
import 'package:mynotes/views/firebase_options.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mynotes/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData( 
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomePage(),
    routes: {
      '/register/': (context) => const RegisterView(),
      '/login/': (context) => const LoginView(),
    },
  ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

@override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            final user=FirebaseAuth.instance.currentUser;
            if(user!=null){
              if(user.emailVerified){
                return const NotesView();
            }else{
             return const VerifyExailView();
            }
            }
            return const LoginView();
            default:
                return const CircularProgressIndicator();
            } 
        },
      );
  }
}
// git remote add origin https://github.com/karkisaroj/karkisaroj.git
// git branch -M main
// git push -u origin main

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
} 

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Notes'),
        backgroundColor: Colors.blue[400],
      ),
      body: const Text('Hello world!'),
    );
  }
}