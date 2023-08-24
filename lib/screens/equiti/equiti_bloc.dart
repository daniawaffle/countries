import 'dart:async';

import 'package:dio/dio.dart';

import '../../constants.dart';
import '../../locater.dart';
import '../../models/categories_model.dart';
import '../../models/mentor_model.dart';
import '../../services/api.dart';
import '../../services/hive.dart';

class EquitiAcademyBloc {
  StreamController<List<Category>> categoriesStreamController =
      StreamController<List<Category>>();
  StreamController<List<Mentor>> mentorsStreamController =
      StreamController<List<Mentor>>();

  String? language = locator<HiveService>().getValue(
          boxName: AppConstants.hiveBox, key: AppConstants.languageHiveKey) ??
      "en";
  List<Category> categories = [];
  List<Mentor> mentors = [];

  Future<List<Category>> getCategories() async {
    final response = await locator<ApiService>().apiRequest(
      path: "categories",
      method: AppConstants.getMethod,
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

  Future<List<Mentor>> getMentors(int categoryID) async {
    final response = await locator<ApiService>().apiRequest(
      path: "mentor-list",
      method: AppConstants.getMethod,
      options: Options(
        headers: {'lang': language},
      ),
      queryParameters: {"categories_id": categoryID},
    );

    MentorsModel mentorsModel = MentorsModel.fromJson(response);
    if (mentorsModel.mentors != null) {
      mentors = mentorsModel.mentors!;
    }
    mentorsStreamController.sink.add(mentors);
    return mentors;
  }
}
