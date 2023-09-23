import 'package:flutter/material.dart';
import 'package:nutricare/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  padding: const EdgeInsets.only(top: 50, left: 12, right: 20),
                  width: width,
                  height: height * 0.25,
                  decoration: BoxDecoration(
                    color: biruungu,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35))
                  ),
                  child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Hello!", style: mooli.copyWith(fontSize: 30, color: Colors.yellow[600], fontWeight: FontWeight.bold),),
                                  Text("Debi Pramesty", style: inclusiveSans.copyWith(fontSize: 23, color: Colors.white),)
                                ],
                              ),
                              Image.asset("assets/images/avatar.png", width: 35, height: 35,)
                            ],
                          ),
                        ],
                      ),
                      
                ),
                Container(
                  height: 800,
                  width: width,
                  color: Colors.white,
                )
              ],
            ),
            Positioned(
              top: 150,
              left: 30,
              right: 30,
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 100,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                    borderRadius: BorderRadius.circular(8), // Warna latar belakang container
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey, // Warna bayangan
                        offset: Offset(0, 2.5), // Offset bayangan (x, y)
                        blurRadius: 5,
                        spreadRadius:0, // Radius penyebaran bayangan
                      ),
                    ],
                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("72",style: inclusiveSans.copyWith(fontWeight: FontWeight.bold,color: biruungu,fontSize: 42),),
                        const SizedBox(height: 5,),
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text: "Data \n",
                            style: inclusiveSans.copyWith(color: biruungu, fontSize: 15, fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: 'Orang Tua',
                                style: inclusiveSans.copyWith(fontWeight: FontWeight.w500, color: biruungu, fontSize: 12,),
                              )
                            ]
                          )
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("15",style: inclusiveSans.copyWith(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 42),),
                        const SizedBox(height: 5,),
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text: "Data \n",
                            style: inclusiveSans.copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: 'Balita',
                                style: inclusiveSans.copyWith(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 12,),
                              )
                            ]
                          )
                        ),
                      ],
                    ),
                   Container(
                    height: height,
                    width: 1,
                    color: Colors.grey[300],
                   ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("58",style: inclusiveSans.copyWith(fontWeight: FontWeight.bold,color: biruungu,fontSize: 42),),
                        const SizedBox(height: 5,),
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text: "Data Balita\n",
                            style: inclusiveSans.copyWith(color: biruungu, fontSize: 15, fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: 'laki-laki',
                                style: inclusiveSans.copyWith(fontWeight: FontWeight.w500, color: biruungu, fontSize: 12,),
                              )
                            ]
                          )
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("7",style: inclusiveSans.copyWith(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 42),),
                        const SizedBox(height: 5,),
                        Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text: "Data Balita\n",
                            style: inclusiveSans.copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                            children: [
                              TextSpan(
                                text: 'Perempuan',
                                style: inclusiveSans.copyWith(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 12,),
                              )
                            ]
                          )
                        ),
                      ],
                    ),
                  ],
                ),
               ),
            )
          ],
        ),
      ),
    );
  }
}