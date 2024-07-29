import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:impedancia_calculator/Componentes/lateral.dart';

class ModulosyCalculos extends StatefulWidget {
  const ModulosyCalculos({super.key});

  @override
  State<ModulosyCalculos> createState() => _ModulosyCalculosState();
}

class _ModulosyCalculosState extends State<ModulosyCalculos> {
  String _indic = '';
  int _selector = 0;
  double _potenciaRMS = 0;
  double? _ohms;
  int _cantidadparalntes = 0;
  int _selectorbuilder = 0;
  final List<double> _opciones = [0.25, 0.50, 1, 2, 4];

  double _ohmsparlantes = 0;
  double _rmsparlante = 0;
  double _resultado_ohms_parlantes = 0;
  double _calculormsparlantes = 0;
  double? _ohmsdelparlante;
  final List<double> _selectroohmsparlantes = [2, 4, 8];
  int _opacidadparapanatalla = 0;
  int _opacidadpararms = 0;
  Icon? Iconcheckrms;
  Color? colorcheckrms;
  // ___funcikones______

  void calculoohmsparlantesx() {
    _resultado_ohms_parlantes = _ohmsparlantes / (_selector + 1);
  }

  void calculo_ohms() {
    if (_ohms == 0.25) {
      _cantidadparalntes = 12;
      _indic = '- 8 parlantes a 2 ohms\n- 12 parlantes de 4 ohms\n';
    }
    if (_ohms == 0.5) {
      _cantidadparalntes = 8;
      _indic = '- 4 parlantes a 2 ohms\n- 8 parlantes de 4 ohms\n';
    }
    if (_ohms == 1) {
      _cantidadparalntes = 8;
      _indic =
          '- 2 parlantes a 2 ohms\n- 4 parlantes de 4 ohms\n- 8 parlntes de 8 ohms';
    }
    if (_ohms == 2) {
      _cantidadparalntes = 4;
      _indic =
          '- 1 parlantes a 2 ohms\n- 2 parlantes de 4 ohms\n- 4 parlantes de 8 ohms';
    }
    if (_ohms == 4) {
      _cantidadparalntes = 2;
      _indic = '- 1 parlantes a 4 ohms\n- 2 parlantes de 8 ohms\n';
    }
    if (_ohms == 8) {
      _cantidadparalntes = 1;
      _indic = '- 1 parlantes a 8 ohms\n';
    }
  }

  void calculormsparalnte() {
    setState(() {
      _calculormsparlantes = (_selector + 1) * _rmsparlante;
    });
  }

