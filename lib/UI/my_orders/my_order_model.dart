class ModelMyOrders {
  int id;
  String orderCode;
  List<Products> items;
  String vat;
  String shipping;
  String totla;
  String status;
  BankPayOption payOption;
  String payStatus;
  dynamic houseNumber;
  dynamic address;
  String note;
  String rate;
  dynamic rateNote;

  ModelMyOrders(
      {required this.id,
      required this.orderCode,
      required this.items,
      required this.vat,
      required this.shipping,
      required this.totla,
      required this.status,
      required this.payOption,
      required this.payStatus,
      required this.note,
      required this.rate,
      required this.rateNote,
      required this.houseNumber,
      required this.address,
      });
}

class Products {
  int quantity;
  int price;
  int discount;
  String name;
  List<ProductOption> options;
  String photo;
  String weight;
  String chopping;
  String note;
  Products({
    required this.quantity,
    required this.price,
    required this.discount,
    required this.name,
    required this.options,
    required this.photo,
    required this.weight,
    required this.chopping,
    required this.note,
  });
}

class ProductOption {
  int id;
  int price;
  String title;

  ProductOption({
    required this.id,
    required this.price,
    required this.title,
  });
}

class BankPayOption {
   int id;
   String name;
   String logo;
   String serviceName;
   String ibanNumber;
   String number;
   String branchNumber;
   String branchCountry;

  BankPayOption({
    required this.id,
    required this.name,
    required this.logo,
    required this.serviceName,
    required this.ibanNumber,
    required this.number,
    required this.branchNumber,
    required this.branchCountry,
  });
}
