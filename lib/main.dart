import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore db = FirebaseFirestore.instance;
  
  QuerySnapshot querySnapshot = await db.collection("usuarios")
  // .where("idade", isEqualTo: "21")
  // .where("idade", isGreaterThan: 20)
  // .where("idade", isLessThan: 40)
  .orderBy("idade", descending: true)
  .orderBy("nome", descending: false)
  .limit(3)
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
