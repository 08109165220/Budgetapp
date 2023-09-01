import 'package:budget_m/Failure_model.dart';
import 'package:budget_m/budget_respository.dart';
import 'package:budget_m/spending_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'item_model.dart';
class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}
late Future <List<Item>> _futureItems;
@override
void initState(){

  _futureItems=BudgetRespository().getItems();
  // Add code after super
  }

class _BudgetScreenState extends State<BudgetScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:Text("budget Tracker") ,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: ()async {
_futureItems=BudgetRespository().getItems();
setState(() {

});
        },
        child: FutureBuilder <List<Item>>(
          future: _futureItems,
            builder: (context, snapshot) {
              if(snapshot.hasData){
             final items =snapshot.data!;
             return ListView.builder(
               itemCount: items.length + 1,
                 itemBuilder: (context, index) {
                 if(index==0) return spendingchart(items: items,);
                  final item=items[index -1];
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        width: 2.0,
                        color: getCategoryColor(item.category)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 6.0,
                        )
                      ]
                    ),
                    child:ListTile(
                      title: Text(item.name),
                      subtitle: Text("${item.category}.${DateFormat.yMd().format(item.date)}"),
                      trailing: Text("-\$${item.price.toStringAsFixed(2)}"),
                    ),
                  );
                 },);
              }else if(snapshot.hasError){
                final failure=snapshot.error as Failure;
                return Center(child:Text(failure.message) );
              }
              return Center(child: CircularProgressIndicator(),);
            },),
      ),
    );
  }

}
Color getCategoryColor (String category){
  switch (category){
   case "Entertainment":
    return Colors.red[400]!;
    case "Food":
      return Colors.green[400]!;
    case "personal":
      return Colors.blue[400]!;
    case "Transportation":
      return Colors.purple[400]!;
    default:
      return Colors.orange[400]!;
  }
}