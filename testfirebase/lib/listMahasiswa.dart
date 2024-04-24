import 'package:flutter/material.dart';
import 'package:testfirebase/addMahasiswa.dart';
import 'package:testfirebase/databaseHelper.dart';
import 'package:testfirebase/modelMahasiswa.dart';


class ListMahasiswa extends StatefulWidget {
  const ListMahasiswa({Key? key, required String title}) : super(key: key);

  @override
  State<ListMahasiswa> createState() => _ListMahasiswaState();
}

class _ListMahasiswaState extends State<ListMahasiswa> {
  DatabaseHelper db = DatabaseHelper();
  List<ModelMahasiswa> itemList = [];

  @override
  void initState() {
    super.initState();
    db.getAllMahasiswa().then((value) {
      setState(() {
        for (var item in value!) {
          itemList.add(ModelMahasiswa.fromMap(item));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Mahasiswa"),
        backgroundColor: Colors.green,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMahasiswa()));
            },
            icon: const Icon(Icons.add, color: Colors.white),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          ModelMahasiswa data = itemList[index];
          return Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Card(
              child: ListTile(
                trailing: IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => AddMahasiswa(data: data)));
                  },
                  icon: const Icon(Icons.edit, color: Colors.black),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Anda yakin menghapus data ${data.nama}"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              db.deleteMahasiswa(data.id).then((_) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (_) => const ListMahasiswa(title: '',)),
                                  (route) => false,
                                );
                              });
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      );
                    },
                  );
                },
                title: Text(data.nama),
                subtitle: Text(data.email),
              ),
            ),
          );
        },
      ),
    );
  }
}
