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
      mutation(\$input: users_insert_input!){
        insert_users_one(object: \$input) 
          {
            id
            firstName
            lastName
            email
            created_at
          }
      }
      """;
  }

  String getUsers() {
    return """
      query(){
        users(){
          id
          firstName
          lastName
          email
          created_at
        }
      }
""";
  }
}
