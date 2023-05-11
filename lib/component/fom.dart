import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:customer/component/api.dart';

import '../setting.dart';

navigateToNextScreen(BuildContext context, Widget newScreen) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => newScreen));
}

replaceToNextScreen(BuildContext context, Widget newScreen) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => newScreen),
      (Route<dynamic> route) => false);
}

tinggi(context) {
  return MediaQuery.of(context).size.height;
}

lebar(context) {
  return MediaQuery.of(context).size.width;
}

nama(TextEditingController controller, BuildContext context) {
  return Row(
    children: [
      Container(child: Icon(Icons.account_box_sharp, size: 60, color: abu)),
      Expanded(
        child: Container(
          child: TextFormField(
            controller: controller,
            validator: (value) {
              if (value != null && value.length < 3)
                return 'Nama Harus diisi minimal 3 kata';
              else
                return null;
            },
            autofocus: false,
            decoration: InputDecoration(
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
              // ),
              hintText: 'Username',
              contentPadding: EdgeInsets.all(20),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget dropdown(Map<String, dynamic> controller, BuildContext context,
    List list, IconData icon, String hint, void fungsi(value)) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 14.0),
        child: Container(
          child: Icon(icon, size: 40, color: orange),
        ),
      ),
      Expanded(
        child: Container(
          color: putih,
          child: DropdownButtonFormField(
            isExpanded: true,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: biru),
              contentPadding: EdgeInsets.all(20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              labelText: hint,
            ),
            validator: (value) {
              if (value == null)
                return 'Masukan data terlebih dahulu';
              else
                return null;
            },
            value: controller.length == 0 ? null : controller,

            // Down Arrow Icon
            icon: Icon(Icons.arrow_drop_down_circle, color: merah),

            // Array list of items
            items: list.map((items) {
              return DropdownMenuItem(
                value: items ?? {},
                child: Text(items?["nama"] ?? ""),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (newValue) async {
              newValue as Map<String, dynamic>;
              if (newValue != null) {
                fungsi(newValue);
                // });
              }
            },
          ),
        ),
      ),
    ],
  );
}

Widget formfield(TextEditingController controller, BuildContext context,
    String hint, IconData icon, IconData iconClose, hide, pasword) {
  return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: GestureDetector(
                  onTap: (() => setState(() {
                        controller;
                        hide = !hide;
                      })),
                  child: Container(
                    child:
                        Icon(hide ? icon : iconClose, size: 40, color: orange),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: putih,
                  child: TextFormField(
                    obscureText: pasword == true
                        ? hide
                            ? true
                            : false
                        : false,
                    controller: controller,
                    validator: (value) {
                      if (value != null && value.length < 3)
                        return 'Harus diisi minimal 3 kata';
                      else
                        return null;
                    },
                    autofocus: false,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: biru),
                        // icon: Icon(icon, color: orange, size: 40),
                        labelText: hint,
                        contentPadding: EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )),
                  ),
                ),
              ),
            ],
          ));
}

Widget searchfield(TextEditingController controller, BuildContext context,
    String hint, void fungsi(value)) {
  return Container(
      color: putih,
      child: TextFormField(
        onChanged: (value) {
          fungsi(value);
          // pelanggan(context, value);
        },
        controller: controller,
        validator: (value) {
          if (value != null && value.length < 3)
            return 'Harus diisi minimal 3 kata';
          else
            return null;
        },
        autofocus: false,
        decoration: InputDecoration(
            labelStyle: TextStyle(color: biru),
            // icon: Icon(icon, color: orange, size: 40),
            labelText: hint,
            contentPadding: EdgeInsets.all(20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            )),
      ));
}

