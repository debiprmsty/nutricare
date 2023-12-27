import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutricare/api/balita.dart';
import 'package:nutricare/api/ortu.dart';
import 'package:nutricare/api/timbangan.dart';
import 'package:nutricare/api/user.dart';
import 'package:nutricare/models/Balita.dart';
import 'package:nutricare/models/OrangTua.dart';
import 'package:nutricare/models/User.dart';
import 'package:nutricare/pages/balita/AddBalita.dart';
import 'package:nutricare/pages/balita/UpdateBalita.dart';
import 'package:nutricare/pages/orangtua/AddOrangTua.dart';
import 'package:nutricare/pages/orangtua/UpdateOrangTua.dart';
import 'package:nutricare/pages/penimbangan/AddPenimbangan.dart';
import 'package:nutricare/pages/penimbangan/UpdatePenimbangan.dart';
import 'package:nutricare/theme.dart';
import 'package:shimmer/shimmer.dart';

class LoggingPage extends StatefulWidget {
  const LoggingPage({super.key});

  @override
  State<LoggingPage> createState() => _LoggingPageState();
}

class _LoggingPageState extends State<LoggingPage> {
  List<Tab> tabs = [
    Tab(
      text: "Orang Tua",
      icon: Image.asset("assets/icons/couple.png", scale: 1.4),
    ),
    Tab(
      text: "Balita",
      icon: Image.asset("assets/icons/baby.png", scale: 2.4),
    ),
    Tab(
      text: "Timbangan",
      icon: Icon(Icons.baby_changing_station_outlined, color: Colors.white,),
    )
  ];

  late OrangTua _orangTua;
  bool isLoadData = false;
  
  //API
  final UserController _userController = UserController();
  final OrtuController _ortuController = OrtuController();
  final BalitaController _balitaController = BalitaController();
  final TimbanganController _timbanganController = TimbanganController();
  TextEditingController _searchOrtuController = TextEditingController();
  TextEditingController _searchBalitaController = TextEditingController();
  TextEditingController _searchTimbanganController = TextEditingController();
  List<dynamic> filteredOrtu = [];
  List<dynamic> filteredBalita = [];
  List<dynamic> filteredTimbangan = [];
  late User _activeUser = User(id: 0, fullname: "", role: "", image: "");

  void searchOrtu (String query) async {
    String value = _searchOrtuController.text;
    if (value.isEmpty) {
      await _ortuController.fetchOrtu().then((value) {
        List<dynamic> data = value;
        setState(() {
          filteredOrtu = data;
        });
      });

      return;
    }

    await _ortuController.fetchOrtu().then((ortu) {
      List<dynamic> ortuList = ortu;

      setState(() {
        filteredOrtu = ortuList
        .where((ortuas) =>
          ortuas['nama_bapak'].toLowerCase().contains(query.toLowerCase()) ||
          ortuas['nama_ibu'].toLowerCase().contains(query.toLowerCase()))
        .toList();
      });
    });
  }

