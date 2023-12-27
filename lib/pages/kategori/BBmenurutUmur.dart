import 'package:flutter/material.dart';
import 'package:nutricare/components/DropdownKategori.dart';
import 'package:nutricare/theme.dart';

class BBmenurutUmurPage extends StatefulWidget {
  const BBmenurutUmurPage({super.key});

  @override
  State<BBmenurutUmurPage> createState() => _BBmenurutUmurPageState();
}

class _BBmenurutUmurPageState extends State<BBmenurutUmurPage> {
   final List categories = [
    'Berat badan sangat kurang',
    'Berat badan kurang',
    'Berat badan normal',
    'Risiko Berat badan lebih',
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: biruungu,
        title: Text('Berat Badan\nMenurut Umur', style: inclusiveSans.copyWith(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        centerTitle: true,
        elevation: 5,
        shadowColor: biruungu,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                style: inclusiveSans,
                decoration: InputDecoration(
                    hintText: 'Cari Data Balita..',
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
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(biruungu),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)
                            )
                          )
                        ), 
                        child: Text("All", style: inclusiveSans.copyWith(fontSize: 15, fontWeight: FontWeight.bold),)
                      ),
                    ),
                    const SizedBox(width: 10,),
                    DropdownKategori(categories: categories,)
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  width: width,
                  height: height - 350,
                  child: ListView.builder(
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: width,
                        height: 85,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 232, 232, 232),
                            width: 1
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8), // Warna latar belakang container
                          
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              flex: 2,
                              child: Container(
                                width: 63,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: biruungu,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8))
                                ),
                                child: Image.asset("assets/icons/baby.png", scale: 1.7,),
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              flex: 4,
                              child: Container(
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Lanang Surya Darma", style: inclusiveSans.copyWith(color: Colors.black87),),
                                    Row(
                                      children: [
                                        Text("BB : 10kg",style: poppins.copyWith(color: Colors.grey[600],fontSize: 11,),),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text("TB : 90cm",style: poppins.copyWith(color: Colors.grey[600],fontSize: 11,),),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 3),
                                      width: 100,
                                      height: 27,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: kuningapp,
                                      ),
                                      child: Center(child: Text("Sangat Kurang", style: inclusiveSans.copyWith(color: Colors.black, fontSize: 11,),)),
                                    )
                                  ],
                                ),
                              ),
                            ),
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
    );
  }
}