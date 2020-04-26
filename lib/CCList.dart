import 'package:first/CCData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class CCList extends StatefulWidget{

  // List<CCData> data = [
  //   CCData(name: 'Bitcoin', symbol: 'BTC',  priceUsd: 7000.0),
  //   CCData(name: 'Etherium', symbol: 'ETH',  priceUsd: 700.0),
  // ];

    @override
    State<StatefulWidget> createState(){
        return CCListState ();
    }

  }
  
class CCListState  extends State<CCList>{
  List<CCData> data = [];

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('Awesome CC Tracker'),
        ),
      body: Container(
        child: ListView(
          children:  _buildList(),
        )
      ), 
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _loadCC(),
      ),
    );
  }

  _loadCC() async{
    final response = await http.get('https://api.coincap.io/v2/assets?limit=10');
    if(response.statusCode == 200){
      // print(response.body);
      var allData = (json.decode(response.body) as Map)['data'] as Map<String, dynamic>;

      var ccDataList = List<CCData>();
      allData.forEach((String key, dynamic val){
        var record = CCData(symbol: val['symbol'],name:val['name'],priceUsd:val['priceUsd']);

        ccDataList.add(record);
      });

      print(ccDataList);
    }
  }

    List<Widget> _buildList(){
      return data.map((CCData f) => ListTile(
          title: Text(f.symbol),
          subtitle: Text(f.name),
          trailing: Text('\$${f.priceUsd}'),
      )).toList();
    }

}