  void searchBalita (String query) async {
    String value = _searchBalitaController.text;
    if (value.isEmpty) {
      await _balitaController.fetchBalita().then((value) {
        List<dynamic> data = value;
        setState(() {
          filteredBalita = data;
        });
      });

      return;
    }

    await _balitaController.fetchBalita().then((balita) {
      List<dynamic> balitaList = balita;
      setState(() {
        filteredBalita = balitaList
        .where((balitas) =>
          balitas['nama'].toLowerCase().contains(query.toLowerCase()) ||
          balitas['nik_balita'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();
      });
    });
  }

  void searchTimbangan (String query) async {
    String value = _searchTimbanganController.text;
    if (value.isEmpty) {
      await _timbanganController.fetchTimbangan().then((value) {
        List<dynamic> data = value;
        setState(() {
          filteredTimbangan = data;
        });
      });

      return;
    }

    await _timbanganController.fetchTimbangan().then((timbangan) {
      List<dynamic> timbanganList = timbangan;
      setState(() {
        filteredTimbangan = timbanganList
        .where((timbangans) =>
          timbangans['balita']['nama'].toLowerCase().contains(query.toLowerCase()))
        .toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
      _userController.fetchUser().then((value) => {
        if (value != null) {
          setState(() {
            _activeUser = User(id: value['id'], fullname: value['fullname'], role: value['role'], image: value['image']);
            isLoadData = true;
          })
        }
      });
      searchOrtu('');
      searchBalita('');
      searchTimbangan('');
  }

  

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: biruungu,
          automaticallyImplyLeading: false,
          leadingWidth: 300,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20,top: 20),
            child: Text("Pencatatan",style: inclusiveSans.copyWith(fontSize: 27,color: Colors.white,fontWeight: FontWeight.bold),),
          ),
          bottom: TabBar(
            labelStyle: inclusiveSans.copyWith(fontSize: 12.5),
            labelPadding: EdgeInsets.only(right: 3),
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                  width: 2
                )
              )
            ),
            tabs: tabs,
          ),
        ),
        body: TabBarView(
          children: [
            // Orang Tua
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
                              controller: _searchOrtuController,
                              onChanged: (value) {
                                searchOrtu(value);
                              },
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
                          Visibility(
                            visible:  _activeUser.role == "petugas" ? true : false,
                            child: const SizedBox(width: 15,)
                          ),
                          Visibility(
                            visible: _activeUser.role == "petugas" ? true : false,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return const AddOrangTuaPage();
                                }));
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
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: width,
                        height: height - 320,
                        child:  FutureBuilder(
                          future: _ortuController.fetchOrtu(),
                          builder: (BuildContext context,snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return ShimmerData();
                            } else if(snapshot.hasData) {
                              final orangTuas = snapshot.data;
                              if (filteredOrtu.isEmpty) {
                                // Tampilkan pesan jika filteredProducts kosong
                                return Text(
                                  'Tidak ada hasil', style: inclusiveSans.copyWith(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey[400]),
                                  textAlign: TextAlign.center,
                                );
                              }
                              return ListView.builder(
                              itemCount: filteredOrtu.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, index) {
                                final data = filteredOrtu[index];
                                return GestureDetector(
                                  onTap: () {
                                    _displayDetailOrtu(context,data['id'].toString());
                                  },
                                  child: Container(
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
                                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: _activeUser.role == "petugas" ? 12 : 0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(data['nama_bapak'],style: inclusiveSans.copyWith(color: Colors.black87),),
                                                Text(data['nama_ibu'],style: inclusiveSans.copyWith(color: Colors.black87),)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible:  _activeUser.role == "petugas" ? true : false,
                                          child: Flexible(
                                            fit: FlexFit.loose,
                                            flex: 2,
                                            child: Container(
                                              margin: const EdgeInsets.only(left: 20),
                                              width: width,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                                        return UpdateOrtuPage(id: data['id'].toString(),);
                                                      }));
                                                    },
                                                    child: Icon(Icons.edit_square,color: Colors.amber[600],)
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            backgroundColor: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(15)
                                                            ),
                                                            elevation: 5,
                                                            content: Container(
                                                              width: 200,
                                                              height: 368,
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width: width,
                                                                    height: 30,
                                                                    alignment: Alignment.centerRight,
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: Icon(Icons.close_rounded, color: biruungu,)
                                                                    ),
                                                                  ),
                                                                  Image.asset("assets/images/Trash.png", scale: 1.2,),
                                                                  Text("Hapus Data Orang Tua", style: inclusiveSans.copyWith(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w900), textAlign: TextAlign.center,),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text("Anda yakin ingin menghapus data ini?", style: inclusiveSans.copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 125,
                                                                    child: FilledButton(
                                                                      style: ButtonStyle(
                                                                        backgroundColor: MaterialStatePropertyAll(biruungu)
                                                                      ),
                                                                      onPressed: () async {
                                                                        await _ortuController.deleteOrtu(data['id'].toString());
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: Text("Iya, hapus", style: inclusiveSans.copyWith(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),)
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 125,
                                                                    child: FilledButton(
                                                                      style: ButtonStyle(
                                                                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                                                                        side: MaterialStatePropertyAll(
                                                                          BorderSide(
                                                                            color:  Colors.red,
                                                                            width: 1.5
                                                                          )
                                                                        )
                                                                      ),
                                                                      onPressed: () {
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: Text("Batal", style: inclusiveSans.copyWith(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),)
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Icon(Icons.delete_forever_sharp,color: Colors.red[400],)
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                            );
                            } else {
                              return Center(
                                child: Text("Tidak ada data Orang Tua", style: inclusiveSans.copyWith(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey[400]),),
                              );
                            }
                          }
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),

            // Balita
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
                              controller: _searchBalitaController,
                              onChanged: (value) {
                                searchBalita(value);
                              },
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
                          Visibility(
                            visible:  _activeUser.role == "petugas" ? true : false,
                            child: const SizedBox(width: 15,)
                          ),
                          Visibility(
                            visible:  _activeUser.role == "petugas" ? true : false,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return const AddBalitaPage();
                                }));
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
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: width,
                        height: height - 320,
                        child: FutureBuilder(
                          future: _balitaController.fetchBalita(),
                          builder: (BuildContext context,snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting) {
                              return ShimmerData();
                            } else if(snapshot.hasData) {
                              final balitas = snapshot.data;
                              if (filteredBalita.isEmpty) {
                                // Tampilkan pesan jika filteredProducts kosong
                                return Text(
                                  'Tidak ada hasil', style: inclusiveSans.copyWith(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey[400]),
                                  textAlign: TextAlign.center,
                                );
                              }
                              return ListView.builder(
                              itemCount: filteredBalita.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, index) {
                                final balita = filteredBalita[index];
                                return GestureDetector(
                                  onTap: () {
                                    _displayDetailBalita(context,balita['id'].toString());
                                  },
                                  child: Container(
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
                                                Text(balita['nama'],style: inclusiveSans.copyWith(color: Colors.black87),),
                                              
                                                Text("NIK : ${balita['nik_balita']}",style: poppins.copyWith(color: Colors.grey[600],fontSize: 11,),)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible:  _activeUser.role == "petugas" ? true : false,
                                          child: Flexible(
                                            fit: FlexFit.loose,
                                            flex: 2,
                                            child: Container(
                                              margin: const EdgeInsets.only(left: 20),
                                              width: width,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                                        return UpdateBalitaPage(id: balita['id'].toString(),);
                                                      }));
                                                    },
                                                    child: Icon(Icons.edit_square,color: Colors.amber[600],)
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            backgroundColor: Colors.white,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(15)
                                                            ),
                                                            elevation: 5,
                                                            content: Container(
                                                              width: 200,
                                                              height: 368,
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width: width,
                                                                    height: 30,
                                                                    alignment: Alignment.centerRight,
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: Icon(Icons.close_rounded, color: biruungu,)
                                                                    ),
                                                                  ),
                                                                  Image.asset("assets/images/Trash.png", scale: 1.2,),
                                                                  Text("Hapus Data Balita", style: inclusiveSans.copyWith(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w900), textAlign: TextAlign.center,),
                                                                  const SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text("Anda yakin ingin menghapus data ini?", style: inclusiveSans.copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 125,
                                                                    child: FilledButton(
                                                                      style: ButtonStyle(
                                                                        backgroundColor: MaterialStatePropertyAll(biruungu)
                                                                      ),
                                                                      onPressed: () async {
                                                                        await _balitaController.deleteBalita(balita['id'].toString());
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: Text("Iya, hapus", style: inclusiveSans.copyWith(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),)
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 125,
                                                                    child: FilledButton(
                                                                      style: ButtonStyle(
                                                                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                                                                        side: MaterialStatePropertyAll(
                                                                          BorderSide(
                                                                            color:  Colors.red,
                                                                            width: 1.5
                                                                          )
                                                                        )
                                                                      ),
                                                                      onPressed: () {
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: Text("Batal", style: inclusiveSans.copyWith(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),)
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Icon(Icons.delete_forever_sharp,color: Colors.red[400],)
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                            );
                            }else {
                              return Center(
                                child: Text("Tidak ada data Balita", style: inclusiveSans.copyWith(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey[400]),),
                              );
                            }
                          }
                        )
                      )
                    ],
                  ),
                ),
              ),
            ),

            // Timbangan
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
                              controller: _searchTimbanganController,
                              onChanged: (value) {
                                searchTimbangan(value);
                              },
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
                          Visibility(
                            visible:  _activeUser.role == "petugas" ? true : false,
                            child: const SizedBox(width: 15,)
                          ),
                          Visibility(
                            visible:  _activeUser.role == "petugas" ? true : false,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return AddPenimbanganPage(searchTimbangan: searchTimbangan,);
                                }));
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
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: width,
                        height: height - 320,
                        child: FutureBuilder(
                          future: _timbanganController.fetchTimbangan(),
                          builder: (BuildContext context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting) {
                              return ShimmerData();
                            } else if(snapshot.hasData) {
                              final timbangans = snapshot.data;
                              if (filteredTimbangan.isEmpty) {
                                // Tampilkan pesan jika filteredProducts kosong
                                return Text(
                                  'Tidak ada hasil', style: inclusiveSans.copyWith(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey[400]),
                                  textAlign: TextAlign.center,
                                );
                              }
                              return ListView.builder(
                                itemCount: filteredTimbangan.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, index) {
                                  final timbangan = filteredTimbangan[index];
                                  final nama = timbangan['balita']['nama'];
                                  print(timbangan);
                                  return GestureDetector(
                                    onTap: () {
                                      _displayDetailPenimbangan(context,timbangan['id'].toString(),);
                                    },
                                    child: Container(
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
                                                  Text(nama,style: inclusiveSans.copyWith(color: Colors.black87),),
                                                
                                                  Row(
                                                    children: [
                                                      Text("BB : ${timbangan['berat_badan']}kg",style: poppins.copyWith(color: Colors.grey[600],fontSize: 11,),),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text("TB : ${timbangan['tinggi_badan']}cm",style: poppins.copyWith(color: Colors.grey[600],fontSize: 11,),),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible:  _activeUser.role == "petugas" ? true : false,
                                            child: Flexible(
                                              fit: FlexFit.loose,
                                              flex: 2,
                                              child: Container(
                                                margin: const EdgeInsets.only(left: 20),
                                                width: width,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                                          return UpdatePenimbanganPage(id: timbangan['id'].toString(),);
                                                        }));
                                                      },
                                                      child: Icon(Icons.edit_square,color: Colors.amber[600],)
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          barrierDismissible: false,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              backgroundColor: Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(15)
                                                              ),
                                                              elevation: 5,
                                                              content: Container(
                                                                width: 200,
                                                                height: 368,
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      width: width,
                                                                      height: 30,
                                                                      alignment: Alignment.centerRight,
                                                                      child: GestureDetector(
                                                                        onTap: () {
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        child: Icon(Icons.close_rounded, color: biruungu,)
                                                                      ),
                                                                    ),
                                                                    Image.asset("assets/images/Trash.png", scale: 1.2,),
                                                                    Text("Hapus Data Timbangan", style: inclusiveSans.copyWith(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w900), textAlign: TextAlign.center,),
                                                                    const SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text("Anda yakin ingin menghapus data ini?", style: inclusiveSans.copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                                                                    const SizedBox(
                                                                      height: 10,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 125,
                                                                      child: FilledButton(
                                                                        style: ButtonStyle(
                                                                          backgroundColor: MaterialStatePropertyAll(biruungu)
                                                                        ),
                                                                        onPressed: () async {
                                                                         await _timbanganController.deleteTimbangan(timbangan['id'].toString()).then((value) => {
                                                                          if(value != null) {
                                                                            if(value['success'] == true) {
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                                SnackBar(
                                                                                  content: Text('Data berhasil dihapus'),
                                                                                  duration: Duration(seconds: 2), // Durasi notifikasi
                                                                                ),
                                                                              ),
                                                                              Navigator.pop(context)
                                                                          }
                                                                          }
                                                                        });
                                                                      
                                                                        },
                                                                        child: Text("Iya, hapus", style: inclusiveSans.copyWith(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),)
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 125,
                                                                      child: FilledButton(
                                                                        style: ButtonStyle(
                                                                          backgroundColor: MaterialStatePropertyAll(Colors.white),
                                                                          side: MaterialStatePropertyAll(
                                                                            BorderSide(
                                                                              color:  Colors.red,
                                                                              width: 1.5
                                                                            )
                                                                          )
                                                                        ),
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        child: Text("Batal", style: inclusiveSans.copyWith(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),)
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Icon(Icons.delete_forever_sharp,color: Colors.red[400],)
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              );
                            } else {
                              return Center(
                                child: Text("Tidak ada data Timbangan", style: inclusiveSans.copyWith(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey[400]),),
                              );
                            }
                          },
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

  Future _displayDetailOrtu(BuildContext context,id) async{
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
      OrangTua? detailOrtu = await _ortuController.fetchOrtuId(id);

      Navigator.of(context).pop();
      await showModalBottomSheet(
        context: context, 
        isScrollControlled: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30),)
        ),
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.6,
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Detail Orang Tua", style: inclusiveSans.copyWith(fontSize: 23, fontWeight: FontWeight.bold, color: biruungu),),
                  const SizedBox(
                    width: 65,
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
                height: 15,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nomor KK", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text("${detailOrtu?.keluarga['nik_keluarga']}", style: poppins.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("NIK Bapak", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text("${detailOrtu?.nik_bapak}", style: poppins.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama Bapak", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text(detailOrtu!.nama_bapak, style: inclusiveSans.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("NIK Ibu", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text("${detailOrtu.nik_ibu}", style: poppins.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama Ibu", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text(detailOrtu.nama_ibu, style: inclusiveSans.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Alamat", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text(detailOrtu.alamat, style: inclusiveSans.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
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

  Future _displayDetailBalita(BuildContext context,id) async{
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
      final balita = await _balitaController.fetchBalitaId(id);
      Navigator.of(context).pop();
       await showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30),)
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.78,
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Detail Balita", style: inclusiveSans.copyWith(fontSize: 23, fontWeight: FontWeight.bold, color: biruungu),),
                  const SizedBox(
                    width: 85,
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
                height: 15,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nomor KK", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text("${balita['keluarga']['nik_keluarga'] ?? 0}", style: poppins.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama Bapak", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text(balita['ortu']['nama_bapak'], style: inclusiveSans.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama Ibu", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text(balita['ortu']['nama_ibu'], style: inclusiveSans.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("NIK Balita", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text("${balita['nik_balita']}", style: poppins.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama Balita", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text(balita['nama'], style: inclusiveSans.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Alamat", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text(balita['ortu']['alamat'], style: inclusiveSans.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tanggal Lahir Balita", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text("${balita['tanggal_lahir']}", style: poppins.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Umur", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      RichText(
                        text: TextSpan(
                          text: "${balita['umur']}",
                          style: poppins.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: " Bulan",
                              style: inclusiveSans.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)
                            )
                          ]
                        )
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Jenis Kelamin", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text(balita['jenis_kelamin'], style: inclusiveSans.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );

    } catch (e) {
      Navigator.of(context).pop();

    // Menampilkan pesan kesalahan jika diperlukan
      print("Error fetching data $e");
    }

   
  }

  Future _displayDetailPenimbangan(BuildContext context,id) async{
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
      final penimbangan = await _timbanganController.fetchTimbanganId(id);
      Navigator.of(context).pop();
      await showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30),)
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.78,
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Detail Penimbangan", style: inclusiveSans.copyWith(fontSize: 23, fontWeight: FontWeight.bold, color: biruungu),),
                  const SizedBox(
                    width: 45,
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
                height: 15,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nama Balita", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text(penimbangan['balita']['nama'], style: inclusiveSans.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tanggal Penimbangan", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text(penimbangan["tanggal_timbangan"], style: poppins.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Berat Badan", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      RichText(
                        text: TextSpan(
                          text:penimbangan['berat_badan'].toString(),
                          style: poppins.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: "Kg",
                              style: inclusiveSans.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)
                            )
                          ]
                        )
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tinggi/Panjang Badan", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      RichText(
                        text: TextSpan(
                          text: penimbangan['tinggi_badan'].toString(),
                          style: poppins.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: "Cm",
                              style: inclusiveSans.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)
                            )
                          ]
                        )
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Keterangan", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text(penimbangan['keterangan']['keterangan'], style: inclusiveSans.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text("Kategori Index Balita", style: inclusiveSans.copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: biruungu),),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Berat Badan Menurut Umur", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text("Normal", style: inclusiveSans.copyWith(color: Colors.green[800], fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Tinggi/Panjang Badan Menurut Umur", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text("Normal", style: inclusiveSans.copyWith(color: Colors.green[800], fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Berat Badan Menurut Tinggi/Panjang Badan", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text("Gizi Baik", style: inclusiveSans.copyWith(color: Colors.green[800], fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: width,
                height: 59,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Indeks Massa Tubuh Menurut Umur", style: inclusiveSans.copyWith(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      Text("Gizi Baik", style: inclusiveSans.copyWith(color: Colors.green[800], fontSize: 18, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
    } catch (e) {
      Navigator.of(context).pop();

    // Menampilkan pesan kesalahan jika diperlukan
      print("Error fetching data $e");
    }

  }

}


class ShimmerData extends StatelessWidget {
  const ShimmerData({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context,index) {
        return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: Shimmer.fromColors(
             baseColor: const Color.fromARGB(255, 232, 232, 232),
            highlightColor: const Color.fromARGB(255, 223, 223, 223),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50.0,
                    height: 50.0,
                    color: Colors.white, // Warna latar belakang konten sebenarnya
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 290,
                        height: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 290,
                        height: 20,
                        color: Colors.white,
                      )
                    ],
                  )
                ]
              ),
            ),
          );
      }
    );
  }
}




