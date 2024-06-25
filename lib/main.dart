import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/views/verify_email.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes_views.dart';
import 'package:mynotes/views/register_view.dart';
import 'constants/routes.dart';


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
      registerRoute: (context) => const RegisterView(),
      loginRoute: (context) => const LoginView(),
      notesRoute:(context) => const NotesView(),
      verifyEmailRoutes:(context)=> const VerifyExailView(),
    },
  ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

@override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
            final user=AuthService.firebase().currentUser;
            if(user!=null){
              if(user.isEmailVerified){
                return const NotesView();
            }else{
             return const VerifyExailView();
            }
            }
            return const NotesView();
            default:
                return const CircularProgressIndicator();
            } 
        },
      );
  }
}

