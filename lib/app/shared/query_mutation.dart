class QueryMutation {
  String login() {
    return """
      mutation(\$email: String!, \$password: String!){
        login(email: \$email, password: \$password){
          token
        }
      }
    """;
  }

  String register() {
    return """
      mutation(\$input: NewUser!){
        createUser(input: \$input){
          id,
          firstName,
          lastName,
          email
        }
      }
""";
  }
}
