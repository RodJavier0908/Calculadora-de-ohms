import 'package:flutter/material.dart';
import 'package:impedancia_calculator/Componentes/Calduladora%20de%20ohms.dart';
import 'package:impedancia_calculator/Componentes/Modulos%20y%20calculos.dart';

class lateral extends StatelessWidget {
  const lateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Menu',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ModulosyCalculos(),
              ));
            },
            child: Card(
              child: ListTile(
                title: Text('Calculadora de Modulos'),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => calculadora_ohms(),
              ));
            },
            child: Card(
              child: ListTile(
                title: Text('Calculadora de Impedancia'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
