import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';

class MySpendingSummary extends StatefulWidget {
  @override
  _MySpendingSummaryState createState() => _MySpendingSummaryState();
}

class _MySpendingSummaryState extends State<MySpendingSummary> {

  Future<int>? _yourSpending;
  Future<int>? _totalSpending;
  Future<int>? dummy;

  @override
  void initState() {
    super.initState();

  }

  Future<int>? getData(){
    DataProvider providerCommunity = Provider.of<DataProvider>(context, listen: false);
    _yourSpending=fetchDataYourSpending(providerCommunity);
    _totalSpending=fetchDataTotalSpending(providerCommunity);
    dummy=fetchDataTotalSpending(providerCommunity);
    return dummy;
  }

  Future<int> fetchDataYourSpending(DataProvider providerCommunity) async {
    // Wait for some asynchronous operation to complete
    return await providerCommunity.myTotalExpense();
  }

  Future<int> fetchDataTotalSpending(DataProvider providerCommunity) async {
    // Wait for some asynchronous operation to complete
    return await providerCommunity.totalExpense();
  }

  Widget build(BuildContext context) {
    DataProvider providerCommunity = Provider.of<DataProvider>(context, listen: false);
    return FutureBuilder<int>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        if (snapshot.hasData) {
          // Use the data in a Text widget
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MySpendingSummary(),
              Text('Your spending : ₹${_yourSpending}',
                style: TextStyle(
                  fontSize: 13.0,
                ),),
              Text('Total spending : ₹${_totalSpending}',
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
            ],
          );
          Text(
            'Data: ${snapshot.data}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          );
        } else {
          // Show a progress indicator while waiting for data
          return CircularProgressIndicator();
        }
      },
    );
  }
}