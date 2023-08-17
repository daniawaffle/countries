class CategoriesModel {
  List<Category>? categoryData;
  String? message;

  CategoriesModel({this.categoryData, this.message});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      categoryData = <Category>[];
      json['data'].forEach((v) {
        categoryData!.add(Category.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> categoriesModel = <String, dynamic>{};
    if (categoryData != null) {
      categoriesModel['data'] = categoryData!.map((v) => v.toJson()).toList();
    }
    categoriesModel['message'] = message;
    return categoriesModel;
  }
}

class Category {
  int? id;
  String? name;
  String? icon;

  Category({this.id, this.name, this.icon});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    return data;
  }
}
