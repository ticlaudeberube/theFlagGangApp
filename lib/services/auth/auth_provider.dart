import 'package:theflaggangapp/services/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;
  Future<AuthUser> login({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  // Future<void> signInWithEmailAndPassword(String email, String password);
  // Future<void> registerWithEmailAndPassword(String email, String password);
  Future<void> logOut();
  Future<void> sendEmailVerification();
  // Future<void> reloadUser();
}
