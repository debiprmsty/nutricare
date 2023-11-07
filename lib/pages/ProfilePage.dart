import 'package:flutter/material.dart';
import 'package:nutricare/api/user.dart';
import 'package:nutricare/auth/LoginPage.dart';
import 'package:nutricare/models/User.dart';
import 'package:nutricare/pages/DetailProfilePage.dart';
import 'package:nutricare/pages/GetStarted.dart';
import 'package:nutricare/theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserController _userController = UserController();

  User _activeUser = User(id: 0, fullname: "", role: "", image: "",no_hp: "",email: "");

  @override
  void initState() {
    super.initState();
    _userController.fetchUser().then((value) => {
      if(value != null) {
        setState(() {
          _activeUser = User(id: value["id"], fullname: value["fullname"], role: value['role'], image: value['image'], no_hp: value['no_hp'], email: value['email']);
        })
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 50),
              width: width,
              height: height * 0.25 + 300,
              color: biruungu,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(_activeUser.role, style: inclusiveSans.copyWith(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),),
                  const SizedBox(
                    height: 15,
                  ),
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: _activeUser.image != "" ? NetworkImage("https://testchairish.000webhostapp.com/api/user-image/${_activeUser.image}",) : NetworkImage("https://afpertise.com/media/2020/09/Member-1.jpg",) ,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(_activeUser.fullname, style: inclusiveSans.copyWith(fontSize: 18, color: Colors.white),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mail_outline, color: Colors.white, size: 15,),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("${_activeUser.email}", style: inclusiveSans.copyWith(fontSize: 15, color: Colors.white),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone_outlined, color: Colors.white, size: 15,),
                      const SizedBox(
                        width: 5,
                      ),
                      Text("${_activeUser.no_hp}", style: poppins.copyWith(fontSize: 15, color: Colors.white),),
                    ],
                  )
                  
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(18),
              width: width,
              height: 530,
              margin: const EdgeInsets.only(top: 280),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: SizedBox(
                      width: width,
                      height: 110,
                      child: Card(
                        color: Colors.white,
                        elevation: 3,
                        shape: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 17, right: 17, top: 17),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Account", style: inclusiveSans.copyWith(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),),
                              const SizedBox(
                                height: 23,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Profile Setting", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.black),),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return const DetailProfilePage();
                                      }));
                                    },
                                    child: Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 17,)
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: width,
                    height: 315,
                    child: Card(
                      color: Colors.white,
                      elevation: 3,
                      shape: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 17, right: 17, top: 17),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Support", style: inclusiveSans.copyWith(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),),
                            const SizedBox(
                              height: 23,
                            ),
                            GestureDetector(
                              onTap: () {
                                
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Term of Service", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.black),),
                                  Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 17,),
                                ],
                              ),
                            ),
                            Divider(
                              height: 30,
                              thickness: 2,
                              color: Colors.grey[300],
                            ),
                            GestureDetector(
                              onTap: () {
                                
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Data Policy", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.black),),
                                  Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 17,),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Divider(
                              height: 30,
                              thickness: 2,
                              color: Colors.grey[300],
                            ),
                            GestureDetector(
                              onTap: () {
                                
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("About", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.black),),
                                  Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 17,),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Divider(
                              height: 30,
                              thickness: 2,
                              color: Colors.grey[300],
                            ),
                            GestureDetector(
                              onTap: () {
                                
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Help / FAQ", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.black),),
                                  Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 17,),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Divider(
                              height: 30,
                              thickness: 2,
                              color: Colors.grey[300],
                            ),
                            GestureDetector(
                              onTap: () {
                                
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Contact us", style: inclusiveSans.copyWith(fontSize: 17, color: Colors.black),),
                                  Icon(Icons.arrow_forward_ios_sharp, color: Colors.black, size: 17,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 200,
                      height: 40,
                      child: FilledButton(
                        onPressed: () {
                          showDialog(context: context, builder: (BuildContext context) {
                           return AlertDialog(
                              
                                title: Text('Keluar dari Akun ini ?',textAlign: TextAlign.center,style: inclusiveSans.copyWith(fontWeight: FontWeight.bold,color: Colors.black),),
                                backgroundColor: Colors.white,
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                actions: [
                                  ElevatedButton(style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(biruungu)
                                  ), onPressed: ()async{
                                    await _userController.logout();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Anda berhasil logout !'),
                                        duration: Duration(seconds: 2), // Durasi notifikasi
                                      ),
                                    );
                                     Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => AwalPageRole()),
                                      );
                                  }, child: Text("iya",style: inclusiveSans.copyWith(fontSize: 14),)),
                                  ElevatedButton(style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(biruungu)
                                  ), onPressed: (){
                                    Navigator.of(context).pop();
                                  }, child: Text("tidak",style: inclusiveSans.copyWith(fontSize: 14),)),
                                ],
                              );
                          });
                          // Navigator.push(context, MaterialPageRoute(builder: (context){
                          //   return const LoginPagePetugas();
                          // }));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(biruungu)
                        ), 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout_sharp, color: Colors.white, size: 20,),
                            const SizedBox(
                              width: 8,
                            ),
                            Text("Log Out", style: inclusiveSans.copyWith(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),),
                          ],
                        )),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}