import 'package:fht_linkedin/components/custom_text_field.dart';
import 'package:fht_linkedin/components/tags.dart';
import 'package:fht_linkedin/utils/filters.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  Function({Filter? filters}) searchOffersWithFilters;
  Search(
      {super.key = const ValueKey("search"),
      required this.searchOffersWithFilters});

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
    Filter filters = Filter();
    if (_titleController.text != "") filters.addJobTitle(_titleController.text);
    if (_companyController.text != "") {
      filters.addCompanyName(_companyController.text);
    }
    if (_tagsController.text != "") filters.addTag(_tagsController.text);
    widget.searchOffersWithFilters(filters: filters);
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
               Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Recherche',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              CustomTextField(
                  textController: _titleController,
                  input: "Emploi",
                  icon:  Icon(Icons.search,
                      color: Theme.of(context).primaryColor)),
              CustomTextField(
                  textController: _companyController,
                  input: "Entreprise",
                  icon: Icon(Icons.cases,
                      color:Theme.of(context).primaryColor
                      )),
              CustomTextField(
                  textController: _adresseController,
                  input: "Lieu",
                  icon:  Icon(Icons.location_on,
                      color: Theme.of(context).primaryColor)),
              Tags(textController: _tagsController),
              Container(
                height: 50,
                margin: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () => {searchHandle()},
                  child: const Text('Rechercher'),
                  style: Theme.of(context).elevatedButtonTheme.style,
                ),
              ),
               Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Trier par',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
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
                  dropdownColor: Theme.of(context).backgroundColor,
                  iconEnabledColor: Theme.of(context).primaryColor,
                  underline: Container(
                      height: 1, color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
