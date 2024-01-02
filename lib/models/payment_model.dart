class PaymentModel {
  int? id;
  String? name;
  String? logo;
  String? serviceName;
  dynamic ibanNumber;
  String? number;
  String? branchNumber;
  String? branchCountry;

  PaymentModel({
    this.id,
    this.name,
    this.logo,
    this.serviceName,
    this.ibanNumber,
    this.number,
    this.branchNumber,
    this.branchCountry,
  });
}
