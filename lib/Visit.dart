import 'package:flutter/material.dart';
import 'package:customer/component/api.dart';
import 'package:customer/component/fom.dart';
import 'package:customer/menu.dart';
import 'package:customer/setting.dart';

class Visit extends StatefulWidget {
  const Visit({super.key});

  @override
  State<Visit> createState() => _VisitState();
}

class _VisitState extends State<Visit> {
  @override
  List pelanggans = [];
  var searchController = new TextEditingController();
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => replaceToNextScreen(context, Menu()),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
              left: lebar(context) * 0.053,
              right: lebar(context) * 0.053,
              top: lebar(context) * 0.053),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: searchfield(
                          searchController, context, "Search Pelanggan",
                          ((value) {
                    setState(() {
                      pelanggan(context, value).then((value) => setState(() {
                            pelanggans = value;
                          }));
                    });
                  }))),
                  SizedBox(
                    width: lebar(context) * 0.03,
                  ),
                  Container(
                      height: lebar(context) * 0.06,
                      width: lebar(context) * 0.06,
                      child: searchButton(Icons.search, orange, peach)),
                ],
              ),
              Expanded(child: cardSearch(context))
            ],
          ),
        ),
      ),
    );
  }

  Widget cardSearch(context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: pelanggans.length,
        itemBuilder: (BuildContext context, int index) {
          print(pelanggans.length);
          return Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: Container(
              height: tinggi(context) * 0.25,
              width: lebar(context),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                // shadowColor: Color.fromRGBO(237, 155, 12, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: tinggi(context) * 0.01,
                        ),
                        Text(
                          pelanggans[index]["nama"] ?? "",
                          style: TextStyle(
                              color: hitam,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: tinggi(context) * 0.014,
                        ),
                        Text(
                          pelanggans[index]["alamat"] ?? "",
                          style: TextStyle(
                              color: hitam,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: tinggi(context) * 0.004,
                        ),
                        Text(
                          pelanggans[index]["telepon"] ?? "",
                          style: TextStyle(
                              color: hitam,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )),
                    Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: tinggi(context) * 0.024,
                            ),
                            Text(
                              "",
                              style: TextStyle(
                                  color: hitam,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: tinggi(context) * 0.014,
                            ),
                            Text(
                              pelanggans[index]["email"] ?? "",
                              style: TextStyle(
                                  color: hitam,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: tinggi(context) * 0.014,
                            ),
                            Text(
                              pelanggans[index]["nama_toko"] ?? "",
                              style: TextStyle(
                                  color: hitam,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        )),
                    Column(
                      children: [
                        Text(
                          "",
                          style: TextStyle(
                              color: hitam,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: tinggi(context) * 0.014,
                        ),
                        GestureDetector(
                          onTap: (() {
                            kunjungan(
                                    pelanggans[index]["id"].toString(), context)
                                .then((value) => setState(() {
                                      pelangganVisit;
                                    }));
                          }),
                          child: Container(
                              height: tinggi(context) * 0.09,
                              width: lebar(context) * 0.15,
                              child: loginButton('Visit',
                                  Color.fromARGB(255, 129, 199, 132), hitam)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
