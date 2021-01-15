class DatiAccount {
  static Map datiSocio;

  setter(Map dataIscrizione) {
    datiSocio = dataIscrizione;
    print(datiSocio);
  }

  resetCredentials() {
    datiSocio = null;
    print(datiSocio);
  }
}
