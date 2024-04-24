import 'package:flutter/material.dart';
import 'package:testfirebase/databaseHelper.dart';
import 'package:testfirebase/listMahasiswa.dart';
import 'package:testfirebase/modelMahasiswa.dart';

class AddMahasiswa extends StatefulWidget {
  final ModelMahasiswa? data;

  const AddMahasiswa({Key? key, this.data}) : super(key: key);

  @override
  State<AddMahasiswa> createState() => _PageAddMahasiswaState();
}

class _PageAddMahasiswaState extends State<AddMahasiswa> {
  DatabaseHelper db = DatabaseHelper();

  TextEditingController nama = TextEditingController();
  TextEditingController noBp = TextEditingController();
  TextEditingController noHp = TextEditingController();
  TextEditingController email = TextEditingController();

  //proses do in background
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nama = TextEditingController(text: widget.data?.nama);
    noBp = TextEditingController(text: widget.data?.noBp);
    noHp = TextEditingController(text: widget.data?.noHp);
    email = TextEditingController(text: widget.data?.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data?.id != null ? "Update Pegawai" : "Add Pegawai"),
        backgroundColor: Colors.green,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 14),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nama,
                decoration: const InputDecoration(hintText: "Nama"),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: noBp,
                decoration: const InputDecoration(hintText: "no Bp"),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: noHp,
                decoration: const InputDecoration(hintText: "no Hp"),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(hintText: "Email"),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () {
                  if (widget.data?.id != null) {
                    db
                        .updateMahasiswa(ModelMahasiswa.fromMap({
                      "id": widget.data?.id,
                      "nama": nama.text,
                      "no Bp": noBp.text,
                      "no Hp": noHp.text,
                      "email": email.text,
                      // Mengisi argumen yang diperlukan
                      "_alamat": "", // Misalnya alamat kosong
                      "text": "", // Misalnya teks kosong
                    }))
                        .then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ListMahasiswa(title: 'Mahasiswa')),
                          (route) => false);
                    });
                  } else {
                    db
                        .saveMahasiswa(ModelMahasiswa(
                            nama.text, noBp.text, noHp.text, email.text,
                            "", "")) // Mengisi argumen yang diperlukan
                        .then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ListMahasiswa(title: 'Mahasiswa')),
                          (route) => false);
                    });
                  }
                },
                minWidth: 200,
                color: Colors.green,
                height: 45,
                child: Text(widget.data?.id != null ? "EDIT" : "SIMPAN"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
