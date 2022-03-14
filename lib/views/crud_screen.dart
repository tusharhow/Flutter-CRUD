import 'package:crypto_fate/controllers/crud_controller.dart';
import 'package:crypto_fate/models/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoScreen extends StatefulWidget {
  CryptoScreen({Key? key}) : super(key: key);

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  Future<List<UserModel>>? userModel;
  @override
  void initState() {
    super.initState();
    userModel = Provider.of<UserController>(context, listen: false).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final val = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('User CRUD'),
        backgroundColor: Colors.redAccent,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Consumer<UserController>(builder: (context, value, _) {
              return FutureBuilder<List<UserModel>>(
                  future: userModel,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: val.data.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: EdgeInsets.all(10),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Name: ${val.data[index].name}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Age: ${val.data[index].age.toString()}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.redAccent),
                                        onPressed: () {
                                          Provider.of<UserController>(context,
                                                  listen: false)
                                              .deleteUser(
                                                  snapshot.data![index].id);
                                          setState(() {
                                            userModel =
                                                Provider.of<UserController>(
                                                        context,
                                                        listen: false)
                                                    .getUsers();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return Text(snapshot.error.toString());
                    }
                  });
            }),
            ElevatedButton(
              onPressed: () {
                Provider.of<UserController>(context, listen: false)
                    .addUser(
                        UserModel(id: 52.toString(), name: "Tushar", age: 20))
                    .then((value) {
                  setState(() {
                    userModel =
                        Provider.of<UserController>(context, listen: false)
                            .getUsers();
                  });
                });
              },
              child: Text('Add User'),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
