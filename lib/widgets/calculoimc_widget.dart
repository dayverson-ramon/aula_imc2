import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalculoImcWidget extends StatefulWidget {
  @override
  _CalculoImcWidgetState createState() => _CalculoImcWidgetState();
}

class _CalculoImcWidgetState extends State<CalculoImcWidget> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController alturacontroller = TextEditingController();
  TextEditingController pesocontroller = TextEditingController();
  String _resultadoimc;

  void _calcularimc() {
    double altura = double.parse(alturacontroller.text) / 100.0;
    double peso = double.parse(pesocontroller.text);
    double imc = peso / pow(altura, 2);

    setState(() {
      _resultadoimc = imc.toStringAsFixed(2) + "\n\n" + getClassificao(imc);
    });
  }

  String getClassificao(num imc) {
    String stcclassificacao;
    if (imc < 18.6)
      stcclassificacao = "Abaixo do peso";
    else if (imc < 25.0)
      stcclassificacao = "Peso ideal";
    else if (imc < 30.0)
      stcclassificacao = "Levemente acima do peso";
    else if (imc < 35.0)
      stcclassificacao = "Obesidade gral I";
    else if (imc < 40.0)
      stcclassificacao = "Obesidade gral II";
    else
      stcclassificacao = "Obesidade gral III";
    return stcclassificacao;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: alturacontroller,
                validator: (value) {
                  return value.isEmpty ? "Informe a altura " : null;
                },
                decoration: InputDecoration(labelText: "Altura em cm"),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: pesocontroller,
                validator: (value) {
                  return value.isEmpty ? "Informe o peso" : null;
                },
                decoration: InputDecoration(labelText: "Peso em kg"),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Text(
                _resultadoimc == null ? "" : "IMC: $_resultadoimc",
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState.validate()) {
                      _calcularimc();
                    }
                  },
                  child: Text('Calcular')),
            ),
          ],
        ),
      ),
    );
  }
}
