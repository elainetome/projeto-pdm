import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'widgets/mensagem.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({Key? key}) : super(key: key);

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  var produtos;
  @override
  void initState() {
    super.initState();
    produtos = FirebaseFirestore.instance.collection('produtos');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Produtos'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 218, 36, 23),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, 'fornecedores');
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'login', (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade100,
      body: Container(
        padding: const EdgeInsets.all(50),

        //
        // EXIBIR os documentos da coleção
        //
        child: StreamBuilder<QuerySnapshot>(
          //fonte de dados
          stream: produtos.snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(child: Text('Não foi possível conectar.'));
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                final dados = snapshot.requireData;
                return ListView.builder(
                  itemCount: dados.size,
                  itemBuilder: (context, index) {
                    return exibirDocumento(dados.docs[index]);
                  },
                );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'inserir');
        },
      ),
    );
  }

  exibirDocumento(item) {
    String nome = item.data()['nome'];
    String preco = item.data()['preco'];

    return ListTile(
        title: Text(nome),
        subtitle: Text(preco),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () {
            produtos.doc(item.id).delete();
            sucesso(context, 'O documento foi apagado com sucesso');
          },
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            'inserir',
            arguments: item.id,
          );
        });
  }
}
