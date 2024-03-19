import 'package:flutter/material.dart';
import 'Form.dart';
import 'Model.dart';
import 'api.dart';

class ApiDataPage extends StatefulWidget {
  @override
  State<ApiDataPage> createState() => _ApiDataPageState();
}

class _ApiDataPageState extends State<ApiDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'CRUD USING API',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return AddInAPI();
                },
              )).then((value) {
                setState(() {});
              });
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: api().getDetails(),
        builder: (context, snapshot1) {
          if (snapshot1.hasData) {
            if (!snapshot1.data!.isEmpty) {
              List<Model>? myList = snapshot1.data;
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: myList!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            child: Column(
                              children: [
                                Image.network(myList[index].image),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        myList[index].name,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) {
                                            return AddInAPI(
                                                id: myList[index].id,
                                                name: myList[index].name,
                                                image: myList[index].image);
                                          },
                                        )).then((value) {
                                          setState(() {});
                                        });
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    IconButton(
                                      onPressed: () async {
                                        await api()
                                            .deletByid(myList[index].id)
                                            .then((value) => setState(() {}));
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text("List Is Empty."));
            }
          } else if (snapshot1.hasError) {
            print(snapshot1.error);
            return Center(child: Text('Error'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
