import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/firebase_options.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mynotes/views/register_view.dart';
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
  ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
            final user=FirebaseAuth.instance.currentUser;
            if(user?.emailVerified??false){
              print('You need to verify your email');
            }else{
              print('DOne');
            }
              return const Text('Done');
            default:
              return const Text("loading..");
          }

        },
      ),
    );
  }
}
