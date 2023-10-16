import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DialogSettings extends StatefulWidget {
  const DialogSettings({super.key});

  @override
  State<DialogSettings> createState() => _DialogSettingsState();
}

class _DialogSettingsState extends State<DialogSettings> {
  List<String> listofitems = [];
  var controller = TextEditingController();
   SharedPreferences? prefs;
  @override
  void initState() {
    // TODO: implement initState
    loadList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      height: 300,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              'Hashed Words',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
                child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your text',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        String text = controller.text;
                        if (text.isNotEmpty) {
                          var isExist = listofitems.contains(text);
                          if (!isExist) {
                            listofitems.add('${controller.text}');
                          }
                          controller.clear();
                        }
                      });
                    },
                    icon: Icon(Icons.add),
                  )
                ],
              ),
            )),
            Expanded(
                flex:3,
                child: ListView.builder(
                  itemBuilder: (c, i) {
                    return ListTile(
                      title: Text(listofitems[i]),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            listofitems.removeAt(i);
                          });
                        },
                        icon: Icon(Icons.delete),
                      ),
                    );
                  },
                  itemCount: listofitems.length,
                )) ,
            // save button
            ElevatedButton(onPressed: ()async{
              prefs!.setStringList('listofitems', listofitems);
              Navigator.pop(context);
            }, child: Text('Save'))
          ],
        ),
      ),
    ));
  }
  void loadList()async{
      prefs = await SharedPreferences.getInstance();
      setState(() {
        listofitems = prefs!.getStringList('listofitems')??[];
      });
  }
  }

