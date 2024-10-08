import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;
  String email = "matheus@gmail.com";
  String password = "12345678";

  /*
  auth.createUserWithEmailAndPassword(
      email: email,
      password: password
  ).then(( UserCredential userCrential ){
      print("sucesso ao criar novo usuário!!! e-mail: " + (userCrential.user!.email ?? "Sem email"));
  }).catchError((erro){
    print("Novo usuário: erro " + erro.toString());
  });*/

  User? usuarioAtual = auth.currentUser;
  if(usuarioAtual !=null ){
  print("Usuario logado email: " + (usuarioAtual.email ?? "Sem email"));
 } else{
    print("Usuario NÃO CREDENCIADO");
  }

  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
