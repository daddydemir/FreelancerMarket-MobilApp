// ignore_for_file: must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables, no_logic_in_create_state, duplicate_ignore, camel_case_types, prefer_final_fields, unused_field, unnecessary_null_comparison, dead_code, avoid_print, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freelancer_market/screens/Components/loading.dart';
import 'package:freelancer_market/screens/user/password_change.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/freelancer.dart';
import '../../service/user/freelancerService.dart';



class UserEdit extends StatefulWidget {
  UserEdit({Key? key , required this.UserId}) : super(key: key);

  var UserId;
  @override
  State<StatefulWidget> createState() => _userEditState(UserId);
}


class _userEditState extends State {
  _userEditState(this.index);
  var index;

  var isim = TextEditingController();
  var soyisim = TextEditingController();
  var about = TextEditingController();
  var email = TextEditingController();
  var appellation = TextEditingController();

  var service = FreelancerService();
  var _picker = ImagePicker();
  File file = File("");
  var user;

  uploadImage() async {
    await service.imageUpdate(file);
  }

  getImage() async {
    final XFile? selectedFile = await _picker.pickImage(source:ImageSource.gallery);
    file = File(selectedFile!.path);
    user.imagePath = file.path;
    uploadImage();
    setState((){});
  }

  Future<void> _veriGetir() async {
    user = await service.getUser(index);
    setState(() {});
  }

  @override
  initState() {
    _veriGetir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f5f7),
      body: user == null 
          ? Center(child: LoadAnim())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 7, top: 7, right: 7),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.white,
                  shadowColor: Colors.black,
                  elevation: 20,
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              resim(user.imagePath),
                              kullaniciIsmi(user.username),
                              Yazi("Ad"),
                              _isim(user.name),
                              Yazi("Soyad"),
                              _soyisim(user.surname),
                              Yazi("Mail"),
                              _mail(user.email),
                              Yazi("Unvan"),
                              _unvan(user.appellation),
                              Yazi("Hakkımda"),
                              _hakkimda(user.about),
                              Parola(),
                              Kaydet(),
                            ]),
                      )),
                ),
              )),
            ),
    );
  }

  
  Center Kaydet() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xff201a3d)),
          ),
          onPressed: () async {
            Freelancer freelancer = Freelancer.empty();
            isim.text.isNotEmpty ? freelancer.name = isim.text : freelancer.name = user.name;
            soyisim.text.isNotEmpty ? freelancer.surname = soyisim.text : freelancer.surname = user.surname; 
            email.text.isNotEmpty ? freelancer.email = email.text : freelancer.email = user.email;
            appellation.text.isNotEmpty ? freelancer.appellation = appellation.text : freelancer.appellation = user.appellation;
            about.text.isNotEmpty ? freelancer.about = about.text : freelancer.about = user.about;
            
            var response = await service.updateUser(freelancer);
            final snackbar;
            if(response){
               snackbar = SnackBar(
                backgroundColor: Colors.greenAccent,
                content:Text("Başarıyla güncellendi."),
              );
            }
            else{
              snackbar = SnackBar(content:Text("Güncelleme başarısız oldu."), backgroundColor: Colors.redAccent,);
            }
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          },
          child: const Text('KAYDET',
              style: TextStyle(
                fontSize: 20,
              )),
        ),
      ),
    );
  }

  Padding _hakkimda(var h) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: TextField(
        controller: about,
        textInputAction: TextInputAction.next,
        maxLines: null,
        minLines: 5,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: h,
          fillColor: const Color(0xfff4f5f7),
          filled: true,
        ),
      ),
    );
  }

  
  Padding Yazi(var name) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, top: 15),
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
        ));
  }


  Padding Parola() {
    return Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PasswordChangePage()));
          },
          child: Row(
            children: const [
              Icon(
                Icons.security,
                size: 20,
                color: Colors.green,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  "Parola'yı Güncelle",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Padding _unvan(var s) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
      controller:appellation,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: s,
          fillColor: const Color(0xfff4f5f7), // 8b95a1
          filled: true,
        ),
      ),
    );
  }

  Padding _mail(var s) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller:email,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: s,
          fillColor: const Color(0xfff4f5f7),
          filled: true,
        ),
      ),
    );
  }

  Padding _soyisim(var s) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller:soyisim,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: s,
          fillColor: const Color(0xfff4f5f7),
          filled: true,
        ),
      ),
    );
  }

  Padding _isim(var i) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller:isim,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xfff4f5f7), width: 2),
            borderRadius: BorderRadius.circular(25),
          ),
          hintText: i,
          fillColor: const Color(0xfff4f5f7),
          filled: true,
        ),
      ),
    );
  }

  Center kullaniciIsmi(var k) {
    return Center(
      child: Text(
        k,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Center resim(String pr) {
    if(file.path != ""){
      return Center(
        child:Stack(
          children:[
            Align(
              child:ClipOval(child: SizedBox.fromSize(
              size: const Size.fromRadius(70),
              child: Image.file(
                file,
                fit: BoxFit.cover,
              ),
            ),),
            ),
             Padding(
          padding: const EdgeInsets.only(left:110),
          child:Align(
            alignment:Alignment.topCenter,
            child:IconButton(
              icon:const Icon(Icons.add_a_photo_outlined),
              iconSize:40,
              color: const Color(0xffe83c5f),
              onPressed:(){
                getImage();
              }
            ),
          ),
        ),
          ],
        ),
      );
    }else{
      return Center(
      child: Stack(children: [
        
        Align(
          child: ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(70),
              child: Image.network(
                pr,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left:110),
          child:Align(
            alignment:Alignment.topCenter,
            child:IconButton(
              icon:const Icon(Icons.add_a_photo_outlined),
              iconSize:40,
              color: const Color(0xffe83c5f),
              onPressed:(){
                getImage();
              }
            ),
          ),
        ),
      ]),
    );
    }
  }

}
