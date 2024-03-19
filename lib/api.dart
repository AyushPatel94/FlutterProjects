import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Model.dart';


class api{
  String Url = "API LINK";
  Future<List<Model>> getDetails() async {
    http.Response res = await http.get(Uri.parse(Url));
    List<dynamic> mapList =  jsonDecode(res.body) ;
    List<Model> modelList=[];
    for(int i=0;i<mapList.length;i++){
      Model model = Model();
      model.id=mapList[i]["id"];
      model.image=mapList[i]["image"];
      model.name=mapList[i]["name"];
      modelList.add(model);
    }
    return modelList;
  }

  Future<http.Response> deletByid(String id) async => await http.delete(Uri.parse(Url+'/'+id));

  Future<http.Response> insertData(Map<String,dynamic> map) async => await http.post(Uri.parse(Url),headers: {'Content-type': 'application/json'},body: json.encode(map));

  Future<http.Response> updateData (Map<String,dynamic> map,String id) async => await http.put(Uri.parse(Url+'/$id'),headers: {'Content-type': 'application/json'},body: json.encode(map));
}