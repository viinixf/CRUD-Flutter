import 'dart:convert';

//Atributos da entidade que representam os atributos da API
class Cliente {
  int? id;
  String? nome;
  int? idade;
  String? cpf;
  String? telefone;

  Cliente({
    this.id,
    this.nome,
    this.idade,
    this.cpf,
    this.telefone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'idade': idade,
      'cpf': cpf,
      'telefone': telefone,
    };
  }

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'] as int,
      nome: json['nome'] as String,
      idade: json['idade'] as int,
      cpf: json['cpf'] as String,
      telefone: json['telefone'] as String,
    );
  }
  @override
  String toString() {
    return 'Cliente(id: $id, nome: $nome, idade: $idade, cpf: $cpf, telefone: $telefone)';
  }

  Cliente copyWith({
    int? id,
    String? nome,
    int? idade,
    String? cpf,
    String? telefone,
  }) {
    return Cliente(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      idade: idade ?? this.idade,
      cpf: cpf ?? this.cpf,
      telefone: telefone ?? this.telefone,
    );
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['nome'] != null ? map['nome'] as String : null,
      idade: map['idade'] != null ? map['idade'] as int : null,
      cpf: map['cpf'] != null ? map['cpf'] as String : null,
      telefone: map['telefone'] != null ? map['telefone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(covariant Cliente other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.idade == idade &&
        other.cpf == cpf &&
        other.telefone == telefone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        idade.hashCode ^
        cpf.hashCode ^
        telefone.hashCode;
  }
}
