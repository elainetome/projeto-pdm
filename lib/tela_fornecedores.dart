import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'widgets/mensagem.dart';



class TelaFornecedoresPage extends StatefulWidget {
  const TelaFornecedoresPage({Key? key}) : super(key: key);

  @override
  _TelaFornecedoresState createState() => _TelaFornecedoresState();

}

class _TelaFornecedoresState extends State<TelaFornecedoresPage> {
  var txtNome = TextEditingController();
  var txtCnpj = TextEditingController();
  var txtinscricao = TextEditingController();
  var txtfone = TextEditingController();
  var txtemail = TextEditingController();

  retornarDocumentoById(id) async {
    await FirebaseFirestore.instance
        .collection('Fornecedores')
        .doc(id)
        .get()
        .then((doc) {
      txtNome.text = doc.get('nome');
      txtCnpj.text = doc.get('cnpj');
      txtinscricao.text = doc.get('inscrição estadual');
      txtfone.text = doc.get('telefone');
      txtemail.text = doc.get('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    //Recuperar o ID do Produto
    var id = ModalRoute.of(context)!.settings.arguments;

    if (id != null) {
      if (txtNome.text.isEmpty && txtCnpj.text.isEmpty && txtinscricao.text.isEmpty && txtfone.text.isEmpty && txtemail.text.isEmpty) {
        retornarDocumentoById(id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fornecedores'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.red[50],
      body: Container(
        padding: const EdgeInsets.all(50),
        child: ListView(
          children: [
            campoTexto('Nome', txtNome, Icons.person_add_alt_outlined),
            const SizedBox(height: 20),
            campoTexto('CNPJ', txtCnpj, Icons.document_scanner_outlined),
            const SizedBox(height: 40),
            campoTexto('Inscrição Estadual', txtinscricao, Icons.document_scanner_outlined),
            const SizedBox(height: 20),
            campoTexto('Telefone', txtfone, Icons.phone_android_outlined),
            const SizedBox(height: 40),
            campoTexto('Email', txtemail, Icons.mail_outline_outlined),
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
                        FirebaseFirestore.instance.collection('Fornecedores').add(
                          {
                            "nome": txtNome.text,
                            "cnpj": txtCnpj.text,
                            "inscricão estadual": txtinscricao.text,
                            "telefone": txtfone.text,
                            "email": txtemail.text,
                          },
                        );
                        sucesso(context, 'O fornecedor foi adicionado com sucesso.');
                      } else {
                        //Alterar um documento
                        FirebaseFirestore.instance
                            .collection('Fornecedores')
                            .doc(id.toString())
                            .set(
                          {
                            "nome": txtNome.text,
                            "cnpj": txtCnpj.text,
                            "inscricão estadual": txtinscricao.text,
                            "telefone": txtfone.text,
                            "email": txtemail.text,
                          },
                        );
                        sucesso(context, 'O fornecedor foi alterado com sucesso.');
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
