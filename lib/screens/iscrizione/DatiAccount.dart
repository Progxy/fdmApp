class DatiAccount {
  static String datas;

  setter(String dataIscrizione) {
    datas = dataIscrizione;
    print(datas);
  }

  resetCredentials() {
    datas = null;
    print(datas);
  }
}
