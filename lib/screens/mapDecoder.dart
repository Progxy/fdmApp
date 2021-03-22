class MapDecoder {
  decoder(String string) {
    final stringer = string.replaceAll("[", "").replaceAll("]", "");
    final list = splitter(stringer);
    List lister = [];
    for (var element in list) {
      final List res = element.split(",");
      Map mapped = {};
      res.forEach((element) {
        final elem = element.trim().split(" ");
        mapped.addAll({elem[0].replaceAll(":", ""): elem[1]});
      });
      mapped.remove("ImagePath");
      mapped.remove("VideoPath");
      mapped.remove("isVideo");
      lister.add(mapped);
    }
    return lister;
  }

  splitter(String string) {
    List result = [];
    List stringer = string.split("");
    String reader = "";
    bool isReadable = false;
    for (var char in stringer) {
      if (char == "{") {
        isReadable = true;
        continue;
      }
      if (char == "}") {
        result.add(reader);
        reader = "";
        isReadable = false;
      } else if (isReadable) {
        reader += char;
      }
    }
    return result;
  }
}
