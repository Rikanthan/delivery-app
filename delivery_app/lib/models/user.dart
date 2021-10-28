class Users {
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        username: json['username'] as String,
        password: json['password'] as String,
    
    );    
  }
  Users(
      {
        this.username,
        this.password
      });
 String? username;
 String? password;
}