  void IconocolorcheckRMS() {
    setState(() {
      if (_rmsparlante > _calculormsparlantes) {
        Iconcheckrms = Icon(Icons.close);
        colorcheckrms = Colors.red;
      }
      if (_rmsparlante < _calculormsparlantes) {
        Iconcheckrms = Icon(Icons.error);
        colorcheckrms = Colors.amber;
      }
      if (_rmsparlante == _calculormsparlantes) {
        Iconcheckrms = Icon(Icons.check);
        colorcheckrms = Colors.green;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _ohms;
    calculo_ohms();
  }

  bool opacidad_seleccion = false;
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _menu = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _menu,
      drawer: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 250),
        child: lateral(),
      ),
      backgroundColor: Color.fromARGB(255, 182, 179, 168),
      body: SafeArea(
          child: OverflowBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _menu.currentState?.openDrawer();
                    },
                    icon: Icon(Icons.menu)),
                Spacer(),
                Text(
                  'Calculo por Modulos',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                ),
                Spacer()
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 320,
                height: 180,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 206, 206, 206),
                    borderRadius: BorderRadius.circular(15)),
                child: Stack(
                  children: [
                    if (_opacidadpararms == 1)
                      Positioned(
                          child: Container(
                        child: Stack(
                          children: [
                            Positioned(
                              child: Container(
                                child: Row(
                                  children: [
                                    Text(
                                      'Rms ${_potenciaRMS.toStringAsFixed(0)}/${_calculormsparlantes.toStringAsFixed(0)}',
                                      style: TextStyle(color: colorcheckrms),
                                    ),
                                  ],
                                ),
                              ),
                              left: 200,
                            ),
                          ],
                        ),
                      )),
                    if (_opacidadparapanatalla == 1)
                      Positioned(
                          child: Container(
                        child: Stack(
                          children: [
                            Positioned(
                              child: Text(
                                  (opacidad_seleccion == true)
                                      ? 'Cantidad de Parlantes ${_selector + 1}'
                                      : '',
                                  style: TextStyle(fontSize: 16)),
                              top: 140,
                              left: 10,
                            ),
                            Positioned(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _selector + 1,
                                itemBuilder: (context, index) {
                                  return Container(
                                      width: 40,
                                      child: Row(
                                        children: [
                                          Icon(Icons.speaker_outlined),
                                          Text('${index + 1}')
                                        ],
                                      ));
                                },
                              ),
                            ),
                            Positioned(
                              child: Text(_resultado_ohms_parlantes == 1.000 ||
                                      _resultado_ohms_parlantes == 2.0000 ||
                                      _resultado_ohms_parlantes == 4.0000
                                  ? 'Ohms: ${_resultado_ohms_parlantes.toStringAsFixed(0)}'
                                  : 'Ohms: ${_resultado_ohms_parlantes.toStringAsFixed(4)}'),
                              top: 170,
                              left: 10,
                            ),
                          ],
                        ),
                      ))
                  ],
                ),
              ),
            ),
            //
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 170,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color.fromARGB(255, 206, 206, 206),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text('Tipo de Modulo?'),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: Column(
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                      labelText: 'Potencia (RMS)',
                                      border: UnderlineInputBorder()),
                                  onChanged: (value) {
                                    setState(() {
                                      _potenciaRMS =
                                          double.tryParse(value) ?? 0;
                                      _opacidadpararms = 1;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DropdownButtonFormField<double>(
                                  decoration: InputDecoration(
                                    labelText: 'Seleccione el valor de ohms',
                                    border: UnderlineInputBorder(),
                                  ),
                                  value: _ohms,
                                  onChanged: (double? newValue) {
                                    setState(() {
                                      opacidad_seleccion = true;
                                      _opacidadparapanatalla = 1;
                                      _ohms = newValue;
                                      calculo_ohms();
                                    });
                                  },
                                  items: _opciones
                                      .map<DropdownMenuItem<double>>(
                                          (double value) {
                                    return DropdownMenuItem<double>(
                                      value: value,
                                      child: Text(value == 0.25 || value == 0.5
                                          ? value.toString()
                                          : value.toStringAsFixed(0)),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 170,
                    height: 180,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 206, 206, 206),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Recomendación',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '${_indic}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_selectorbuilder == 0)
              Expanded(
                  flex: 1,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 206, 206, 206),
                        borderRadius: BorderRadius.circular(15)),
                    child: ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      itemCount: _cantidadparalntes,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 100.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selector = index;

                                _selectorbuilder = 1;
                                calculoohmsparlantesx();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Parlantes ${index + 1} ${_selector == index ? "✔️" : "✖️"}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ))
            else
              Expanded(
                flex: 1,
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 206, 206, 206),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _selectorbuilder = 0;
                            });
                          },
                          child: Text('cambiar cantidad de parlante')),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            DropdownButtonFormField<double>(
                              decoration: InputDecoration(
                                labelText: 'ohms de cada parlante',
                                border: UnderlineInputBorder(),
                              ),
                              value: _ohmsdelparlante,
                              onChanged: (double? newValue) {
                                setState(() {
                                  _ohmsdelparlante = newValue;
                                  calculoohmsparlantesx();
                                });
                              },
                              items: _selectroohmsparlantes
                                  .map<DropdownMenuItem<double>>(
                                      (double value) {
                                return DropdownMenuItem<double>(
                                  value: value,
                                  onTap: () {
                                    setState(() {
                                      _ohmsparlantes = value;
                                    });
                                  },
                                  child: Text(value.toStringAsFixed(0)),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  labelText: 'Rms de cada Parlante'),
                              onChanged: (value) {
                                setState(() {
                                  _rmsparlante = double.tryParse(value) ?? 0;
                                  calculormsparalnte();
                                });
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
    );
  }
}
