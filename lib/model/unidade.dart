class Unidade {
  int id;
  String nome;
  String sigla;
  String ip;
  String portaTomcat;
  String portaJboss;

  Unidade.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        nome = json['nome'],
        sigla = json['sigla'],
        ip = json['ip'],
        portaTomcat = json['portaTomcat'],
        portaJboss = json['portaJboss'];

  @override
  String toString() {
    return 'Unidade{id: $id, nome: $nome, sigla: $sigla, ip: $ip, portaTomcat: $portaTomcat, portaJboss: $portaJboss}';
  }
}
