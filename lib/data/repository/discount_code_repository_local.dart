// import 'dart:async';
// import 'dart:developer';
//
// import 'package:pizza_app/data/domain/pizza.dart';
// import 'package:pizza_app/data/domain/pizza_create_request.dart';
// import 'package:pizza_app/data/repository/pizza_repository.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class PizzaRepositoryLocal extends PizzaRepository {
//   late Database database;
//   final String _tableName = "pizza";
//
//   PizzaRepositoryLocal() {
//     _initDatabase();
//   }
//
//   Future<void> _initDatabase() async {
//     database = await openDatabase(
//       // Set the path to the database. Note: Using the `join` function from the
//       // `path` package is best practice to ensure the path is correctly
//       // constructed for each platform.
//       join(await getDatabasesPath(), 'discount_code_database.db'),
//       // When the database is first created, create a table to store dogs.
//       onCreate: (db, version) {
//         // Run the CREATE TABLE statement on the database.
//         return db.execute(
//           'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, ingredients TEXT,'
//           ' webSite TEXT, siteType TEXT, expirationDate TEXT, creator TEXT)',
//         );
//       },
//       // Set the version. This executes the onCreate function and provides a
//       // path to perform database upgrades and downgrades.
//       version: 1,
//     );
//
//     super.databaseInitialized.complete();
//   }
//
//   @override
//   Future<Pizza> addPizza(PizzaCreateRequest request) async {
//     Pizza code = Pizza(
//         id: 0,
//         title: request.code,
//         description: request.description,
//         ingredients: request.webSite,
//         siteType: request.siteType,
//         expirationDate: request.expirationDate,
//         creator: request.creator);
//
//     int savedId = await database.insert(_tableName, code.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//
//     return Pizza.fromMap((await database
//             .query(_tableName, where: "id = ?", whereArgs: [savedId]))
//         .first);
//   }
//
//   @override
//   Future<void> deletePizza(Pizza discountCode) async {
//     await database
//         .delete(_tableName, where: "id=?", whereArgs: [discountCode.id]);
//   }
//
//   @override
//   Future<Pizza?> getPizza(String discountId) async {
//     try {
//       return Pizza.fromMap((await database
//               .query(_tableName, where: "id = ?", whereArgs: [discountId]))
//           .first);
//     } catch (e) {
//       log(e.toString());
//       return null;
//     }
//   }
//
//   @override
//   Future<List<Pizza>> getPizzas() async {
//     final List<Map<String, dynamic>> maps = await database.query(_tableName);
//
//     return List.generate(maps.length, (i) {
//       return Pizza.fromMap(maps[i]);
//     });
//   }
//
//   @override
//   Future<Pizza?> updatePizza(Pizza discountCode) async {
//     try {
//       await database.update(
//         _tableName,
//         discountCode.toMap(),
//         where: 'id = ?',
//         whereArgs: [discountCode.id],
//       );
//
//       return discountCode;
//     } catch (e) {
//       log(e.toString());
//       return null;
//     }
//   }
// }
