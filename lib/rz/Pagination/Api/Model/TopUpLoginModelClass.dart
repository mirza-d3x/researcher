import 'dart:convert';
/// success : 6000
/// data : {"refresh":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY3OTQ4NDIxMiwiaWF0IjoxNjc5Mzk3ODEyLCJqdGkiOiJmMTA0OWE5ZjE0ZTY0MDNkYmVkNGM0ODY0MzVhMWU2OCIsInVzZXJfaWQiOjF9.szuAZdpKW_Pm-bMsyz1mnkCtj0nSmVBAFE8ec7Lz-7U","access":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjc5Mzk4MTEyLCJpYXQiOjE2NzkzOTc4MTIsImp0aSI6Ijg0OTg2NDliOTI1MTRjNmNhZGM4NDQ4NDQzMDUwMDBmIiwidXNlcl9pZCI6MX0.x5ilhriW9rudvjhWwE8f2J4MrS4dhBq7P26SZL_kp5Q","user_id":1,"role":"superuser","username":"topup","email":"","last_login":"2023-03-21 11:23:31.600694+00:00"}
/// user_id : 1
/// role : "superuser"
/// message : "Login successfully"
/// error : null
/// username : "topup"

TopUpLoginModelClass topUpLoginModelClassFromJson(String str) => TopUpLoginModelClass.fromJson(json.decode(str));
String topUpLoginModelClassToJson(TopUpLoginModelClass data) => json.encode(data.toJson());
class TopUpLoginModelClass {
  TopUpLoginModelClass({
      num? success, 
      Data? data, 
      num? userId, 
      String? role, 
      String? message, 
      dynamic error, 
      String? username,}){
    _success = success;
    _data = data;
    _userId = userId;
    _role = role;
    _message = message;
    _error = error;
    _username = username;
}

  TopUpLoginModelClass.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _userId = json['user_id'];
    _role = json['role'];
    _message = json['message'];
    _error = json['error'];
    _username = json['username'];
  }
  num? _success;
  Data? _data;
  num? _userId;
  String? _role;
  String? _message;
  dynamic _error;
  String? _username;
TopUpLoginModelClass copyWith({  num? success,
  Data? data,
  num? userId,
  String? role,
  String? message,
  dynamic error,
  String? username,
}) => TopUpLoginModelClass(  success: success ?? _success,
  data: data ?? _data,
  userId: userId ?? _userId,
  role: role ?? _role,
  message: message ?? _message,
  error: error ?? _error,
  username: username ?? _username,
);
  num? get success => _success;
  Data? get data => _data;
  num? get userId => _userId;
  String? get role => _role;
  String? get message => _message;
  dynamic get error => _error;
  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['user_id'] = _userId;
    map['role'] = _role;
    map['message'] = _message;
    map['error'] = _error;
    map['username'] = _username;
    return map;
  }

}

/// refresh : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY3OTQ4NDIxMiwiaWF0IjoxNjc5Mzk3ODEyLCJqdGkiOiJmMTA0OWE5ZjE0ZTY0MDNkYmVkNGM0ODY0MzVhMWU2OCIsInVzZXJfaWQiOjF9.szuAZdpKW_Pm-bMsyz1mnkCtj0nSmVBAFE8ec7Lz-7U"
/// access : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjc5Mzk4MTEyLCJpYXQiOjE2NzkzOTc4MTIsImp0aSI6Ijg0OTg2NDliOTI1MTRjNmNhZGM4NDQ4NDQzMDUwMDBmIiwidXNlcl9pZCI6MX0.x5ilhriW9rudvjhWwE8f2J4MrS4dhBq7P26SZL_kp5Q"
/// user_id : 1
/// role : "superuser"
/// username : "topup"
/// email : ""
/// last_login : "2023-03-21 11:23:31.600694+00:00"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? refresh, 
      String? access, 
      num? userId, 
      String? role, 
      String? username, 
      String? email, 
      String? lastLogin,}){
    _refresh = refresh;
    _access = access;
    _userId = userId;
    _role = role;
    _username = username;
    _email = email;
    _lastLogin = lastLogin;
}

  Data.fromJson(dynamic json) {
    _refresh = json['refresh'];
    _access = json['access'];
    _userId = json['user_id'];
    _role = json['role'];
    _username = json['username'];
    _email = json['email'];
    _lastLogin = json['last_login'];
  }
  String? _refresh;
  String? _access;
  num? _userId;
  String? _role;
  String? _username;
  String? _email;
  String? _lastLogin;
Data copyWith({  String? refresh,
  String? access,
  num? userId,
  String? role,
  String? username,
  String? email,
  String? lastLogin,
}) => Data(  refresh: refresh ?? _refresh,
  access: access ?? _access,
  userId: userId ?? _userId,
  role: role ?? _role,
  username: username ?? _username,
  email: email ?? _email,
  lastLogin: lastLogin ?? _lastLogin,
);
  String? get refresh => _refresh;
  String? get access => _access;
  num? get userId => _userId;
  String? get role => _role;
  String? get username => _username;
  String? get email => _email;
  String? get lastLogin => _lastLogin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refresh'] = _refresh;
    map['access'] = _access;
    map['user_id'] = _userId;
    map['role'] = _role;
    map['username'] = _username;
    map['email'] = _email;
    map['last_login'] = _lastLogin;
    return map;
  }

}