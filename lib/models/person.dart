class Person {
  final String code;
  final String name;
  final String surname;
  final String fiscalCode;
  final String cellphone;
  final bool isStaff;

  Person({
    required this.code,
    required this.name,
    required this.surname,
    required this.fiscalCode,
    required this.cellphone,
    this.isStaff = false,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      code: json['code'],
      name: json['name'],
      surname: json['surname'],
      fiscalCode: json['fiscalCode'],
      cellphone: json['cellphone'],
      isStaff: json['staff'],
    );
  }
}
