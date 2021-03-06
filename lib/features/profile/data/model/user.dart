import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:crossfit_kabod_app/features/profile/data/model/user_field.dart';

class UserModel extends DatabaseItem {
  String id;
  String name;
  String phone;
  bool admin;
  String email;
  String address;
  DateTime lastLoggedIn;
  DateTime registrationDate;
  String photoUrl;
  int buildNumber;
  bool introSeen;

  UserModel(
      {this.id,
      this.name,
      this.admin,
      this.phone,
      this.email,
      this.address,
      this.lastLoggedIn,
      this.registrationDate,
      this.photoUrl,
      this.introSeen,
      this.buildNumber})
      : super(id);

  UserModel.fromDS(String id, Map<String, dynamic> data)
      : id = id,
        name = data[UserFields.name],
        admin = data[UserFields.admin],
        phone = data[UserFields.phone],
        address = data[UserFields.address],
        email = data[UserFields.email],
        lastLoggedIn = data[UserFields.lastLoggedIn]?.toDate(),
        registrationDate = data[UserFields.registrationDate]?.toDate(),
        photoUrl = data[UserFields.photoUrl],
        buildNumber = data[UserFields.buildNumber],
        introSeen = data[UserFields.introSeen],
        super(id);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[UserFields.id] = id;
    data[UserFields.name] = name;
    data[UserFields.admin] = admin;
    data[UserFields.phone] = phone;
    data[UserFields.address] = address;
    data[UserFields.email] = email;
    data[UserFields.lastLoggedIn] = lastLoggedIn;
    data[UserFields.registrationDate] = registrationDate;
    data[UserFields.photoUrl] = photoUrl;
    data[UserFields.buildNumber] = buildNumber;
    data[UserFields.introSeen] = introSeen;
    return data;
  }
}
