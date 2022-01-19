class UserModel {
  final String email;
  final String name;

  UserModel(this.email, this.name);

  UserModel.fromJson(Map<String, dynamic> json)
      : email = json["email"],
        name = json["name"];

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
      };
}
