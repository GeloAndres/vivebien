import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static const String weakPasswordErrorCode = 'weak-password';
  static const String emailAlreadyInUseErrorCode = 'email-already-in-use';

  Future<bool> signUp({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      String message = 'Error desconocido';

      switch (e.code) {
        case weakPasswordErrorCode:
          message = 'La contraseña es demasiado débil.';
          break;
        case emailAlreadyInUseErrorCode:
          message = 'Ya existe una cuenta con ese correo electrónico.';
          break;
        // Agrega más errores
      }

      print(message);
    }
    return false;
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
