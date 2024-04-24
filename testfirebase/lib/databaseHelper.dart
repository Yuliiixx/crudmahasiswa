
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:testfirebase/modelMahasiswa.dart';

class DatabaseHelper {
  final String tabelMahasiswa = "tbmahasiswa";
  final String columnId = "id";
  final String columnNama = "nama";
  final String columnNoBp = "nobp";
  final String columnNoHp = "nohp";
  final String columnEmail = "email";
  final String columnAlamat = "alamat";

  Database? db;

  Future<Database?> cekDatabase() async {
    if (db != null) {
      return db;
    }
    db = await initDb();
    return db;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, "mahasiswa.db");
    var db = openDatabase(path, version: 1, onCreate: onCreate);
    return db;
  }

  void onCreate(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $tabelMahasiswa(
        $columnId INTEGER PRIMARY KEY,
        $columnNama TEXT,
        $columnNoBp TEXT,
        $columnNoHp TEXT,
        $columnEmail TEXT,
        $columnAlamat TEXT
      )
    ''');
  }

  Future<int?> saveMahasiswa(ModelMahasiswa mahasiswa) async {
    var dbClient = await cekDatabase();
    var result = dbClient!.insert(tabelMahasiswa, mahasiswa.toMap());
    print("insert data $result");
    return result;
  }

  Future<List?> getAllMahasiswa() async {
    var dbClient = await cekDatabase();
    var result = await dbClient!.query(tabelMahasiswa, columns: [
      columnId,
      columnNama,
      columnNoBp,
      columnNoHp,
      columnEmail,
      columnAlamat
    ]);
    return result;
  }

  Future<int?> updateMahasiswa(ModelMahasiswa mahasiswa) async {
    var dbClient = await cekDatabase();
    var result = dbClient!.update(tabelMahasiswa, mahasiswa.toMap(),
        where: "$columnId = ?", whereArgs: [mahasiswa.id]);
    return result;
  }

  Future<int?> deleteMahasiswa(int id) async {
    return await db!.delete(tabelMahasiswa, where: "$columnId = ?", whereArgs: [id]);
  }
}
