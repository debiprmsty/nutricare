import 'package:flutter/material.dart';
import 'package:nutricare/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List categories = ['Per Bulan','Per Tahun'];
  int index_color = 0;
  
   final List<AttendanceData> attendanceData = [
    AttendanceData('Jan', 2022, 10, 15),
    AttendanceData('Feb', 2022, 12, 18),
    AttendanceData('Mar', 2022, 15, 20),
    // ... tambahkan data lainnya sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text("Report", style: inclusiveSans.copyWith(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...List.generate(2, (index) {
                          return GestureDetector( 
                            onTap: () {
                              setState(() {
                                index_color = index;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: index_color == index 
                                  ? biruungu
                                  : Colors.white,
                                border: index_color == index ? Border.all(width: 0) : Border.all(width: 2,color: biruungu)
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                categories[index], style: inclusiveSans.copyWith(
                                  fontSize: 16, 
                                  color: index_color == index 
                                    ? Colors.white
                                    : Colors.black, 
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                          );
                        },),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(top: 12),
                    height: 300,
                    width: width,
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(title: AxisTitle(text: 'Jumlah Balita')),
                      series: <ChartSeries>[
                        BarSeries<AttendanceData, String>(
                          dataSource: attendanceData,
                          xValueMapper: (AttendanceData data, _) => data.month,
                          yValueMapper: (AttendanceData data, _) => data.maleAttendees,
                          name: 'Laki-laki',
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                        BarSeries<AttendanceData, String>(
                          dataSource: attendanceData,
                          xValueMapper: (AttendanceData data, _) => data.month,
                          yValueMapper: (AttendanceData data, _) => data.femaleAttendees,
                          name: 'Perempuan',
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class AttendanceData {
  AttendanceData(this.month, this.year, this.maleAttendees, this.femaleAttendees);

  final String month;
  final int year;
  final int maleAttendees;
  final int femaleAttendees;
}