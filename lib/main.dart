import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _statusUpload = "Upload nao iniciado";
  String? _urlImagemRecuperada;

  XFile? _imagem;
  XFile? imagemSelecionada;
  Future _recuperarImagem(bool daCamera) async{
      if ( daCamera ){
        imagemSelecionada = await ImagePicker().pickImage(source: ImageSource.camera);
      } else{
        imagemSelecionada = await ImagePicker().pickImage(source: ImageSource.gallery);
      }

      setState(() {
        _imagem = imagemSelecionada;
      });
}

    Future _uploadImagem() async{
      if (_imagem == null) {
        print("Nenhuma imagem selecionada.");
        return;
      }
      // Referenciar arquivo
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference pastaRaiz = storage.ref();
      Reference arquivo = pastaRaiz.child("fotos").child("foto1.jpg");
      File file = File(_imagem!.path);
      // Fazer upload de imagem
      UploadTask task = arquivo.putFile(file);

     task.snapshotEvents.listen((TaskSnapshot snapshot){
         if(snapshot.state == TaskState.running){
          setState(() {
            _statusUpload = "Em progresso";
          });
        } else if (snapshot.state == TaskState.success){
           setState(() {
             _statusUpload = "Upload realizado com sucesso!";
           });
           _recuperarUrlImagem(snapshot);
         }
     }, onError: (e){
       print("Error");
      setState(() {
        _statusUpload = "Erro no upload";
      });
     });
  }

  Future _recuperarUrlImagem(TaskSnapshot snapshot) async{

    String url = await snapshot.ref.getDownloadURL();
    print("Resultado url: " + url);
    setState(() {
      _urlImagemRecuperada = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Selecionando imagens", style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(_statusUpload),
            ElevatedButton(
            child: Text("Camera"),
            onPressed: () {
                _recuperarImagem(true);
            },
            ),
            ElevatedButton(
              child: Text("Galeria"),
              onPressed: () {
                _recuperarImagem(false);
              },
            ),
            _imagem == null
            ? Container()
                : Image.file(File(_imagem!.path)),
            _imagem == null
            ? Container()
              : ElevatedButton(
              child: Text("Upload Storage"),
              onPressed: () {
                _uploadImagem();
              },
            ),
            _urlImagemRecuperada == null
                ? Container()
                : Image.network(_urlImagemRecuperada!),
          ],
        ),
      ),
    );
  }
}

