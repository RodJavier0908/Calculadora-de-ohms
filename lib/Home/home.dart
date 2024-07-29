import 'package:flutter/material.dart';
import 'package:impedancia_calculator/Componentes/Modulos%20y%20calculos.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ModulosyCalculos(),
          flex: 2,
        )
      ],
    );
  }
}
