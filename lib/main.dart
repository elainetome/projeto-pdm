import 'package:app04_imc/tela_fornecedores.dart';
import 'package:app04_imc/widgets/inserir_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'tela_cadastro.dart';
import 'tela_login.dart';
import 'tela_principal.dart';
import 'tela_fornecedores.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MAGIC PENCIL',
      initialRoute: 'login',
      routes: {
        'login': (context) => const TelaLogin(),
        'cadastro': (context) => const TelaCadastro(),
        'principal': (context) => const TelaPrincipal(),
        'inserir': (context) => const InserirPage(),
        'fornecedores': (context) => const TelaFornecedoresPage(),
      },
    ),
  );
}
