// import 'dart:io';
// import 'dart:html';
// import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nutricare/theme.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'dart:typed_data';
// import 'package:open_filex/open_filex.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(child: Text("Report", style: inclusiveSans.copyWith(fontSize: 22, color: Colors.black, fontWeight: FontWeight.w700),)),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
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
                    const SizedBox(
                      height: 15,
                    ),
                    Text("Cetak Laporan", style: inclusiveSans.copyWith(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _displayCetakOrtu(context);
                          },
                          child: SizedBox(
                            width: 110,
                            height: 110,
                            child: Card(
                              color: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                  color: biruungu,
                                  width: 2
                                )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/coup_blue.png", scale: 1.5),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Orang Tua", style: inclusiveSans.copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _displayCetakBalita(context);
                          },
                          child: SizedBox(
                            width: 110,
                            height: 110,
                            child: Card(
                              color: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                  color: biruungu,
                                  width: 2
                                )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("assets/icons/babys.png", scale: 1.0),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Balita", style: inclusiveSans.copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),)
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _displayCetakTimbangan(context);
                          },
                          child: SizedBox(
                            width: 110,
                            height: 110,
                            child: Card(
                              color: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(
                                  color: biruungu,
                                  width: 2
                                )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.baby_changing_station_outlined, color: biruungu, size: 50,),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Timbangan", style: inclusiveSans.copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                    // Container(
                    //   padding: const EdgeInsets.all(8),
                    //   margin: const EdgeInsets.only(top: 12),
                    //   height: 300,
                    //   width: width,
                    //   child: SfCartesianChart(
                    //     primaryXAxis: CategoryAxis(),
                    //     primaryYAxis: NumericAxis(title: AxisTitle(text: 'Jumlah Balita')),
                    //     series: <ChartSeries>[
                    //       BarSeries<AttendanceData, String>(
                    //         dataSource: attendanceData,
                    //         xValueMapper: (AttendanceData data, _) => data.month,
                    //         yValueMapper: (AttendanceData data, _) => data.maleAttendees,
                    //         name: 'Laki-laki',
                    //         dataLabelSettings: DataLabelSettings(isVisible: true),
                    //       ),
                    //       BarSeries<AttendanceData, String>(
                    //         dataSource: attendanceData,
                    //         xValueMapper: (AttendanceData data, _) => data.month,
                    //         yValueMapper: (AttendanceData data, _) => data.femaleAttendees,
                    //         name: 'Perempuan',
                    //         dataLabelSettings: DataLabelSettings(isVisible: true),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _displayCetakOrtu(BuildContext context) async{
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
  

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: biruungu,),
        );
      },
    );

    try {

      Navigator.of(context).pop();
      await showModalBottomSheet(
        context: context, 
        isScrollControlled: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30),)
        ),
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Cetak Laporan", style: inclusiveSans.copyWith(fontSize: 22, fontWeight: FontWeight.bold, color: biruungu),),
                  const SizedBox(
                    width: 80,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close_rounded, color: biruungu,)
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // getPdf();
                    },
                    child: SizedBox(
                      width: 170,
                      height: 150,
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            color: biruungu,
                            width: 2
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Cetak", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),),
                            SizedBox(
                              height: 2,
                            ),
                            Image.asset("assets/images/pdf.png", width: 70, height: 100,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 170,
                    height: 150,
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: biruungu,
                          width: 2
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Cetak", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),),
                          SizedBox(
                            height: 3,
                          ),
                          Image.asset("assets/images/excel.png", width: 100, height: 100,),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        )
      );
    } catch (e) {
      Navigator.of(context).pop();

    // Menampilkan pesan kesalahan jika diperlukan
      print("Error fetching data");
    }
  }

  Future _displayCetakBalita(BuildContext context) async{
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
  

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: biruungu,),
        );
      },
    );

    try {

      Navigator.of(context).pop();
      await showModalBottomSheet(
        context: context, 
        isScrollControlled: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30),)
        ),
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Cetak Laporan", style: inclusiveSans.copyWith(fontSize: 22, fontWeight: FontWeight.bold, color: biruungu),),
                  const SizedBox(
                    width: 80,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close_rounded, color: biruungu,)
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 170,
                    height: 150,
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: biruungu,
                          width: 2
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Cetak", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),),
                          SizedBox(
                            height: 2,
                          ),
                          Image.asset("assets/images/pdf.png", width: 70, height: 100,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 170,
                    height: 150,
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: biruungu,
                          width: 2
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Cetak", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),),
                          SizedBox(
                            height: 3,
                          ),
                          Image.asset("assets/images/excel.png", width: 100, height: 100,),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        )
      );
    } catch (e) {
      Navigator.of(context).pop();

    // Menampilkan pesan kesalahan jika diperlukan
      print("Error fetching data");
    }
  }

  Future _displayCetakTimbangan(BuildContext context) async{
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
  

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(color: biruungu,),
        );
      },
    );

    try {

      Navigator.of(context).pop();
      await showModalBottomSheet(
        context: context, 
        isScrollControlled: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30),)
        ),
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Cetak Laporan", style: inclusiveSans.copyWith(fontSize: 22, fontWeight: FontWeight.bold, color: biruungu),),
                  const SizedBox(
                    width: 80,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close_rounded, color: biruungu,)
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 170,
                    height: 150,
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: biruungu,
                          width: 2
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Cetak", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),),
                          SizedBox(
                            height: 2,
                          ),
                          Image.asset("assets/images/pdf.png", width: 70, height: 100,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 170,
                    height: 150,
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: biruungu,
                          width: 2
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Cetak", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),),
                          SizedBox(
                            height: 3,
                          ),
                          Image.asset("assets/images/excel.png", width: 100, height: 100,),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        )
      );
    } catch (e) {
      Navigator.of(context).pop();

    // Menampilkan pesan kesalahan jika diperlukan
      print("Error fetching data");
    }
  }
}

// Future<void> getPdf() async {
//   final pdf = pw.Document();

//   pdf.addPage(
//     pw.Page(
//       pageFormat: PdfPageFormat.a4,
//       build: (pw.Context context) {
//         return pw.Center(
//           child: pw.Text("OK")
//         );
//       },
//     ),
//   );

//   Uint8List bytes = await pdf.save();

//   final dir = await getApplicationDocumentsDirectory();
//   final name_file = File("${dir.path}/document.pdf");

//   await name_file.writeAsBytes(bytes);

//   await OpenFilex.open(name_file.path);
// }





class AttendanceData {
  AttendanceData(this.month, this.year, this.maleAttendees, this.femaleAttendees);

  final String month;
  final int year;
  final int maleAttendees;
  final int femaleAttendees;
}