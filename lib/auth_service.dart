import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Converter matrícula em email
  String _matriculaToEmail(String matricula) {
    return '${matricula}@empresa.com';
  }

  // Registrar usuário (função para admin)
  Future<User?> registerUser(String matricula, String senha, String nome) async {
    try {
      String email = _matriculaToEmail(matricula);
      
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      
      User? user = result.user;
      
      if (user != null) {
        // Salvar dados do usuário no Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'matricula': matricula,
          'email': email,
          'nome': nome,
          'created_at': FieldValue.serverTimestamp(),
        });
      }
      
      return user;
    } catch (e) {
      print('Erro no registro: $e');
      return null;
    }
  }

  // Login com matrícula e senha
  Future<User?> signInWithMatricula(String matricula, String senha) async {
    try {
      String email = _matriculaToEmail(matricula);
      
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      
      return result.user;
    } catch (e) {
      print('Erro no login: $e');
      return null;
    }
  }

  // Logout
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Erro no logout: $e');
    }
  }

  // Stream do usuário atual
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  // Usuário atual
  User? get currentUser {
    return _auth.currentUser;
  }

  // Buscar dados do usuário
  Future<DocumentSnapshot> getUserData(String uid) async {
    return await _firestore.collection('users').doc(uid).get();
  }
}