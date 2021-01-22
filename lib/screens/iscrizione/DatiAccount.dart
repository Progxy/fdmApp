class DatiAccount {
  static Map datiSocio;

  setter(Map dataIscrizione) {
    datiSocio = dataIscrizione;
  }

  resetCredentials() {
    datiSocio = null;
  }
}
