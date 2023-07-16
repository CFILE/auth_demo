import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utility/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

 int currentIndex=3;
 final TextStyle styleBarItems=const TextStyle(fontSize: 10, color: Colors.black) ;
 void _clickBarItem(e){
   setState(() {
     currentIndex=e;
   });
 }
 void _logOut(){
   Const.user!={};
   Navigator.of(context, rootNavigator: false).pushNamed("/");
 }
 BottomNavigationBarItem _barItem(String svg, String label)=> BottomNavigationBarItem(
     icon: Padding(
       padding: const EdgeInsets.only(bottom: 4),
       child: SizedBox(width: 18, height: 18, child: SvgPicture.asset("assets/images/$svg.svg")),
     ),
     label:label
 );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           title: const Text("Профайл"),
          automaticallyImplyLeading: false,
        ),
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
               mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 30),
                  Center(
                    child: SvgPicture.asset("assets/images/ava_profile.svg", width: 64, height: 64),
                  ),
                  const SizedBox(height: 10),
                  Text(Const.user['nickname']!.split(' ').map((w) => w.capitalize()).join(' '),
                    style: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.w900 ),),
                  Text(Const.user['email']??"Нет информации", style: const TextStyle(fontSize: 16, color: Color(0xFF929292) ),),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: _logOut,
                    child: Container(
                      padding: const EdgeInsets.only(left:24),
                      color: Colors.white,
                      height: 55,
                      width: double.infinity,
                      child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Выйти", style: TextStyle(fontSize: 16, color: Color(0xFFEC3A4D) ),)),
                    ),
                  )
                ]
              ),
            ),
          ),
        ),
        bottomNavigationBar:BottomNavigationBar(
          onTap: _clickBarItem,
          backgroundColor:Colors.white,
          selectedLabelStyle: styleBarItems,
          unselectedLabelStyle: styleBarItems,
          selectedItemColor:Colors.black,
          unselectedItemColor: Colors.black,
          showSelectedLabels:true,
          showUnselectedLabels: true,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items:  [
            _barItem("icon_1","Лента"),
            _barItem("icon_2","Карта"),
            _barItem("icon_3","Избранное"),
            _barItem("icon_4","Профиль"),
          ],
        )
    );
  }

}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