password(TextEditingController controller, bool hide, String hint) {
  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) => Row(
      children: [
        Container(
          child: GestureDetector(
            onTap: (() => setState(() {
                  controller;
                  hide = !hide;
                })),
            child:
                Icon(hide ? Icons.lock : Icons.lock_open, size: 60, color: abu),
          ),
        ),
        Expanded(
          child: Container(
            child: TextFormField(
                validator: (value) {
                  if (value != null && value.length < 5)
                    return 'Password harus diisi Minimal 5 ';
                  else
                    return null;
                },
                autofocus: false,
                controller: controller,
                obscureText: hide ? true : false,
                decoration: InputDecoration(
                  hintText: hint,
                  contentPadding: EdgeInsets.all(20),
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  // ),
                  //   suffixIcon: IconButton(
                  //       icon: Icon(
                  //         hide ? Icons.visibility : Icons.visibility_off,
                  //       ),
                  //       onPressed: () {
                  //         setState(() {
                  //           controller;
                  //           hide = !hide;
                  //         });
                  //       }),
                )),
          ),
        ),
      ],
    ),
  );
}

class ReturnValueToParent extends StatelessWidget {
  Function myNumber;
  String selected;
  String aktif;
  String tidakAktif;
  String judul;
  ReturnValueToParent(
      this.myNumber, this.selected, this.aktif, this.tidakAktif, this.judul);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.11,
      width: MediaQuery.of(context).size.height * 0.055,
      child: GestureDetector(
          onTap: () {
            selected = judul;
          },
          child: selected == judul
              ? Column(
                  children: [
                    Image.asset(aktif, fit: BoxFit.contain),
                    Text(judul,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: biru,
                          fontWeight: FontWeight.w400,
                          textStyle: Theme.of(context).textTheme.subtitle1,
                        )),
                  ],
                )
              : Column(
                  children: [
                    Image.asset(tidakAktif, fit: BoxFit.contain),
                    Text(judul,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: biru,
                          fontWeight: FontWeight.w400,
                          textStyle: Theme.of(context).textTheme.subtitle1,
                        )),
                  ],
                )),
    ));
  }
}

menuUtama(BuildContext context, String selected, String aktif,
    String tidakAktif, String judul, Function fungsi) {
  return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) => Expanded(
              child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.11,
            width: MediaQuery.of(context).size.height * 0.055,
            child: GestureDetector(
                onTap: () => fungsi,
                child: selected == judul
                    ? Column(
                        children: [
                          Image.asset(aktif, fit: BoxFit.contain),
                          Text(judul,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: biru,
                                fontWeight: FontWeight.w400,
                                textStyle:
                                    Theme.of(context).textTheme.subtitle1,
                              )),
                        ],
                      )
                    : Column(
                        children: [
                          Image.asset(tidakAktif, fit: BoxFit.contain),
                          Text(judul,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: biru,
                                fontWeight: FontWeight.w400,
                                textStyle:
                                    Theme.of(context).textTheme.subtitle1,
                              )),
                        ],
                      )),
          )));
}
// var alamat = StatefulBuilder(
//     builder: (BuildContext context, StateSetter setState) => Container(
//             child: TextFormField(
//           controller: alamatinputcontroller,
//           validator: validalamat,
//           onSaved: (String value) {
//             _alamat = value;
//           },
//           autofocus: false,
//           decoration: InputDecoration(
//             suffixIcon: IconButton(
//               icon: Icon(Icons.home),
//             ),
//             hintText: 'Alamat ',
//             contentPadding: EdgeInsets.all(20),
//             border: Provider.of<Restapi>(context).getboolean()
//                 ? OutlineInputBorder()
//                 : null,
//           ),
//         )));
// var nomor = StatefulBuilder(
//     builder: (BuildContext context, StateSetter setState) => Container(
//             child: TextFormField(
//           keyboardType: TextInputType.phone,
//           controller: nomorinputcontroller,
//           validator: validnomor,
//           autofocus: false,
//           decoration: InputDecoration(
//             hintText: ' Nomor Telepon',
//             contentPadding: EdgeInsets.all(20),
//             border: Provider.of<Restapi>(context).getboolean()
//                 ? OutlineInputBorder()
//                 : null,
//             suffixIcon: IconButton(icon: Icon(Icons.phone_android)),
//           ),
//         )));
// void gberhasil(BuildContext context) => showDialog(
//     context: context,
//     builder: (context) => Center(
//           child: AlertDialog(
//             content: Text(
//               "Gagal Join",
//               textAlign: TextAlign.center,
//               style:
//                   TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
//             ),
//             elevation: 3,
// //                actionsPadding: EdgeInsets.only(right: 28),

