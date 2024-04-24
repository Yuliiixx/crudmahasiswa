class ModelMahasiswa {
  int? _id;
  String? _nama, _noBp, _noHp, _email, _alamat;

  ModelMahasiswa(this._nama, this._noBp, this._noHp, this._email, this._alamat, String text);

  int get id => _id ?? 0;
  String get nama => _nama ?? "";
  String get noBp => _noBp ?? "";
  String get noHp => _noHp ?? "";
  String get email => _email ?? "";
  String get alamat => _alamat ?? "";

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    if (_id != null) {
      map["id"] = _id;
    }
    map["nama"] = _nama;
    map["nobp"] = _noBp;
    map["nohp"] = _noHp;
    map["email"] = _email;
    map["alamat"] = _alamat;
    return map;
  }

  ModelMahasiswa.fromMap(Map<String, dynamic> map) {
    _id = map["id"];
    _nama = map["nama"];
    _noBp = map["nobp"];
    _noHp = map["nohp"];
    _email = map["email"];
    _alamat = map["alamat"];
  }
}
