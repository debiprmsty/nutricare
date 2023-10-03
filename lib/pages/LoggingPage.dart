import 'package:flutter/material.dart';
import 'package:nutricare/theme.dart';

class LoggingPage extends StatefulWidget {
  const LoggingPage({super.key});

  @override
  State<LoggingPage> createState() => _LoggingPageState();
}

class _LoggingPageState extends State<LoggingPage> {
  List<Tab> tabs = [
    Tab(
      text: "Orang Tua",
      icon: Icon(Icons.people_alt_outlined),
    ),
    Tab(
      text: "Balita",
      icon: Icon(Icons.child_care),
    ),
    Tab(
      text: "Penimbangan",
      icon: Icon(Icons.baby_changing_station_outlined),
    )
  ];
 

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: biruungu,
          automaticallyImplyLeading: false,
          leadingWidth: 300,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20,top: 20),
            child: Text("Pencatatan",style: inclusiveSans.copyWith(fontSize: 27,color: Colors.white,fontWeight: FontWeight.bold),),
          ),
          bottom: TabBar(
            labelStyle: inclusiveSans,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 2
                )
              )
            ),
            tabs: tabs
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                            style: inclusiveSans,
                            decoration: InputDecoration(
                                hintText: 'Cari Data Orang Tua...',
                                hintStyle: inclusiveSans.copyWith(color: Colors.grey, fontSize: 13),
                                focusColor: Colors.black,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                prefixIcon: Icon(Icons.search, color: biruungu,),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: biruungu,
                                      width: 2
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: biruungu,
                                      width: 2 // Warna border ketika dalam keadaan fokus
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: biruungu,
                                      width: 2 // Warna border ketika tidak dalam keadaan fokus
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                              ),
                          ),
                          ),
                          const SizedBox(width: 15,),
                          GestureDetector(
                            onTap: () {
                             
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: biruungu,
                                  width: 2
                                )
                              ),
                              child: Icon(Icons.add,color: biruungu,),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: width,
                        height: height - 350,
                        child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              width: width,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8), // Warna latar belakang container
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 232, 232, 232), // Warna bayangan
                                    offset: Offset(0, 2.5), // Offset bayangan (x, y)
                                    blurRadius: 0.5,
                                    spreadRadius: 0.0, // Radius penyebaran bayangan
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Container(
                                      width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: biruungu,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8))
                                      ),
                                      child: Icon(Icons.people,color: Colors.white,),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    flex: 4,
                                    child: Container(
                                      color: Colors.white,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Lanang Surya Darma",style: inclusiveSans.copyWith(color: Colors.black87),),
                                          Text("Luh Debi Pramesty",style: inclusiveSans.copyWith(color: Colors.black87),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    flex: 2,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      width: width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.edit_square,color: Colors.amber[600],),
                                          Icon(Icons.delete_forever_sharp,color: Colors.red[400],)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                            style: inclusiveSans,
                            decoration: InputDecoration(
                                hintText: 'Cari Data Balita...',
                                hintStyle: inclusiveSans.copyWith(color: Colors.grey, fontSize: 13),
                                focusColor: Colors.black,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                prefixIcon: Icon(Icons.search, color: biruungu,),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: biruungu,
                                      width: 2
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: biruungu,
                                      width: 2 // Warna border ketika dalam keadaan fokus
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: biruungu,
                                      width: 2 // Warna border ketika tidak dalam keadaan fokus
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                              ),
                          ),
                          ),
                          const SizedBox(width: 15,),
                          GestureDetector(
                            onTap: () {
                             
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: biruungu,
                                  width: 2
                                )
                              ),
                              child: Icon(Icons.add,color: biruungu,),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: width,
                        height: height - 350,
                        child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              width: width,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8), // Warna latar belakang container
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 232, 232, 232), // Warna bayangan
                                    offset: Offset(0, 2.5), // Offset bayangan (x, y)
                                    blurRadius: 0.5,
                                    spreadRadius: 0.0, // Radius penyebaran bayangan
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Container(
                                      width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: biruungu,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8))
                                      ),
                                      child: Icon(Icons.child_care,color: Colors.white,),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    flex: 4,
                                    child: Container(
                                      color: Colors.white,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Lanang Surya Darma",style: inclusiveSans.copyWith(color: Colors.black87),),
                                         
                                          Text("NIK : 2115051032",style: poppins.copyWith(color: Colors.grey[600],fontSize: 11,),)
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    flex: 2,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      width: width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.edit_square,color: Colors.amber[600],),
                                          Icon(Icons.delete_forever_sharp,color: Colors.red[400],)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                            style: inclusiveSans,
                            decoration: InputDecoration(
                                hintText: 'Cari Data Penimbangan..',
                                hintStyle: inclusiveSans.copyWith(color: Colors.grey, fontSize: 13),
                                focusColor: Colors.black,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                prefixIcon: Icon(Icons.search, color: biruungu,),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: biruungu,
                                      width: 2
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: biruungu,
                                      width: 2 // Warna border ketika dalam keadaan fokus
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: biruungu,
                                      width: 2 // Warna border ketika tidak dalam keadaan fokus
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                              ),
                          ),
                          ),
                          const SizedBox(width: 15,),
                          GestureDetector(
                            onTap: () {
                             
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: biruungu,
                                  width: 2
                                )
                              ),
                              child: Icon(Icons.add,color: biruungu,),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: width,
                        height: height - 350,
                        child: ListView.builder(
                          itemCount: 10,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              width: width,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8), // Warna latar belakang container
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 232, 232, 232), // Warna bayangan
                                    offset: Offset(0, 2.5), // Offset bayangan (x, y)
                                    blurRadius: 0.5,
                                    spreadRadius: 0.0, // Radius penyebaran bayangan
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Container(
                                      width: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: biruungu,
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8))
                                      ),
                                      child: Icon(Icons.baby_changing_station_outlined,color: Colors.white,),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    flex: 4,
                                    child: Container(
                                      color: Colors.white,
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Lanang Surya Darma",style: inclusiveSans.copyWith(color: Colors.black87),),
                                        
                                          Row(
                                            children: [
                                              Text("BB : 10kg",style: poppins.copyWith(color: Colors.grey[600],fontSize: 11,),),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text("TB : 90cm",style: poppins.copyWith(color: Colors.grey[600],fontSize: 11,),),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    flex: 2,
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      width: width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(Icons.edit_square,color: Colors.amber[600],),
                                          Icon(Icons.delete_forever_sharp,color: Colors.red[400],)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}