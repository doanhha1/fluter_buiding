import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';

class ElectricUsagePage extends StatefulWidget {
  const ElectricUsagePage({super.key});

  @override
  State<ElectricUsagePage> createState() => _ElectricUsagePageState();
}

class _ElectricUsagePageState extends State<ElectricUsagePage> {
  String _searchQuery = '';

  final List<Map<String, dynamic>> _paymentHistory = [
    {'month': 'January', 'electric': 100, 'water': 50},
    {'month': 'February', 'electric': 120, 'water': 60},
    {'month': 'March', 'electric': 80, 'water': 40},
    {'month': 'April', 'electric': 150, 'water': 70},
  ];

  late List<List<double>> dataRows;
  late List<String> xUserLabels;
  late List<String> dataRowsLegends;
  late ChartOptions chartOptions;

  @override
  void initState() {
    super.initState();

    // Tạo dữ liệu mẫu
    xUserLabels = ['January', 'February', 'March', 'April']; // Tháng
    dataRows = [
      [100.0, 120.0, 80.0, 150.0], // Dữ liệu sử dụng điện
      [50.0, 60.0, 40.0, 70.0],    // Dữ liệu sử dụng nước
    ];
    dataRowsLegends = ['Electric Usage', 'Water Usage']; // Chú thích dữ liệu

    // Tùy chọn biểu đồ
    chartOptions = const ChartOptions();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment History'),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thanh tìm kiếm
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black54.withOpacity(0.6),
                  ),
                  Expanded(
                    child: TextField(
                      showCursor: true,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search by month',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.mic,
                    color: Colors.black54.withOpacity(0.6),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Biểu đồ
            const Text(
              'Comparison Chart',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // SizedBox(
            //   height: size.height * 0.4,
            //     child: VerticalBarChart(
            //       painter: VerticalBarChartPainter(
            //         verticalBarChartContainer: VerticalBarChartTopContainer(
            //           verticalBarChartData: VerticalBarChartData(
            //             dataRows: dataRows,
            //             xUserLabels: xUserLabels,
            //             dataRowsLegends: dataRowsLegends,
            //             chartOptions: chartOptions,
            //           ), chartData: null,
            //         ),
            //       ),
            //     );
            //
            // ),



            const SizedBox(height: 20),

            // Danh sách lịch sử thanh toán
            const Text(
              'Payment History',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredPaymentHistory().length,
                itemBuilder: (context, index) {
                  final item = _filteredPaymentHistory()[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(item['month']),
                      subtitle: Text(
                        'Electric: \$${item['electric']} - Water: \$${item['water']}',
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _filteredPaymentHistory() {
    if (_searchQuery.isEmpty) {
      return _paymentHistory;
    }
    return _paymentHistory
        .where((item) =>
        item['month'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }
}