//             actions: <Widget>[Center(child: okButton)],
//           ),
//         ));
// void jberhasil(BuildContext context) => showDialog(
//     context: context,
//     builder: (context) => Center(
//           child: AlertDialog(
//             content: Text(
//               "Berhasil Join",
//               textAlign: TextAlign.center,
//               style:
//                   TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
//             ),
//             elevation: 3,
// //                actionsPadding: EdgeInsets.only(right: 28),

//             actions: <Widget>[Center(child: okButton)],
//           ),
//         ));
// void uberhasil(BuildContext context) => showDialog(
//     context: context,
//     builder: (context) => Center(
//           child: AlertDialog(
//             content: Text(
//               "Berhasil Join",
//               textAlign: TextAlign.center,
//               style:
//                   TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
//             ),
//             elevation: 3,
// //                actionsPadding: EdgeInsets.only(right: 28),

//             actions: <Widget>[Center(child: okButton)],
//           ),
//         ));
// int switchControl;

// String hasil;

void berhasil(BuildContext context, String uraian) => showDialog(
      context: context,
      builder: (context) => Center(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(uraian,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: biru,
                      fontWeight: FontWeight.w500,
                      textStyle: Theme.of(context).textTheme.subtitle1,
                    )),
                SizedBox(
                  height: 10,
                ),
                okButton
              ],
            ),
            decoration: BoxDecoration(
              color: putih,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              // shadowColor: Color.fromRGBO(237, 155, 12, 1),
            )),
      ),
      // elevation: 5.0,
    );
var okButton = Builder(
  builder: (BuildContext context) => Material(
    shadowColor: peach,
    child: MaterialButton(
      minWidth: 200.0,
      height: 42.0,
      onPressed: () {
        Navigator.pop(context);
      },
      color: peach,
      child: Text(
        'OK',
        style: TextStyle(
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  ),
);
// void keluar(BuildContext context) => showDialog(
//     context: context,
//     builder: (context) => Center(
//           child: AlertDialog(
//             content: Text(
//               "Mau Keluar?",
//               textAlign: TextAlign.center,
//               style:
//                   TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
//             ),
//             elevation: 3,
// //                actionsPadding: EdgeInsets.only(right: 28),

//             actions: <Widget>[
//               Row(
//                 children: <Widget>[
//                   keluaryaButton,
//                   SizedBox(
//                     width: 20,
//                   ),
//                   keluartidakButton
//                 ],
//               )
//             ],
//           ),
//         ));

alarm(BuildContext context, String text) => showDialog(
    context: context,
    builder: (context) => Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
                height: MediaQuery.of(context).size.width * 0.2,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    color: putih),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: Center(
                          child: DefaultTextStyle(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            child: Text(
                              text,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Center(child: okButton))
                  ],
                )),
          ),
        ));

