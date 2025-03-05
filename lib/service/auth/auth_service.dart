import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<void> singup({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String message = 'weak-password';
      if (e.code == '') {
        message = 'the password provider is too weak';
      } else if (e.code == 'email-ready-in-use') {
        message = 'An account already exists with that email.';
      }
      print(message);
    }
  }

  Future<bool> signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('✅ Ingreso correctamente');
      return true;
    } on FirebaseAuthException catch (e) {
      String message = 'Ocurrió un error inesperado';

      if (e.code == 'user-not-found') {
        message = '❌ No se encontró un usuario con ese correo.';
      } else if (e.code == 'wrong-password') {
        message = '❌ La contraseña ingresada es incorrecta.';
      }
      print(message);
      return false;
    }
  }
}
