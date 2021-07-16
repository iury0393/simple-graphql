class QueryMutation {
  String login() {
    return """
    query(\$email: String!, \$password: String!){
      users(
        where: { _and: [
          {email: {_eq: \$email}}, 
          {password: {_eq: \$password}}
        ]}
      ) {
        id
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
