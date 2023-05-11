import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:customer/Login.dart';
import 'package:customer/component/fom.dart';
import 'package:customer/setting.dart';

Future attendance(BuildContext context) async {
  try {
    FormData formData = FormData.fromMap({});
    var response = await Dio().post('$url/api/sales/attendance',
        data: formData,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $key",
        }));
    var error = response.data["message"];
    alarm(context, error);
    print(response.data);
    if (response.statusCode == 200) {
      await cekAbsen(context);
      return true;
    }
    return false;
  } on DioError catch (e) {
    print(e);
    if (e.response?.statusCode == 400) {
      return false;
    }
  }
}

Future kunjungan(String id, BuildContext context) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    FormData formData = FormData.fromMap({
      "pelanggan_id": id,
    });
    var response = await Dio().post('$url/api/sales/kunjungan',
        data: formData,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $key",
        }));
    print(response.data);
    if (response.statusCode == 200) {
      print(response.data);
      alarm(context, response.data["message"]);
      await cekKunjungan(context);
      // user = response.data["data"]["user"];
      // key = response.data["data"]["token"];
      return true;
    }
    var error = response.data["message"];
    alarm(context, error);
    return false;
  } on DioError catch (e) {
    // print(e);
    if (e.response?.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      var error = e.response?.data["message"];
      alarm(context, error);
      replaceToNextScreen(context, Login());
      prefs.setString('user', "null");
      prefs.setString('key', "null");
      return false;
    }
  }
}

Future login(String email, String pass, BuildContext context) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    FormData formData = FormData.fromMap({
      "email": email,
      "password": pass,
    });
    var response = await Dio().post('$url/api/sales/login', data: formData);
    print(response.data);
    if (response.statusCode == 200) {
      print(response.data);
      prefs.setString('user', jsonEncode(response.data["data"]["user"]));
      prefs.setString('key', response.data["data"]["token"]);
      user = response.data["data"]["user"];
      key = response.data["data"]["token"];
      return true;
    }
    var error = response.data["message"];
    alarm(context, error);
    return false;
  } on DioError catch (e) {
    // print(e);
    // if (e.response?.statusCode == 401) {
    var error = e.response?.data["message"];
    alarm(context, error);
    return false;
    // }
  }
}

Future cekKunjungan(BuildContext context) async {
  try {
    var response = await Dio().get('$url/api/sales/kunjungan/check-today',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $key",
        }));
    print(response.data);
    if (response.statusCode == 200) {
      pelangganVisit = response.data["data"];
      return pelangganVisit;
    }
    return [];
  } on DioError catch (e) {
    print(e);
    if (e.response?.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      var error = e.response?.data["message"];
      // alarm(context, error);
      // replaceToNextScreen(context, Login());
      prefs.setString('user', "null");
      prefs.setString('key', "null");
      return [];
    }
    return [];
  }
}

Future cekAbsen(BuildContext context) async {
  try {
    var response = await Dio().get('$url/api/sales/attendance/check-today',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $key",
        }));
    absen["masuk"] = response.data["data"]["time_start"] == null
        ? ""
        : DateFormat('hh:mm').format(
            DateFormat('HH:mm').parse(response.data["data"]["time_start"]));
    absen["keluar"] = response.data["data"]["time_end"] == null
        ? ""
        : DateFormat('hh:mm').format(
            DateFormat('HH:mm').parse(response.data["data"]["time_end"]));
    if (response.statusCode == 200) {
      return absen;
    }
    return [];
  } on DioError catch (e) {
    print(e);
    if (e.response?.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      var error = e.response?.data["message"];
      // alarm(context, error);
      // replaceToNextScreen(context, Login());
      prefs.setString('user', "null");
      prefs.setString('key', "null");
      return [];
    }
    return [];
  }
}

Future pelanggan(BuildContext context, String cari) async {
  try {
    var response =
        await Dio().get('$url/api/sales/pelanggan?pagination=0&search=${cari}',
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $key",
            }));
    print(response.data);
    if (response.statusCode == 200) {
      return response.data["data"];
    }
    return [];
  } on DioError catch (e) {
    print(e);
    if (e.response?.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();
      var error = e.response?.data["message"];
      alarm(context, error);
      replaceToNextScreen(context, Login());
      prefs.setString('user', "null");
      prefs.setString('key', "null");
      return [];
    }
    return [];
  }
}

Future provinsi(BuildContext context) async {
  try {
    var response = await Dio().get('$url/api/provinsi',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $key",
        }));
    print(response.data);
    if (response.statusCode == 200) {
      return response.data;
    }
    return false;
  } on DioError catch (e) {
    print(e);
    if (e.response?.statusCode == 401) {
      replaceToNextScreen(context, Login());
      alarm(context, e.response?.data.message);
      return false;
    }
  }
}

Future kabkota(BuildContext context, idprov) async {
  try {
    var response = await Dio().get('$url/api/kabkota/${idprov}',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $key",
        }));
    print(response.data);
    if (response.statusCode == 200) {
      return response.data;
    }
    return false;
  } on DioError catch (e) {
    print(e);
    if (e.response?.statusCode == 401) {
      replaceToNextScreen(context, Login());
      alarm(context, e.response?.data.message);
      return false;
    }
  }
}

