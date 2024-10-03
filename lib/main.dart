import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore db = FirebaseFirestore.instance;

  var pesquisa = "m";
  QuerySnapshot querySnapshot = await db.collection("usuarios")
  .where("nome", isGreaterThanOrEqualTo: pesquisa)
  .where("nome", isLessThanOrEqualTo: pesquisa + "\uf8ff")
  .get();

  for( DocumentSnapshot item in querySnapshot.docs){

    var dados = item;
    print("filtro nome: ${dados["nome"]} - idade: ${dados["idade"]}");

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
