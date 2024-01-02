import 'package:flutter/foundation.dart';
import 'package:alkhalafsheep/network_models/main_response.dart';


class CartProviderModel with ChangeNotifier {
//   List<Product> _list = List();
//
//   List<ProductModel> get list => _list;
//
//   set list(List<ProductModel> value) {
//     _list = value;
//     notifyListeners();
//   }
//
//   clear() {
//     _list.clear();
//     notifyListeners();
//   }
//
//   remove(ProductModel productModel) {
//     _list.remove(productModel);
//     notifyListeners();
//   }
//
//   void add(
//       ProductModel productModel0,
//       List<int> options,
//       String inputWeightId,
//       String weightName,
//       String inputChoppingId,
//       int inputChoppingPrice,
//       String choppingName,
//       int productPrice,
//       String note) {
//     List<ProductOptions> copyOfOptions = new List();
//     productModel0.productOptions.map((e) {
//       copyOfOptions
//           .add(new ProductOptions(id: e.id, price: e.price, title: e.title));
//     }).toList();
//     ProductModel productModel = new ProductModel(
//       id: productModel0.id,
//       model_number: productModel0.model_number,
//       weight: productModel0.weight,
//       price: productModel0.price,
//       discount: productModel0.discount,
//       quantity: productModel0.quantity,
//       name: productModel0.name,
//       content: productModel0.content,
//       photo: productModel0.photo,
//       productOptions: copyOfOptions,
//       allWeights: productModel0.allWeights,
//     );
//
//     List<ProductOptions> selectedOptions = List();
//
//     if (productModel.productOptions != null) {
//       productModel.productOptions.map((e) {
//         options.map((singleOption) {
//           if (e.id == singleOption) {
//             selectedOptions.add(e);
//             productModel.price += e.price;
//             productPrice += e.price;
//           }
//         }).toList();
//       }).toList();
//       productModel.productOptions.clear();
//       productModel.productOptions.addAll(selectedOptions);
//     }
//     _list.add(new ProductModel(
//       id: productModel.id,
//       model_number: productModel.model_number,
//       weight: productModel.weight,
//       price: productPrice,
//       discount: productModel.discount,
//       quantity: 1,
//       name: productModel.name,
//       content: productModel.content,
//       photo: productModel.photo,
//       productOptions: productModel.productOptions,
//       note: note,
//       selectedWeightId: inputWeightId,
//       selectedChoppingId: inputChoppingId,
//       selectedChoppingPrice: inputChoppingPrice,
//       selectedWeightName: weightName,
//       selectedChoppingName: choppingName,
//       allWeights: productModel.allWeights,
//     ));
//     notifyListeners();
//   }
//
//   void addNoOption(ProductModel productModel0) {
//     ProductModel productModel = ProductModel(
//         id: productModel0.id,
//         model_number: productModel0.model_number,
//         weight: productModel0.weight,
//         price: productModel0.price,
//         discount: productModel0.discount,
//         quantity: productModel0.quantity,
//         name: productModel0.name,
//         content: productModel0.content,
//         photo: productModel0.photo,
//         productOptions: productModel0.productOptions,
//         allWeights:productModel0.allWeights);
//
//     if (productModel.productOptions != null) {
//       productModel.productOptions.clear();
//     }
//     _list.add(new ProductModel(
//         id: productModel.id,
//         model_number: productModel.model_number,
//         weight: productModel.weight,
//         price: productModel.price,
//         discount: productModel.discount,
//         quantity: 1,
//         name: productModel.name,
//         content: productModel.content,
//         photo: productModel.photo,
//         productOptions: productModel.productOptions,
//         allWeights:productModel.allWeights));
//     notifyListeners();
//   }
// }
// class CartProviderModelV2 with ChangeNotifier {
//   List<ProductModelV2> _list = List();
//
//   List<ProductModelV2> get list => _list;
//
//   set list(List<ProductModelV2> value) {
//     _list = value;
//     notifyListeners();
//   }
//
//   clear() {
//     _list.clear();
//     notifyListeners();
//   }
//
//   remove(ProductModel productModel) {
//     _list.remove(productModel);
//     notifyListeners();
//   }
//
//   void add(ProductModelV2 productModel) {
//     list.add(productModel);
//     notifyListeners();
//   }

}
