//import 'dart:io';
//
//import 'package:alkhalafsheep/models/cart_product_model.dart';
//import 'package:path/path.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:sqflite/sqflite.dart';
//
//// database table and column names
//final String tableCart = 'cart';
//final String columnId = '_id';
//final String columnProductId = 'productId';
//final String columnWeight = 'weight';
//final String columnPrice = 'price';
//final String columnDiscount = 'discount';
//final String columnQuantity = 'quantity';
//final String columnName = 'name';
//final String columnContent = 'content';
//final String columnOptions = 'options';
//final String columnOptionsStrings = 'optionsString';
//final String columnImage = 'image';
//
//dynamic photo;
//
//// data model class
//class ProductDb {
//  int id;
//  int productId;
//  String weight;
//  int price;
//  int discount;
//  int quantity;
//  String name;
//  String content;
//  String options;
//  String optionsString;
//  String image;
//
//  ProductDb();
//
//  // convenience constructor to create a Word object
//  ProductDb.fromMap(Map<String, dynamic> map) {
//    id = map[columnId];
//    productId = map[columnProductId];
//    weight = map[columnWeight];
//    price = map[columnPrice];
//    discount = map[columnDiscount];
//    quantity = map[columnQuantity];
//    name = map[columnName];
//    content = map[columnContent];
//    options = map[columnOptions];
//    optionsString = map[columnOptionsStrings];
//    image = map[columnImage];
//  }
//
//  // convenience method to create a Map from this Word object
//  Map<String, dynamic> toMap() {
//    var map = <String, dynamic>{
//      columnProductId: productId,
//      columnWeight: weight,
//      columnPrice: price,
//      columnDiscount: discount,
//      columnQuantity: quantity,
//      columnName: name,
//      columnContent: content,
//      columnOptions: options,
//      columnOptionsStrings: optionsString,
//      columnImage: image,
//    };
//    if (id != null) {
//      map[columnId] = id;
//    }
//    return map;
//  }
//}
//
//// singleton class to manage the database
//class DatabaseHelper {
//  // This is the actual database filename that is saved in the docs directory.
//  static final _databaseName = "nagd.db";
//
//  // Increment this version when you need to change the schema.
//  static final _databaseVersion = 2;
//
//  // Make this a singleton class.
//  DatabaseHelper._privateConstructor();
//
//  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//
//  // Only allow a single open connection to the database.
//  static Database _database;
//
//  Future<Database> get database async {
//    if (_database != null) return _database;
//    _database = await _initDatabase();
//    return _database;
//  }
//
//  // open the database
//  _initDatabase() async {
//    // The path_provider plugin gets the right directory for Android or iOS.
//    Directory documentsDirectory = await getApplicationDocumentsDirectory();
//    String path = join(documentsDirectory.path, _databaseName);
//    // Open the database. Can also add an onUpdate callback parameter.
//    return await openDatabase(path,
//        version: _databaseVersion, onCreate: _onCreate);
//  }
//
//  // SQL string to create the database
//  Future _onCreate(Database db, int version) async {
//    await db.execute('''
//              create table $tableCart (
//                $columnId integer primary key autoincrement,
//                $columnProductId integer not null,
//                $columnWeight text not null,
//                $columnPrice integer not null,
//                $columnDiscount integer not null,
//                $columnQuantity integer not null,
//                $columnName text not null,
//                $columnContent text not null,
//                $columnOptions text not null,
//                $columnOptionsStrings text not null,
//                $columnImage text not null
// )
//              ''');
//  }
//
//  // Database helper methods:
//
//  Future<int> insert(ProductDb productDb) async {
//    Database db = await database;
//    int id = await db.insert(tableCart, productDb.toMap());
//    return id;
//  }
//
//  Future<List<ProductDb>> queryReadProducts() async {
//    Database db = await database;
//    List<Map> maps = await db.query(tableCart,
//        columns: [
//          columnId,
//          columnProductId,
//          columnWeight,
//          columnPrice,
//          columnDiscount,
//          columnQuantity,
//          columnName,
//          columnContent,
//          columnOptions,
//          columnOptionsStrings,
//          columnImage
//        ],
//        where: '$columnId > ?',
//        whereArgs: [0]);
///*   where: '$columnId = ?'
//        whereArgs: [id]);*/
//    if (maps.length > 0) {
//      List<ProductDb> list = List();
//      maps.map((e) {
//        list.add(ProductDb.fromMap(e));
//      }).toList();
//      return list;
//    }
//    return null;
//  }
//
//  void delete(CartProductModel productDb) async {
//    Database db = await database;
//    await db.delete(tableCart, where: '_id=?', whereArgs: [productDb.id]);
//  }
//  void deleteAll() async {
//    Database db = await database;
//    await db.delete(tableCart, where: '_id>?', whereArgs: [0]);
//  }
//}