// var keluaryaButton = Builder(
//   builder: (BuildContext context) => Material(
//     shadowColor: Color.fromRGBO(237, 155, 12, 1),
//     child: MaterialButton(
//       minWidth: 100.0,
//       height: 42.0,
//       onPressed: () {
//         dbHelper.deleteUser();
//         Navigator.pushNamed(context, "/Login");
//       },
//       color: Color.fromRGBO(237, 155, 12, 1),
//       child: Text(
//         'Ya',
//         style: TextStyle(
//           color: Colors.white,
//         ),
//         textAlign: TextAlign.center,
//       ),
//     ),
//   ),
// );
// var keluartidakButton = Builder(
//   builder: (BuildContext context) => Material(
//     shadowColor: Color.fromRGBO(237, 155, 12, 1),
//     child: MaterialButton(
//       minWidth: 100.0,
//       height: 42.0,
//       onPressed: () {
//         Navigator.pop(context);
//       },
//       color: Color.fromRGBO(237, 155, 12, 1),
//       child: Text(
//         'Tidak',
//         style: TextStyle(
//           color: Colors.white,
//         ),
//         textAlign: TextAlign.center,
//       ),
//     ),
//   ),
// );
// var okButton = Builder(
//   builder: (BuildContext context) => Material(
//     shadowColor: Color.fromRGBO(237, 155, 12, 1),
//     child: MaterialButton(
//       minWidth: 200.0,
//       height: 42.0,
//       onPressed: () {
//         Navigator.pop(context);
//         Navigator.pop(context);
//       },
//       color: Color.fromRGBO(237, 155, 12, 1),
//       child: Text(
//         'OK',
//         style: TextStyle(
//           color: Colors.white,
//         ),
//         textAlign: TextAlign.center,
//       ),
//     ),
//   ),
// );
// // var gantiButton = Builder(
// //     builder: (BuildContext context) => Padding(
// //           padding: EdgeInsets.only(left: 30),
// //           child: Align(
// //             alignment: Alignment.bottomCenter,
// //             child: SizedBox(
// //               width: MediaQuery.of(context).size.width,
// //               child: RaisedButton(
// //                 // padding: EdgeInsets.all(10),
// //                 onPressed: () {
// //                   if (formKey2.currentState.validate()) {
// //                     formKey2.currentState.save();
// //                     gantipass(context, passvrinputcontroller.text);
// //                   } else {
// //                     StatefulBuilder(builder: (context, setState) {
// //                       setState(() {
// //                         autoValidate = true;
// //                       });
// //                     });
// //                   }
// //                 },
// //                 child: const Text('Verifikasi', style: TextStyle(fontSize: 20)),
// //                 color: Color.fromRGBO(237, 155, 12, 1),
// //                 textColor: Colors.white,
// //                 // elevation: 5,
// //               ),
// //             ),
// //           ),
// //           // ),
// //         ));

// //    Material(
// //     borderRadius: BorderRadius.circular(60.0),
// //     shadowColor: Color.fromRGBO(237, 155, 12, 1),
// //     // elevation: 5.0,
// //     child: MaterialButton(
// //         minWidth: 200.0,
// //         height: 42.0,
// //         onPressed: () {

// //   if (formKey2.currentState.validate()) {
// //     formKey2.currentState.save();
// //     gantipass(context, _passver);
// //   } else {
// //     StatefulBuilder(builder: (context, setState) {
// //       setState(() {
// //         autoValidate = true;
// //       });
// //     });
// //   }},
// //  color: Color.fromRGBO(237, 155, 12, 1),
// //       child: Text('Verifikasi', style: TextStyle(color: Colors.white)),

// //         ),
// //   ),
// // );
// var joinButton = Builder(
//   builder: (BuildContext context) => Material(
//     borderRadius: BorderRadius.circular(60.0),
//     shadowColor: Color.fromRGBO(237, 155, 12, 1),
//     // elevation: 5.0,
//     child: MaterialButton(
//       minWidth: 200.0,
//       height: 42.0,
//       onPressed: () {
//         joinagenda(context);
//       },
//       color: Color.fromRGBO(237, 155, 12, 1),
//       child: Text('Sign In', style: TextStyle(color: Colors.white)),
//     ),
//   ),
// );

// var signButton = Builder(
//   builder: (BuildContext context) => Material(
//     borderRadius: BorderRadius.circular(60.0),
//     shadowColor: Color.fromRGBO(237, 155, 12, 1),
//     // elevation: 5.0,
//     child: MaterialButton(
//       minWidth: 200.0,
//       height: 42.0,
//       onPressed: () {
//         if (formKey1.currentState.validate()) {
//           formKey1.currentState.save();
//           postSignUp(
//               context,
//               namainputcontroller.text,
//               emailinputcontroller.text,
//               passinputcontroller.text,
//               alamatinputcontroller.text,
//               nomorinputcontroller.text);
//         } else {
//           StatefulBuilder(builder: (context, setState) {
//             setState(() {
//               autoValidate = true;
//             });
//           });
//         }
//       },
//       color: Color.fromRGBO(237, 155, 12, 1),
//       child: Text('Sign Up', style: TextStyle(color: Colors.white)),
//     ),
//   ),
// );

