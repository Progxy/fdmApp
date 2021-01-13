class AccountInfo {
  static String name = "Login";
  static String email = "me@example.com";

  setter(String username, String mail) {
    name = username;
    email = mail;
    print("$name, $email");
  }
}
