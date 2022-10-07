import 'package:mongo_dart/mongo_dart.dart';

class User {
  User();

  late ObjectId? id;
  late String? mail;
  late String? password;
  late bool? isCompany;
  late int? creationDate;
  late List<ObjectId>? candidacies;

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'mail': mail,
      'password': password,
      'isCompany': isCompany,
      'creationDate': creationDate,
      'candidacies': candidacies,
    };
  }
}
