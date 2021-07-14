class QueryMutation {
  String login(String email, String password) {
    return """
      mutation{
        login(email: "$email", password: "$password"){
          token
        }
      }
    """;
  }

  String register(
      String firstName, String lastName, String email, String password) {
    return """
      mutation{
        createUser(input: {
          firstName: "$firstName",
          lastName: "$lastName",
          email: "$email",
          password: "$password"
        }){
          id,
          firstName
        }
      }
""";
  }
}
