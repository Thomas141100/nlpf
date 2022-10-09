class Filter {
  String _companyName = "";
  String _jobTitle = "";
  final List<String> _tags = [];

  Filter();

  void addCompanyName(String companyName) => _companyName = companyName;

  void addJobTitle(String jobTitle) => _jobTitle = jobTitle;

  void addTag(String tag) => _tags.add(tag);

  @override
  String toString() {
    String queryString = "?";
    List<String> queryStrings = [];
    if (_companyName != "") queryStrings.add("company=$_companyName");
    if (_jobTitle != "") queryStrings.add("title=$_companyName");
    if (_tags.isNotEmpty) queryStrings.add("tags=${_tags.join(',')}");

    queryString += queryStrings.join("&");
    return queryString;
  }
}
