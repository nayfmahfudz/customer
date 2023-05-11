import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:customer/component/api.dart';
import 'package:customer/setting.dart';

import 'component/fom.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  void initState() {
    if (Provinsi.length == 0) {
      provinsi(context).then((value) {
        setState(() {
          Provinsi = value;
          ProvinsiController = value[0];
        });
      });
    }
    super.initState();
  }

  var namaController = new TextEditingController();
  var namaTokoController = new TextEditingController();
  var alamatTokoController = new TextEditingController();
  var emailController = new TextEditingController();
  var teleponController = new TextEditingController();
  var passwordController = new TextEditingController();
  var kotaController = Map<String, dynamic>();
  var KecamatanController = Map<String, dynamic>();
  var KelurahanController = Map<String, dynamic>();
  var ProvinsiController = Map<String, dynamic>();
  final formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: lebar(context) * 0.053,
            left: lebar(context) * 0.053,
            right: lebar(context) * 0.053),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Edit Pelanggan",
                style: TextStyle(
                    color: biru, fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Expanded(child: form(context))
            ],
          ),
        ),
      ),
    );
  }

  Widget form(context) {
    return Container(
      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(shrinkWrap: true, children: [
                    formfield(namaController, context, "Nama",
                        Icons.account_box, Icons.account_box, false, false),
                    SizedBox(
                      height: tinggi(context) * 0.04,
                    ),
                    formfield(
                        namaTokoController,
                        context,
                        "Nama Toko",
                        Icons.account_balance,
                        Icons.account_balance,
                        false,
                        false),
                    SizedBox(
                      height: tinggi(context) * 0.04,
                    ),
                    formfield(
                        alamatTokoController,
                        context,
                        "Alamat Toko",
                        Icons.account_balance,
                        Icons.account_balance,
                        false,
                        false),
                    SizedBox(
                      height: tinggi(context) * 0.04,
                    ),
                    formfield(emailController, context, "E-mail", Icons.mail,
                        Icons.mail, false, false),
                    SizedBox(
                      height: tinggi(context) * 0.04,
                    ),
                    formfield(teleponController, context, "Telepon",
                        Icons.phone, Icons.phone, false, false),
                  ]),
                ),
                SizedBox(
                  width: lebar(context) * 0.12,
                ),
                Expanded(
                  child: ListView(shrinkWrap: true, children: [
                    SizedBox(
                      height: tinggi(context) * 0.04,
                    ),
                    formfield(passwordController, context, "Password",
                        Icons.visibility, Icons.visibility_off, false, true),
                    SizedBox(
                      height: tinggi(context) * 0.04,
                    ),
                    dropdown(ProvinsiController, context, Provinsi,
                        Icons.location_city, "Provinsi", ((value) {
                      setState(() {
                        ProvinsiController = value;
                        kabkota(context, value["id"]).then((newvalue) {
                          setState(() {
                            Kota = newvalue ?? [];
                            Kecamatan = [];
                            Kelurahan = [];
                            kotaController = newvalue[0];
                            KecamatanController = {};
                            KelurahanController = {};
                          });
                        });
                      });
                    })),
                    SizedBox(
                      height: tinggi(context) * 0.04,
                    ),
                    dropdown(kotaController, context, Kota, Icons.location_city,
                        "Kota", ((value) {
                      setState(() {
                        kotaController = value;
                        kecamatan(context, value["id"]).then((newvalue) {
                          setState(() {
                            Kecamatan = newvalue ?? [];
                            Kelurahan = [];
                            KecamatanController = newvalue[0];
                            KelurahanController = {};
                          });
                        });
                      });
                    })),
                    SizedBox(
                      height: tinggi(context) * 0.04,
                    ),
                    dropdown(KecamatanController, context, Kecamatan,
                        Icons.location_city, "Kecamatan", ((value) {
                      setState(() {
                        KecamatanController = value;
                        kelurahan(context, value["id"]).then((newvalue) {
                          setState(() {
                            Kelurahan = newvalue ?? [];
                            KelurahanController = newvalue[0];
                          });
                        });
                      });
                    })),
                    SizedBox(
                      height: tinggi(context) * 0.04,
                    ),
                    dropdown(KelurahanController, context, Kelurahan,
                        Icons.location_city, "Kelurahan", ((value) {
                      setState(() {
                        KelurahanController = value;
                      });
                    })),
                  ]),
                ),
              ],
            ),
            SizedBox(
              height: tinggi(context) * 0.1,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: (() {
                  if (formKey.currentState!.validate()) {
                    edit(
                            "",
                            namaController,
                            namaTokoController,
                            alamatTokoController,
                            emailController,
                            teleponController,
                            passwordController,
                            ProvinsiController["nama"],
                            KelurahanController["nama"],
                            KecamatanController["nama"],
                            kotaController["nama"],
                            context)
                        .then((value) {
                      if (value == true) {
                        namaController.text = "";
                        namaTokoController.text = "";
                        alamatTokoController.text = "";
                        emailController.text = "";
                        teleponController.text = "";
                        passwordController.text = "";
                      }
                    });
                  }
                }),
                child: Container(
                    height: tinggi(context) * 0.11,
                    width: lebar(context) * 0.3,
                    child: loginButton(
                        'Submit', Color.fromARGB(255, 129, 199, 132), hitam)),
              ),
            ),
            SizedBox(
              height: tinggi(context) * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
