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

  final filters = ["Le plus récent", "Le plus recherché", "Le moins recherché"];
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
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
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
                  height: 50,
                  margin: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 242, 235, 233),
                      backgroundColor: const Color.fromARGB(255, 124, 62, 102),
                    ),
                    child: const Text('Rechercher'),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
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
                  dropdownColor: const Color.fromARGB(255, 242, 235, 233),
                  iconEnabledColor: const Color.fromARGB(255, 124, 62, 102),
                  underline: Container(
                      height: 1,
                      color: const Color.fromARGB(240, 124, 62, 102)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
