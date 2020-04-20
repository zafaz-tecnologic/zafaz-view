class Unidade {
  int id;
  String nome;
  String sigla;
  String ip;
  String porta;

  Unidade.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'],
        sigla = json['sigla'],
        ip = json['ip'],
        porta = json['porta'];

  @override
  String toString() {
    return 'Unidade{id: $id, nome: $nome, sigla: $sigla, ip: $ip, porta: $porta}';
  }
}
