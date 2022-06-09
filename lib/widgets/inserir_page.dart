import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'mensagem.dart';


class InserirPage extends StatefulWidget {
  const InserirPage({Key? key}) : super(key: key);

  @override
  _InserirPageState createState() => _InserirPageState();
}

class _InserirPageState extends State<InserirPage> {
  var txtNome = TextEditingController();
  var txtPreco = TextEditingController();

  retornarDocumentoById(id) async {
    await FirebaseFirestore.instance
        .collection('produtos')
        .doc(id)
        .get()
        .then((doc) {
      txtNome.text = doc.get('nome');
      txtPreco.text = doc.get('preco');
    });
  }

  @override
  Widget build(BuildContext context) {
    //Recuperar o ID do Produto
    var id = ModalRoute.of(context)!.settings.arguments;

    if (id != null) {
      if (txtNome.text.isEmpty && txtPreco.text.isEmpty) {
        retornarDocumentoById(id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.red[50],
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            campoTexto('Nome', txtNome, Icons.production_quantity_limits_outlined),
            const SizedBox(height: 20),
            campoTexto('Preço', txtPreco, Icons.monetization_on_outlined),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.red.shade900,
                    ),
                    child: const Text('Salvar'),
                    onPressed: () {
                      if (id == null) {
                        //Adicionar um novo documento
                        FirebaseFirestore.instance.collection('produtos').add(
                          {
                            "nome": txtNome.text,
                            "preco": txtPreco.text,
                          },
                        );
                        sucesso(context, 'O item foi adicionado com sucesso.');
                      } else {
                        //Alterar um documento
                        FirebaseFirestore.instance
                            .collection('produtos')
                            .doc(id.toString())
                            .set(
                          {
                            "nome": txtNome.text,
                            "preco": txtPreco.text,
                          },
                        );
                        sucesso(context, 'O item foi alterado com sucesso.');
                      }

                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 150,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.red.shade900,
                      ),
                      child: const Text('Cancelar'),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  campoTexto(texto, controller, icone, {senha}) {
    return TextField(
      controller: controller,
      obscureText: senha != null ? true : false,
      style: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.w300,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icone, color: Colors.red),
        prefixIconColor: Colors.red,
        labelText: texto,
        labelStyle: const TextStyle(color: Colors.red),
        border: const OutlineInputBorder(),
        focusColor: Colors.red,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 0.0,
          ),
        ),
      ),
    );
  }
}
