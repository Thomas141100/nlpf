class Filter {
  Map<String, dynamic> parameters = {};

  Filter();

  void addCompanyName(dynamic companyName) =>
      parameters.addEntries([MapEntry("company", companyName)]);

  void addJobTitle(String jobTitle) =>
      parameters.addEntries([MapEntry("title", jobTitle)]);

  void addTag(String tag) {
    if (parameters.containsKey("tags")) {
      parameters.update("tags", (value) => value += ",$tag");
    } else {
      parameters.addEntries([MapEntry("tags", tag)]);
    }
  }

  @override
  String toString() {
    return parameters.toString();
  }
}
