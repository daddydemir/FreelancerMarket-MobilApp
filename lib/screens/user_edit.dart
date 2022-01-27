import 'package:flutter/material.dart';

class UserEdit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _userEditState();
  }
}

class _userEditState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f5f7),body: Padding(
        padding: EdgeInsets.all(16),
        child: Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: 7, top: 7, right: 7),
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
                        Center(
                            child: Image.network(
                          "https://res.cloudinary.com/metcloud/image/upload/v1636485499/user_el1kyd.png",
                          width: 120,
                        )),
                        const Center(
                          child: Text(
                            "DemirX",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Ad",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xfffefefe), width: 2),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xfffefefe), width: 2),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              hintText: 'Mehmet',
                              fillColor: Colors.blueGrey[100],
                              filled: true,
                            ),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              "Soyad",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xfffefefe), width: 2),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xfffefefe), width: 2),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              hintText: 'Çakmaktaşı',
                              fillColor: Colors.blueGrey[100],
                              filled: true,
                            ),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              "Parola",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xfffefefe), width: 2),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xfffefefe), width: 2),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              hintText: 'password1234',
                              fillColor: Colors.blueGrey[100],
                              filled: true,
                            ),
                          ),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(left: 20, top: 20),
                            child: Text(
                              "Hakkımda",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            )),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: TextField(
                            maxLines: null,
                            minLines: 5,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xfffefefe), width: 2),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xfffefefe), width: 2),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              hintText: 'i am a hacker & developer ',
                              fillColor: Colors.blueGrey[100],
                              filled: true,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff3a65aa)),
                              ),
                              onPressed: () {
                                print("saygıya saygı");
                              },
                              child: const Text('KAYDET',
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                            ),
                          ),
                        ),
                      ]),
                )),
          ),
        )),
      ),
    );
  }
}
