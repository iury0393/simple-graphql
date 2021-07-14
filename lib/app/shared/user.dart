class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String token;

  User({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.password = '',
    this.token = '',
  });
}

class UserLogin {
  final String email;
  final String password;

  UserLogin({required this.email, required this.password});
}
