import 'package:flutter/material.dart';
import 'package:impedancia_calculator/Componentes/lateral.dart';

class calculadora_ohms extends StatefulWidget {
  const calculadora_ohms({super.key});

  @override
  State<calculadora_ohms> createState() => _calculadora_ohmsState();
}

class _calculadora_ohmsState extends State<calculadora_ohms> {
  double calculo = 0;

  List<double> ValorOhms =
      []; // Lista para almacenar los valores de las resistencias
  TextEditingController controller =
      TextEditingController(); // Controlador para el campo de texto

  void _addResistor() {
    setState(() {
      double value = double.tryParse(controller.text) ?? 0.0;
      if (value > 0) {
        ValorOhms.add(value); // Agregar el valor a la lista
        controller.clear(); // Limpiar el campo de texto
      }
    });
  }

  void _calculateEquivalentResistance() {
    if (ValorOhms.isNotEmpty) {
      // Calcular la suma de los inversos de las resistencias
      double sumOfInverseResistances =
          ValorOhms.map((resistance) => 1 / resistance).reduce((a, b) => a + b);

      // Calcular la resistencia equivalente en paralelo
      double equivalentResistance = 1 / sumOfInverseResistances;

      calculo = equivalentResistance;
    }
  }

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
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _menu.currentState?.openDrawer();
                      },
                      icon: Icon(Icons.menu))
                ],
              ),
              Container(
                child: Row(
                  children: [
                    Spacer(),
                    Expanded(
                      flex: 5,
                      child: Container(
                        width: 250,
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                              labelText:
                                  'Ingrese el valor de la resistencia (ohms)'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _calculateEquivalentResistance();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _addResistor();
                              _calculateEquivalentResistance();
                            });
                          },
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                    Spacer()
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text('$calculo ohms'),
              ),
              SizedBox(height: 20),
              Text(
                'Resistencias Agregadas:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: ValorOhms.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          'Palante ${index + 1}: ${ValorOhms[index]} ohms'),
                      onTap: () {},
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
