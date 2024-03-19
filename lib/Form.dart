import 'package:flutter/material.dart';
import 'Model.dart';
import 'api.dart';

class AddInAPI extends StatefulWidget {
  String? id;
  String? name;
  String? image;

  AddInAPI({this.id, this.name, this.image});

  @override
  State<AddInAPI> createState() => _AddInAPIState();
}

class _AddInAPIState extends State<AddInAPI> {
  TextEditingController name = TextEditingController();
  TextEditingController image = TextEditingController();

  Widget build(BuildContext context) {
    name.text = widget.name ?? '';
    image.text = widget.image ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Form',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(hintText: 'Enter Name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: image,
                    decoration: InputDecoration(hintText: 'Enter Image'),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () async {
                  Model model = Model();
                  model.name = name.text;
                  model.image = image.text;
                  if (widget.id == null) {
                    await api().insertData(model.toMap());
                    Navigator.of(context).pop(true);
                  } else {
                    await api().updateData(model.toMap(), widget.id!);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Submit')),
          )
        ],
      ),
    );
  }
}
