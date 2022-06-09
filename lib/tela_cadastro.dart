import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widgets/mensagem.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({Key? key}) : super(key: key);

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  //Declaração de atributos que serão utilizados
  //para receber os dados que o usuário digitar
  //no campo de texto
  var txtnome = TextEditingController();
  var txtcpf = TextEditingController();
  var txtemail = TextEditingController();
  var txtsenha = TextEditingController();
  var txtfone = TextEditingController();
  var txtcelular = TextEditingController();


  //Declaração do atributo que identifica
  //unicamente o formulário
  var f1 = GlobalKey<FormState>();

  @override
  void initState() {
    //definir o valor inicial da variável
    //txtSenha.text = '123456';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //BARRA TÍTULO
      appBar: AppBar(
        title: const Text('Cadastro de usuários'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 218, 36, 23),
      ),
      backgroundColor: Colors.grey.shade100,
      //BODY
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/imagens/logo.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: null,
          ),
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                  //identificador do form
                  key: f1,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.people_alt,
                        size: 100,
                        color: Color.fromARGB(255, 218, 36, 23),
                      ),
                      campoTexto('Nome', 'Informe nome completo', txtnome),
                      const SizedBox(height: 10),
                      campoTexto('CPF', 'Informe CPF', txtcpf),
                      const SizedBox(height: 10),
                      const SizedBox(height: 30),
                      campoTexto('E-mail', 'Informe o e-mail', txtemail),
                      const SizedBox(height: 30),
                      campoTexto('Senha', 'Informe a senha', txtsenha),
                      const SizedBox(height: 30),
                      
                      Row(
                        children: [
                          Expanded(
                            child: campoTexto(
                                'Telefone', 'Informe o telefone', txtfone),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: campoTexto(
                              'Celular',
                              'Informe o Celular',
                              txtcelular,
                            ),
                          ),
                        ],
                      ),
                    
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Voltar'),
                      ),
                      const SizedBox(height: 30),
                      botao('Cadastrar'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //
  // CAMPO DE TEXTO
  //
  campoTexto(rotulo, dica, variavel) {
    return TextFormField(
      //associar a variável que receberá o valor
      //digitado no campo de texto
      controller: variavel,
      //habilitar o teclado numérico
      keyboardType: TextInputType.number,
      //campo de senha
      obscureText: false,
      //número de caracteres
      maxLength: 30,
      //definir o campo de texto somente leitura
      //readOnly: true,

      decoration: InputDecoration(
        //fillColor: Colors.white,
        //filled: true,
        labelText: rotulo,
        labelStyle: const TextStyle(
          fontSize: 22,
          color: Color.fromARGB(255, 218, 36, 23),
        ),
        hintText: dica,
        hintStyle: const TextStyle(
          fontSize: 22,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),

      //
      // Validação dos Dados
      //
      validator: (value) {
        /*value = value!.replaceFirst(',', '.');
        if (double.tryParse(value) == null) {
          return 'Digite os dados validos';
        }*/
        return null;
      },
    );
  }

  //
  // BOTÃO
  //
  botao(rotulo) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        //Evento que ocorrerá quando o usuário acionar
        //o botão
        onPressed: () {
          if (f1.currentState!.validate()) {
            criarConta(txtnome.text, txtemail.text, txtsenha.text);

            /*
            
  var txtcpf = TextEditingController();
  var txtsexo = TextEditingController();
  var txtnascimento = TextEditingController();
    var txtfone = TextEditingController();
  var txtcelular = TextEditingController();
  var txtendereco = TextEditingController();
  var txtnumero = TextEditingController();
  var txtcomplemento = TextEditingController();
  var txtbairro = TextEditingController();
  var txtcidade = TextEditingController();
  var txtcep = TextEditingController();
  var txtuf = TextEditingController();
  */

          }
        },
        child: Text(
          rotulo,
          style: const TextStyle(fontSize: 22),
        ),
        style:
            ElevatedButton.styleFrom(primary: Color.fromARGB(255, 218, 36, 23)),
      ),
    );
  }

  //
  // CAIXA DE DIÁLOGO
  //
  caixaDialogo(msg) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(msg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Sair')),
            ],
          );
        });
  }

  void criarConta(nome, email, senha) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((res) {

          FirebaseFirestore.instance.collection('usuarios').add(
            {
              "uid" : res.user!.uid.toString(),
              "nome" : nome,
            }
          );

      //TUDO CERTO!!
      sucesso(context, 'Usuário criado com sucesso!');
      Navigator.pop(context);
    }).catchError((e) {
      switch (e.code) {
        case 'invalid-email':
          erro(context, 'O formato do email é inválido.');
          break;
        case 'email-already-in-use':
          erro(context, 'O email já foi cadastrado.');
          break;
        default:
          erro(context, e.code.toString());
      }
    });
  }
}
