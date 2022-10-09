import 'package:fht_linkedin/components/custom_text_field.dart';
import 'package:fht_linkedin/utils/filters.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search(String s, {super.key = const ValueKey("search")});

  @override
  State<Search> createState() => _Search();
}

class _Search extends State<Search> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();

  _MyFormState() {
    selectedValue = filters[0];
  }

  void searchHandle() {
    Filter filter = Filter();
    if (_titleController.text != "") filter.addJobTitle(_titleController.text);
    if (_companyController.text != "") {
      filter.addCompanyName(_companyController.text);
    }
    if (_tagsController.text != "") filter.addTag(_tagsController.text);
    print(filter);
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
          Column(
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
                  textController: _titleController,
                  input: "Emploi",
                  icon: const Icon(Icons.search,
                      color: Color.fromARGB(255, 124, 62, 102))),
              CustomTextField(
                  textController: _companyController,
                  input: "Entreprise",
                  icon: const Icon(Icons.cases,
                      color: Color.fromARGB(255, 124, 62, 102))),
              CustomTextField(
                  textController: _adresseController,
                  input: "Lieu",
                  icon: const Icon(Icons.location_on,
                      color: Color.fromARGB(255, 124, 62, 102))),
              CustomTextField(
                  textController: _tagsController,
                  input: "Tags",
                  icon: const Icon(Icons.tag,
                      color: Color.fromARGB(255, 124, 62, 102))),
              Container(
                height: 50,
                margin: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () => {searchHandle()},
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
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: DropdownButton(
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
                  isExpanded: true,
                  dropdownColor: const Color.fromARGB(255, 242, 235, 233),
                  iconEnabledColor: const Color.fromARGB(255, 124, 62, 102),
                  underline: Container(
                      height: 1,
                      color: const Color.fromARGB(240, 124, 62, 102)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
