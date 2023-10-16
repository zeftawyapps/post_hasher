import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:post_hasher/screens/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var controller = TextEditingController();
  String text = '';
  List<String> listofitems = [];
  SharedPreferences? prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        // add dialog to show about
                        showDialog(
                            context: context,
                            builder: (c) {
                              return DialogSettings();
                            }).then((value) {
                          setState(() {
                            listofitems =
                                prefs!.getStringList('listofitems') ?? [];
                          });
                        });
                        ;
                      },
                      icon: const Icon(Icons.settings),
                    ),
                  ),
                  const Text(
                    'Post Hasher',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  // add 5 line text input  and button   and text
                  TextField(
                    controller: controller,
                    minLines: 7,
                    maxLines: 15,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your text',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        text = controller.text;
                        if (text.isNotEmpty) {
                          text = hashPost(text);
                        }
                      });
                    },
                    child: const Text('Hash it!'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Text(text)),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // copy to clipbord
                      Clipboard.setData(ClipboardData(text: text));
                      // toast coppyed
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Copied to Clipboard')),
                      );
                    },
                    child: const Text('Copy to clipboard'),
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }

  String hashPost(String text) {
//hash the text based on listofItems
    for (var item in listofitems) {
      text = text.replaceAll(item, hasCutter(item));
    }
    return text;
    ;
  }

  String hasCutter(String item) {
    var hashlist = ["  ", "-", "_",  ];
    // cut the text letters and add # before it
    int l = item.length - 1;
    // create rondom number based ont l
    var rnd = new Random();
    int r = rnd.nextInt(l);
    int r2 = rnd.nextInt(hashlist.length);
    String text  ="";
switch(l){
  case 3 :
    String t = item [2];
    text = item.replaceAll(t , t +  hashlist[r2]);
    return text ;
  case > 3 && <= 5 :
    String t = item [2];
    String t2 = item [4];

    text = item.replaceAll(t,t +  hashlist[r2]);
      r2 = rnd.nextInt(hashlist.length);
    String   text2 = text.replaceAll(t2, t2+ hashlist[r2]);
    return text2 ;
  case > 5 && <= 9 :
    String t = item [2];
    String t2 = item [4];

    String t3 = item [6];
    text = item.replaceAll(t, t+ hashlist[r2]);
    r2 = rnd.nextInt(hashlist.length);
  String   text2 = text.replaceAll(t2, t2 +  hashlist[r2]);
    r2 = rnd.nextInt(hashlist.length);
   String  text3 = text2.replaceAll( t3, t3 +  hashlist[r2]);
 return text3 ;
}


     return text ;
  }

  void loadList() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      listofitems = prefs!.getStringList('listofitems') ?? [];
    });
  }
}
