import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String fName;
  String lName;

  DocumentReference reference;

  UserModel({this.id,this.fName,this.lName});

  /*factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    UserModel newUser = UserModel.fromJson(snapshot.data);
    newUser.reference = snapshot.reference;
    return newUser;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => _UserFromJson(json);*/

  Map<String, dynamic> toJson() => _UserToJson(this);

  @override
  String toString() => "User<$id>";

  Map<String,dynamic> _UserToJson(UserModel instance) => <String, dynamic> {
    'id' : instance.id,
    'fName' : instance.fName,
    'lName' : instance.lName,
  };

  UserModel _UserFromJson(Map<String,dynamic> json){
    return UserModel(
        id: json['id'] as String,
        fName : json['fName'] as String,
        lName : json['lName'] as String
    );
  }

}