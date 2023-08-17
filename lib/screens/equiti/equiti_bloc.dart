import 'dart:async';

import 'package:dio/dio.dart';

import '../../constants.dart';
import '../../locater.dart';
import '../../models/categories_model.dart';
import '../../services/api.dart';
import '../../services/hive.dart';

class EquitiAcademyBloc {
  StreamController<List<Category>> categoriesStreamController =
      StreamController<List<Category>>();

  String? language = locator<HiveService>()
          .getValue(boxName: languageHiveBox, key: languageHiveKey) ??
      "en";
  List<Category> categories = [];

  Future<List<Category>> getCategories() async {
    final response = await locator<ApiService>().apiRequest(
      path: "categories",
      method: getMethod,
      options: Options(
        headers: {'lang': language},
      ),
    );

    CategoriesModel categoriesModel = CategoriesModel.fromJson(response);
    if (categoriesModel.categoryData != null) {
      categories = categoriesModel.categoryData!;
    }
    categoriesStreamController.sink.add(categories);
    return categories;
  }
}