Future kecamatan(BuildContext context, idkota) async {
  try {
    var response = await Dio().get('$url/api/kecamatan/${idkota}',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $key",
        }));
    print(response.data);
    if (response.statusCode == 200) {
      return response.data;
    }
    return false;
  } on DioError catch (e) {
    print(e);
    if (e.response?.statusCode == 401) {
      replaceToNextScreen(context, Login());
      alarm(context, e.response?.data.message);
      return false;
    }
  }
}

Future kelurahan(BuildContext context, String idkecamatan) async {
  try {
    var response = await Dio().get('$url/api/kelurahan/${idkecamatan}',
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $key",
        }));
    print(response.data);
    if (response.statusCode == 200) {
      return response.data;
    }
    return false;
  } on DioError catch (e) {
    print(e);
    if (e.response?.statusCode == 401) {
      replaceToNextScreen(context, Login());
      alarm(context, e.response?.data.message);
      return false;
    }
  }
}

Future edit(
    String id,
    TextEditingController namaController,
    TextEditingController namaTokoController,
    TextEditingController alamatTokoController,
    TextEditingController emailController,
    TextEditingController teleponController,
    TextEditingController passwordController,
    String ProvinsiController,
    String KelurahanController,
    String KecamatanController,
    String kotaController,
    BuildContext context) async {
  try {
    await Geolocator.requestPermission();
    var permission = await Geolocator.checkPermission();
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      berhasil(context, "Izin Location Ditolak");
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print({
      "nama": namaController.text,
      "nama_toko": namaTokoController.text,
      "alamat_toko": alamatTokoController.text,
      "email": emailController.text,
      "telepon": teleponController.text,
      "password": passwordController.text,
      "retype_password": passwordController.text,
      "kelurahan": KelurahanController,
      "kecamatan": KecamatanController,
      "kota": kotaController,
      "lat": position.latitude.toString(),
      "lng": position.latitude.toString()
    });
    FormData formData = FormData.fromMap({
      "nama": namaController.text,
      "nama_toko": namaTokoController.text,
      "alamat_toko": alamatTokoController.text,
      "email": emailController.text,
      "telepon": teleponController.text,
      "password": passwordController.text,
      "retype_password": passwordController.text,
      "kelurahan": KelurahanController,
      "kecamatan": KecamatanController,
      "kota": kotaController,
      "lat": position.latitude.toString(),
      "lng": position.latitude.toString()
    });
    var response = await Dio().put('$url/api/sales/pelanggan/${id}',
        data: formData,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $key",
        }));
    print(response.statusCode.toString() == "200");
    if (response.statusCode.toString() == "200") {
      alarm(context, response.data["message"]);

      return true;
    }
    return false;
  } on DioError catch (e) {
    print(e.response?.data);
    var error = e.response?.data?["errors"][0]["message"];
    if (e.response?.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();

      alarm(context, error);
      replaceToNextScreen(context, Login());
      prefs.setString('user', "null");
      prefs.setString('key', "null");
      return [];
    }
    alarm(context, error);
  }
}

Future daftar(
    TextEditingController namaController,
    TextEditingController namaTokoController,
    TextEditingController alamatTokoController,
    TextEditingController emailController,
    TextEditingController teleponController,
    TextEditingController passwordController,
    String ProvinsiController,
    String KelurahanController,
    String KecamatanController,
    String kotaController,
    BuildContext context) async {
  try {
    await Geolocator.requestPermission();
    var permission = await Geolocator.checkPermission();
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      berhasil(context, "Izin Location Ditolak");
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print({
      "nama": namaController.text,
      "nama_toko": namaTokoController.text,
      "alamat_toko": alamatTokoController.text,
      "email": emailController.text,
      "telepon": teleponController.text,
      "password": passwordController.text,
      "retype_password": passwordController.text,
      "kelurahan": KelurahanController,
      "kecamatan": KecamatanController,
      "kota": kotaController,
      "lat": position.latitude.toString(),
      "lng": position.latitude.toString()
    });
    FormData formData = FormData.fromMap({
      "nama": namaController.text,
      "nama_toko": namaTokoController.text,
      "alamat_toko": alamatTokoController.text,
      "email": emailController.text,
      "telepon": teleponController.text,
      "password": passwordController.text,
      "retype_password": passwordController.text,
      "kelurahan": KelurahanController,
      "kecamatan": KecamatanController,
      "kota": kotaController,
      "lat": position.latitude.toString(),
      "lng": position.latitude.toString()
    });
    var response = await Dio().post('$url/api/sales/pelanggan',
        data: formData,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $key",
        }));
    print(response.statusCode.toString() == "200");
    if (response.statusCode.toString() == "200") {
      alarm(context, response.data["message"]);

      return true;
    }
    return false;
  } on DioError catch (e) {
    print(e.response?.data);
    var error = e.response?.data?["errors"][0]["message"];
    if (e.response?.statusCode == 401) {
      final prefs = await SharedPreferences.getInstance();

      alarm(context, error);
      replaceToNextScreen(context, Login());
      prefs.setString('user', "null");
      prefs.setString('key', "null");
      return [];
    }
    alarm(context, error);
  }
}