// final email = StatefulBuilder(
//     builder: (BuildContext context, StateSetter setState) => Container(
//             child: TextFormField(
//           validator: validemail,
//           onSaved: (String value) {
//             _email = value;
//           },
//           controller: emailinputcontroller,
//           keyboardType: TextInputType.emailAddress,
//           autofocus: false,
//           // initialValue: "Masukan Username atau Email",
//           decoration: InputDecoration(
//             suffixIcon: IconButton(icon: Icon(Icons.keyboard)),
//             hintText: 'Email',
//             contentPadding: EdgeInsets.all(20),
//             border: Provider.of<Restapi>(context).getboolean()
//                 ? OutlineInputBorder()
//                 : null,
//           ),
//         )));
// // final

// bool passwordVisible = true;

Widget loginButton(String text, Color warna, Color textwarna) {
  return Builder(
    builder: (context) => Container(
      height: tinggi(context) * 0.06,
      child: Center(
          child: Text(text,
              style: GoogleFonts.josefinSans(
                fontSize: 16,
                color: textwarna,
                fontWeight: FontWeight.w500,
                textStyle: Theme.of(context).textTheme.subtitle1,
              ))),
      decoration: BoxDecoration(
        color: warna,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        // shadowColor: Color.fromRGBO(237, 155, 12, 1),
      ),
      // elevation: 5.0,
    ),
  );
}

Widget searchButton(IconData icon, Color warna, Color iconWarna) {
  return Builder(
    builder: (context) => Container(
      height: tinggi(context) * 0.09,
      child: Center(
          child: Icon(
        icon,
        color: iconWarna,
        size: 30,
      )),
      decoration: BoxDecoration(
        color: warna,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        // shadowColor: Color.fromRGBO(237, 155, 12, 1),
      ),
      // elevation: 5.0,
    ),
  );
}

text(String text, Function to) {
  return Builder(
      builder: (BuildContext context) => GestureDetector(
            child: Text(
              text,
              style: TextStyle(color: Colors.black54),
            ),
            onTap: () {
              to;
            },
          ));
}

// final editButton = Builder(
//   builder: (BuildContext context) => Material(
//     shadowColor: Color.fromRGBO(237, 155, 12, 1),
//     // elevation: 5.0,
//     child: MaterialButton(
//       minWidth: 200.0,
//       height: 42.0,
//       onPressed: () {
//         edituser(context, namainputcontroller.text, emailinputcontroller.text,
//             alamatinputcontroller.text, nomorinputcontroller.text);
//       },
//       color: Color.fromRGBO(237, 155, 12, 1),
//       child: Text('Edit', style: TextStyle(color: Colors.white)),
//     ),
//   ),
// );

// // void settingModalBottomSheet(BuildContext context) => showModalBottomSheet(
// //     context: context,
// //     builder: (context) {
// //       return Iconbottom();
// //     });

// var searchInputLabel = StatefulBuilder(
//     builder: (BuildContext context, StateSetter setState) => Container(
//           child: TextFormField(
// //          validator: validKeyword,
//               autofocus: false,
// //          onSaved: (value) {
// //            _keyword = value;
// //          },
// //          controller: keywordInputController,
//               onTap: () {
//                 Navigator.of(context).pushNamed("/Search");
//               },
//               decoration: InputDecoration(
//                 hintText: ' Search...',
//                 contentPadding: EdgeInsets.all(20),
//                 border: OutlineInputBorder(),
//                 suffixIcon: IconButton(
//                     icon: Icon(
//                       Icons.search,
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).pushNamed("/Search");
//                     }),
//               )),
//         ));

// var searchInput = StatefulBuilder(
//     builder: (BuildContext context, StateSetter setState) => Container(
//           child: TextFormField(
// //          validator: validKeyword,
//               autofocus: false,
// //          onSaved: (value) {
// //            _keyword = value;
// //          },
// //          controller: keywordInputController,
//               onTap: () {
//                 Navigator.of(context).pushNamed("/Search");
//               },
//               decoration: InputDecoration(
//                 hintText: ' Search...',
//                 contentPadding: EdgeInsets.all(20),
//                 border: OutlineInputBorder(),
//                 suffixIcon: IconButton(
//                     icon: Icon(
//                       Icons.search,
//                     ),
//                     onPressed: () {
//                       Navigator.of(context).pushNamed("/Search");
//                     }),
//               )),
//         ));

// //String validKeyword(String value) {
// //  if (value.length < 5) return 'Minimum keyword char is 3';
// //}
