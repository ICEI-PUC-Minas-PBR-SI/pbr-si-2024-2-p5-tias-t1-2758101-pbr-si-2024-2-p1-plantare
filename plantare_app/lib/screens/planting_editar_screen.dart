import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantare_app/database/database_helper.dart';
import 'package:intl/intl.dart';

class PlantingScreen extends StatefulWidget {
  @override
  _PlantingScreenState createState() => _PlantingScreenState();
}

class _PlantingScreenState extends State<PlantingScreen> {
  List<String> verduras = [];
  String? selectedVerdura;
  String? selectedSoilType;
  String? selectedClimate;

  final FirestoreService firestoreService = FirestoreService();

  TextEditingController dateController = TextEditingController();
  TextEditingController dateColheitaController = TextEditingController();
  TextEditingController observationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchVerduras();
  }

  void fetchVerduras() async {
    List<String> fetchedVerduras = await firestoreService.getVerduras();
    setState(() {
      verduras = fetchedVerduras;
    });
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF04BB86),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF04BB86),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      String formattedDate = "${picked.day}/${picked.month}/${picked.year}";
      controller.text = formattedDate;
    }
  }

  Future<void> savePlanting({
    required String verdura,
    required String dataPlantio,
    required String dataColheita,
    required String tipoSolo,
    required String clima,
    String? observacao,
  }) async {
    try {
      DocumentReference lastIdRef =
          FirebaseFirestore.instance.collection('metadata').doc('lastPlantingId');
      DocumentSnapshot lastIdSnapshot = await lastIdRef.get();

      int newPlantingId;
      if (lastIdSnapshot.exists) {
        newPlantingId = lastIdSnapshot['value'] + 1;
        await lastIdRef.update({'value': newPlantingId});
      } else {
        newPlantingId = 1;
        await lastIdRef.set({'value': newPlantingId});
      }

      await FirebaseFirestore.instance
          .collection('plantios')
          .doc(newPlantingId.toString())
          .set({
        'Verdura': verdura,
        'DataPlantio': dataPlantio,
        'DataColheita': dataColheita,
        'TipoSolo': tipoSolo,
        'Clima': clima,
        'Observacao': observacao ?? '',
        'Timestamp': FieldValue.serverTimestamp(),
      });

      print("Plantio salvo com sucesso! ID: $newPlantingId");
    } catch (e) {
      print("Erro ao salvar plantio: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF04BB86), Color(0xFF225149)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/onboarding_image.png',
                    height: 40,
                    width: 40,
                  ),
                  Text(
                    "PLANTARE",
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(Icons.search, color: Colors.white),
                ],
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.grey),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "EDITAR",
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Form
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedVerdura,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedVerdura = newValue;
                      });
                    },
                    items: verduras.map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Selecione uma verdura',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  TextField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Data do Plantio',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () {
                      _selectDate(context, dateController);
                    },
                  ),
                  SizedBox(height: 16),

                  TextField(
                    controller: dateColheitaController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Data de Colheita',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () {
                      _selectDate(context, dateColheitaController);
                    },
                  ),
                  SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: selectedSoilType,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSoilType = newValue;
                      });
                    },
                    items: [
                      'Latossolos',
                      'Argissolos',
                      'Neossolos',
                      'Cambissolos',
                      'Planossolos',
                      'Gleissolos',
                      'Espodossolos',
                      'Vertissolos',
                    ].map((soilType) {
                      return DropdownMenuItem<String>(
                        value: soilType,
                        child: Text(soilType),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Tipo de solo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: selectedClimate,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedClimate = newValue;
                      });
                    },
                    items: [
                      'Seco',
                      'Úmido',
                      'Chuvoso',
                      'Ensolarado',
                      'Nublado',
                    ].map((climate) {
                      return DropdownMenuItem<String>(
                        value: climate,
                        child: Text(climate),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Qual o clima de hoje?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  TextField(
                    controller: observationController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Adicione uma observação...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                        ),
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [Color(0xFF04BB86), Color(0xFF225149)],
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (selectedVerdura != null &&
                                dateController.text.isNotEmpty &&
                                selectedSoilType != null &&
                                selectedClimate != null) {
                              await savePlanting(
                                verdura: selectedVerdura!,
                                dataPlantio: dateController.text,
                                dataColheita: dateColheitaController.text,
                                tipoSolo: selectedSoilType!,
                                clima: selectedClimate!,
                                observacao: observationController.text,
                              );
                              Navigator.pushNamed(context, '/report');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 32),
                          ),
                          child: Text(
                            'Salvar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF04BB86),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: 'Métricas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/report');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/planting');
          }
        },
      ),
    );
  }
}
