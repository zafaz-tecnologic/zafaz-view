class Laudo {
  String texto;

  Laudo.fromJson(Map<String, dynamic> json) : this.texto = json['texto'];
}
