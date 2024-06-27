import 'dart:math';

import 'package:mynotes/services/auth/auth_exception.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main(){
    group('Mock Authentication',(){
       final provider=MockAuthProvider();
       test(
        'shouldnot be intitialized to begin with',(){
          expect(provider.isInitialized, false);
        });
        test('cannot log out if not initialized',(){
          expect(provider.logOut(),
          throwsA(const TypeMatcher<NotInitializedException>()),
    );
    test('Should be able to be initialized', ()async{
      await provider.initialize();
      expect(provider._isInitialized, true);
    });
    test('User should be null after initialization', (){
      expect(provider.currentUser, null);
    });
    test('should be initialize in less than 2 seconds', ()async{
      await provider.initialize();
      expect(provider.initialize(), true); 
    },
    timeout: const Timeout( Duration(seconds: 2)),
    );
    }
); 
test('Create user should delegate to login function', () async {
  final badEmailUser=provider.createUser(email: 'karkisaroj3012@gmail.com', password: 'anypassword');
  expect(badEmailUser, 
  throwsA(const TypeMatcher<UserNotFoundAuthException>()));
  final badPasswordUser=provider.createUser(email: 'karkisaroj@gmail.com', password: 'karkisaroj');
  expect(badPasswordUser, throwsA(const TypeMatcher<WrongPasswordAuthException>()));
  final user=await provider.createUser(email: 'karkisaroj3011', password: 'karkisaroj');
  expect(provider.currentUser,user);
  expect(user.isEmailVerified, false);
});
test('login user should be able to get verified', (){
  provider.sendEmailVerification();
  final user=provider.currentUser;
  expect(user,isNotNull);
  expect(user!.isEmailVerified, true);
});
test('Should be able to log out and log in again ',()async {
    await provider.logOut();
    await provider.login(email: 'email', password:'password');
    final user=provider.currentUser;
    expect(user, isNotNull);
});
});
}
class NotInitializedException implements Exception{}

class MockAuthProvider implements AuthProvider{
  AuthUser? _user;
  var _isInitialized=false;
  bool get isInitialized=>_isInitialized;
  @override
  Future<AuthUser> createUser({required String email, required String password,}) async{
    if(!isInitialized) throw NotInitializedException();
    Future.delayed(const Duration(seconds: 1));
    return login(email: email, password: password,
    );
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async{
    Future.delayed(const Duration(seconds: 1));
    _isInitialized =true;
  }

  @override
  Future<void> logOut() async{
    if(!isInitialized) throw NotInitializedException();
    if(_user==null){
      throw UserNotFoundAuthException();
    }
    await Future.delayed(const Duration(seconds: 1));
    _user=null;
  }

  @override
  Future<AuthUser> login({required String email, required String password}) {
    if(!isInitialized) throw NotInitializedException();
     if(email=='karkisaroj.com') throw UserNotFoundAuthException();
     if(password=='karkisaroj') throw WrongPasswordAuthException();
     const user=AuthUser(isEmailVerified: false);
     _user=user;
     return Future.value(user);
  }

  @override
  Future<void> sendEmailVerification() async{
    if(!isInitialized) throw NotInitializedException();
    final user=_user;
    if(user==null) throw UserNotFoundAuthException();
    const newUser=AuthUser(isEmailVerified: true);
    _user=newUser;
  }
}