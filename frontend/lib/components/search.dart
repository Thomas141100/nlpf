import 'package:fht_linkedin/components/custom_text_field.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search(String s, {super.key = const ValueKey("search")});

  @override
  State<Search> createState() => _Search();
}

class _Search extends State<Search> {
  _MyFormState() {
    selectedValue = filters[0];
  }

  final filters = ["Le plus récent", "Le plus postulé", "Le moins postulé"];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      color: const Color.fromARGB(255, 242, 235, 233),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            //width: 300,
            padding: const EdgeInsets.all(10),
            /*decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 4),
                borderRadius: BorderRadius.circular(12),
              ),*/
            child: Column(
              children: [
                Container(
                  child: const Text(
                    'Recherche',
                    style: TextStyle(
                        color: Color.fromARGB(255, 124, 62, 102),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                CustomTextField(
                    input: "Emploi",
                    icon: const Icon(Icons.search,
                        color: Color.fromARGB(255, 124, 62, 102))),
                CustomTextField(
                    input: "Entreprise",
                    icon: const Icon(Icons.cases,
                        color: Color.fromARGB(255, 124, 62, 102))),
                CustomTextField(
                    input: "Lieu",
                    icon: const Icon(Icons.location_on,
                        color: Color.fromARGB(255, 124, 62, 102))),
                CustomTextField(
                    input: "Tags",
                    icon: const Icon(Icons.tag,
                        color: Color.fromARGB(255, 124, 62, 102))),
                Container(
                  child: const Text(
                    'Trier par',
                    style: TextStyle(
                        color: Color.fromARGB(255, 124, 62, 102),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                DropdownButton(
                  value: selectedValue,
                  items: filters
                      .map((e) => DropdownMenuItem<String>(
                            key: ValueKey(e),
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
