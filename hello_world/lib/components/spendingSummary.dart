import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';

class MySpendingSummary extends StatefulWidget {

  @override
  _MySpendingSummaryState createState() => _MySpendingSummaryState();
}

class _MySpendingSummaryState extends State<MySpendingSummary> {

  Future<Map<int, int>>? _dataMapFuture;

  @override
  void initState() {
    super.initState();
    DataProvider providerCommunity = Provider.of<DataProvider>(context, listen: false);
    _dataMapFuture = fetchData(providerCommunity);
  }

  Future<Map<int, int>> fetchData(DataProvider providerCommunity) async {
    // Fetch data from database and return it as a Map<String, double>
    return await providerCommunity.spendingSummaryData();
  }

  Widget build(BuildContext context) {
    DataProvider providerCommunity = Provider.of<DataProvider>(context, listen: false);
    return FutureBuilder<Map<int,int>>(
      future: _dataMapFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading spinner while waiting for data to load
          return CircularProgressIndicator();
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          // Build the PieChart widget once data has been loaded
          print("hey----------------------------------");
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('  Your Spending: ₹${snapshot.data![0]}\n  Total Spending: ₹${snapshot.data![1]}',
                style: TextStyle(
                  fontSize: 13.0,
                ),),
            ],
          );
        } else {
          // Handle the case where no data has been fetched
          return Text('No data available');
        }
      },
    );
  }
}