class ImagenEnviada {
  String imageString;
  String extension;

  ImagenEnviada(this.imageString, this.extension);

  String getImageString() {
    return (imageString);
  }

  String getExtension() {
    return (extension);
  }

  @override
  String toString() {
    return "$imageString; $extension";
  }
}
