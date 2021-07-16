class Users {
  List<User>? data;
  String error;

  Users({this.data, this.error = ''});

  Users.fromJson(List<dynamic> jsonList)
      : data = jsonList.map((e) => User.fromJson(e)).toList(),
        error = '';

  Users.withError(String errorValue)
      : data = [],
        error = errorValue;
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String createdAt;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        createdAt = json['created_at'];
}
