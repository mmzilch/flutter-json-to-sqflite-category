import 'dart:convert';
import 'package:flutter_healthy_fitness/database/database_helper.dart';
import 'package:flutter_healthy_fitness/model/category_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider {

  Future<List<Map<String, dynamic>>> getAllCategories() async {
  http.Response response = await http.get('https://healthfitness.khaingthinkyi.me/api/category');
  if (response.statusCode != 200) return null;
  print('apiprocateList>>>>'+List<Map<String, dynamic>>.from(json.decode(response.body)['categories']).toString());
  var list = List<Map<String, dynamic>>.from(json.decode(response.body)['categories']);
  var result = list.map((e){
DatabaseHelper.instance.createFood(Categories.fromJson(e));
  });
  print('apiproresultmap>>'+result.toString());
  return list;
}

}