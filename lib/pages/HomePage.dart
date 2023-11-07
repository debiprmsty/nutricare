import 'package:flutter/material.dart';
import 'package:nutricare/api/user.dart';
import 'package:nutricare/components/Slider.dart';
import 'package:nutricare/models/User.dart';
import 'package:nutricare/pages/kategori/BBmenurutTB.dart';
import 'package:nutricare/pages/kategori/BBmenurutUmur.dart';
import 'package:nutricare/pages/kategori/IMTmenurutUmur.dart';
import 'package:nutricare/pages/kategori/TBmenurutUmur.dart';
import 'package:nutricare/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String,dynamic>> artikels = [
    {
      "penulis":"Debi Pramesty",
      "tanggal":"2023-10-02",
      "gambar" : "assets/images/artikel1.jpg",
      "judul" : "Ikan Bergizi Tinggi Sehat dan Enak"
    },
    {
      "penulis":"Debi Pramesty",
      "tanggal":"2023-10-02",
      "gambar" : "assets/images/artikel2.jpg",
      "judul" : "Aksi Bersama Cegah Stunting dan Obesitas"
    },
    {
      "penulis":"Debi Pramesty",
      "tanggal":"2023-10-02",
      "gambar" : "assets/images/artikel3.png",
      "judul" : "Cegah Stunting itu Penting !!!"
    }
  ];

  final UserController _userController = UserController();
  late User _activeUser = User(id: 0, fullname: "", role: "", image: "");

  @override
  void initState() {
    super.initState();
    _userController.fetchUser().then((value) => {
      if (value != null) {
        setState(() {
          _activeUser = User(id: value['id'], fullname: value['fullname'], role: value['role'], image: value['image']);
        })
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 50, left: 18, right: 18),
                  width: width,
                  height: height * 0.25 + 180,
                  color: biruungu,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: _activeUser.image != "" ? NetworkImage("https://testchairish.000webhostapp.com/api/user-image/${_activeUser.image}",) : NetworkImage("https://afpertise.com/media/2020/09/Member-1.jpg",) ,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_activeUser.role, style: inclusiveSans.copyWith(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(_activeUser.fullname, style: inclusiveSans.copyWith(fontSize: 18, color: Colors.white),),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Icon(Icons.notifications, color: Colors.white, size: 30,),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: width,
                        height: 170,
                        child: SliderHome(),
                      )
                    ],
                  ),    
                ),
                Container(
                  padding: const EdgeInsets.only(top: 100, left: 18, right: 18),
                  height: height - 200,
                  width: width,
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Kategori Index", style: inclusiveSans.copyWith(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),),
                      SizedBox(
                        width: width,
                        height: 212,
                        child:GridView.count(
                          padding: EdgeInsets.only(top: 10),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 6/3,
                          shrinkWrap: false,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return const BBmenurutUmurPage();
                                }));
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 8, shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ), 
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(0),
                                      width: 80,
                                      height: height,
                                      decoration:BoxDecoration(
                                        color: biruungu,
                                        borderRadius: BorderRadius.circular(7)
                                      ),
                                      child: Image.asset("assets/icons/weight.png", scale: 1.3,),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text("Berat\nBadan\nmenurut\nUmur", style: inclusiveSans.copyWith(fontSize: 12, fontWeight: FontWeight.w500,color: Colors.grey[700]),)
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return const TBmenurutUmurPage();
                                }));
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 8, shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ), 
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(0),
                                      width: 80,
                                      height: height,
                                      decoration:BoxDecoration(
                                        color: biruungu,
                                        borderRadius: BorderRadius.circular(7)
                                      ),
                                      child: Image.asset("assets/icons/height.png", scale: 1.3,),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text("Tinggi\nBadan\nmenurut\nUmur", style: inclusiveSans.copyWith(fontSize: 12, fontWeight: FontWeight.w500,color: Colors.grey[700]),)
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return const BBmenurutTBPage();
                                }));
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 8, shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ), 
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(0),
                                      width: 80,
                                      height: height,
                                      decoration:BoxDecoration(
                                        color: biruungu,
                                        borderRadius: BorderRadius.circular(7)
                                      ),
                                      child: Image.asset("assets/icons/hwicon.png", scale: 1.3,),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text("Berat\nBadan\nmenurut\nTinggi Badan", style: inclusiveSans.copyWith(fontSize: 11.5, fontWeight: FontWeight.w500,color: Colors.grey[700]),)
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return const IMTmenurutUmurPage();
                                }));
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 8, shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ), 
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(0),
                                      width: 80,
                                      height: height,
                                      decoration:BoxDecoration(
                                        color: biruungu,
                                        borderRadius: BorderRadius.circular(7)
                                      ),
                                      child: Image.asset("assets/icons/massa.png", scale: 1.3,),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text("Indeks\nMassa Tubuh\nmenurut\nUmur", style: inclusiveSans.copyWith(fontSize: 11.5, fontWeight: FontWeight.w500,color: Colors.grey[700]),)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Blog Kegiatan", style: inclusiveSans.copyWith(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),),
                          TextButton(
                            onPressed: () {
                              
                            },
                            child: Text("Lihat Semua", style: inclusiveSans.copyWith(fontSize: 13, color: biruungu, fontWeight: FontWeight.w700),)
                          )
                        ],
                      ),
                      Container(
                        width: width,
                        height: 240,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          itemCount: artikels.length,
                          itemBuilder: (BuildContext context,index) {
                            final artikel = artikels[index];
                            print(artikel);
                            return Container(
                              margin: const EdgeInsets.only(top: 5, right: 16),
                              width: 300,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15), // Warna latar belakang container
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(255, 232, 232, 232), // Warna bayangan
                                    offset: Offset(0, 2.5), // Offset bayangan (x, y)
                                    blurRadius: 0.5,
                                    spreadRadius: 0.0, // Radius penyebaran bayangan
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                                    child: Image.asset(artikel['gambar'],fit: BoxFit.cover,width: width, height: 135,)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.person,color: Colors.grey[500],size: 16,),
                                            const SizedBox(width: 6,),
                                            Text(artikel['penulis'],style:inclusiveSans.copyWith(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.grey[500]))
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_month,color: Colors.grey[500],size: 16,),
                                            const SizedBox(width: 6,),
                                            Text(artikel['tanggal'],style:inclusiveSans.copyWith(fontSize: 12,fontWeight: FontWeight.w600,color: Colors.grey[500]))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Text(artikel['judul'],style: inclusiveSans.copyWith(fontSize: 15,fontWeight: FontWeight.bold),),
                                  )
                                ],
                              ),
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 20,
              right: 20,
              top: 300,
              child: Container(
                height: 160,
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
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Data Orang Tua", style: inclusiveSans.copyWith(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("100", style: league.copyWith(fontSize: 35, color: biruungu, fontWeight: FontWeight.bold),),
                          const SizedBox(
                            height: 14,
                          ),
                          Text("Data Balita", style: inclusiveSans.copyWith(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("100", style: league.copyWith(fontSize: 35, color: biruungu, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Data Balita Perempuan", style: inclusiveSans.copyWith(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("50", style: league.copyWith(fontSize: 35, color: biruungu, fontWeight: FontWeight.bold),),
                          const SizedBox(
                            height: 14,
                          ),
                          Text("Data Balita Laki-Laki", style: inclusiveSans.copyWith(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("50", style: league.copyWith(fontSize: 35, color: biruungu, fontWeight: FontWeight.bold),),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}