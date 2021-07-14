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
      mutation(\$firstName: String!, \$lastName: String!, \$email: String!, \$password: String!){
        createUser(input: {
          firstName: "\$firstName",
          lastName: "\$lastName",
          email: "\$email",
          password: "\$password"
        }){
          id,
          firstName
        }
      }
""";
  }
}
