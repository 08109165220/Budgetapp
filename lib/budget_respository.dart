

import 'dart:convert';

import 'Failure_model.dart';
import 'item_model.dart';
import 'package:http/http.dart';
class BudgetRespository{
  final http.Client _client;
  BudgetRespository({http.Client? client}): _client =client ?? http.Client();

  void dispose(){
    _client.close;
  }

  Future <List<Item>>getItems() async{
try {
  final url=
      "${_baseurl}databases/${dotenv.env["NOTATION_DATABASE_ID"]}/query";
  final response = await _client.post(
    Uri.parse(url),
    headers:{

    }
  );
  if(response.statuscode==200){
    final data =jsonDecode(response.body) as Map<String ,dynamic>;
    return (data["result"] as List).map((e) => Item.fromMap(e)).toList()
        ..sort((a, b) => b.date.compareTo(a.date));
  }else{
    throw const Failure(message:"Something went wrong");
  }
} on Exception catch (e) {
  throw const Failure(message:"Something went wrong");

  // TODO
}
}
}

