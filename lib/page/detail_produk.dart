// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gastrack/controller/transaksicontroller.dart';
import 'package:gastrack/provider/GasProvider.dart';
import 'package:shimmer/shimmer.dart';

class DetailProduk extends StatefulWidget {
  const DetailProduk({super.key, required this.id});

  final int id;

  @override
  State<DetailProduk> createState() => _MyStatefulWidgetState();
}

// {
//   'name_gas': "ssss",
//   'berat_gas': 3,
//   'harga_gas': 20000,
//   'stock_gas': 20,
//   'jenis_gas': "isi ulang"
// }

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _MyStatefulWidgetState extends State<DetailProduk> {
  List<Map<String, dynamic>> DataDetailGas = [];
  final TransaksiController _detailController = TransaksiController();
  late var id = widget.id.toInt();
  late var number = 0;
  late var harga = 0;
  late var totalHarga = 0;
  bool pilih5 = false;
  bool pilih10 = false;
  bool pilih20 = false;
  bool pilih30 = false;

  void add() {
    var a = number + 1;
    setState(() {
      pilih5 = false;
      pilih10 = false;
      pilih20 = false;
      pilih30 = false;
      number = a;
    });
    var hitung = DataDetailGas[0]['harga_gas'] * a;
    setState(() {
      totalHarga = hitung;
    });
  }

  void remove() {
    var a = number - 1;
    if (a < 0) {
      a = 0;
    }
    setState(() {
      pilih5 = false;
      pilih10 = false;
      pilih20 = false;
      pilih30 = false;
      number = a;
    });
    var hitung = DataDetailGas[0]['harga_gas'] * a;
    setState(() {
      totalHarga = hitung;
    });
  }

  void pesan5() {
    var hitung = DataDetailGas[0]['harga_gas'] * 5;
    setState(() {
      number = 5;
      totalHarga = hitung;
      pilih5 = true;
      pilih10 = false;
      pilih20 = false;
      pilih30 = false;
    });
  }

  void pesan10() {
    var hitung = DataDetailGas[0]['harga_gas'] * 10;
    setState(() {
      number = 10;
      totalHarga = hitung;
      pilih10 = true;
      pilih5 = false;
      pilih20 = false;
      pilih30 = false;
    });
  }

  void pesan20() {
    var hitung = DataDetailGas[0]['harga_gas'] * 20;
    setState(() {
      number = 20;
      totalHarga = hitung;
      pilih20 = true;
      pilih10 = false;
      pilih5 = false;
      pilih30 = false;
    });
  }

  void pesan30() {
    number = 30;
    var hitung = DataDetailGas[0]['harga_gas'] * 30;
    setState(() {
      totalHarga = hitung;
      pilih30 = true;
      pilih10 = false;
      pilih20 = false;
      pilih5 = false;
    });
  }

  pesansekarang() {
    var idProduk = id;
    var banyakPesanan = number;
    _detailController.Addpesanan(idProduk, banyakPesanan);
  }

  @override
  void initState() {
    GasProvider().getDataGasById(id).then((value) {
      if (value.statusCode == 200) {
        var data = value.body['data'];
        setState(() {
          DataDetailGas.add(data);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Produk',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 1,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(249, 1, 131, 1.0),
                Color.fromRGBO(128, 38, 198, 1.0)
              ], // Warna gradient
            ),
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DataDetailGas.isEmpty
                ? const LoadingHeaderdetail()
                : Expanded(
                    child: (DataDetailGas[0]['berat_gas'] == 3)
                        ? Headerdetail('assets/icon/gasGreen_icon.png')
                        : (DataDetailGas[0]['berat_gas'] == 5.5)
                            ? Headerdetail('assets/icon/gasPink_icon.png')
                            : Headerdetail('assets/icon/gasPurple_icon.png'),
                  ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 122, 122, 122)
                        .withOpacity(0.25), // Warna bayangan
                    spreadRadius: 0,
                    blurRadius: 7,
                    offset: const Offset(1, 0),
                  ),
                ],
              ),
              child: SizedBox(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DataDetailGas.isEmpty
                          ? const LoadingContentDetail(
                              height: 0.03,
                              width: 0.30,
                            )
                          : Row(
                              children: [
                                const Text(
                                  "Rp",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                                Text(
                                  DataDetailGas[0]['harga_gas'].toString(),
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                                const Text(
                                  "/Pcs",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: DataDetailGas.isEmpty
                            ? const LoadingContentDetail(
                                height: 0.03,
                                width: 0.13,
                              )
                            : Row(
                                children: [
                                  const Text(
                                    "Stok : ",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    DataDetailGas[0]['stock_gas'].toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: DataDetailGas.isEmpty
                            ? const LoadingContentDetail(
                                height: 0.03,
                                width: 0.40,
                              )
                            : Row(
                                children: [
                                  const Text(
                                    "Jenis produk : ",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    DataDetailGas[0]['jenis_gas'],
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      DataDetailGas.isEmpty
                          ? const LoadingContentDetail(
                              height: 0.30,
                              width: 0.90,
                            )
                          : SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Pilih jumlah pesanan",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            pesan5();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 32,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: pilih5
                                                  ? Colors.pink.shade100
                                                  : Colors.grey.shade100,
                                              border: Border.all(
                                                width: 2,
                                                color: pilih5
                                                    ? Colors.pink.shade300
                                                    : Colors.grey.shade300,
                                              ),
                                            ),
                                            child: Text(
                                              "5",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                color: pilih5
                                                    ? Colors.pink.shade300
                                                    : Colors.grey.shade300,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            pesan10();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 30,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: pilih10
                                                  ? Colors.pink.shade100
                                                  : Colors.grey.shade100,
                                              border: Border.all(
                                                width: 2,
                                                color: pilih10
                                                    ? Colors.pink.shade300
                                                    : Colors.grey.shade300,
                                              ),
                                            ),
                                            child: Text(
                                              "10",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                color: pilih10
                                                    ? Colors.pink.shade300
                                                    : Colors.grey.shade300,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            pesan20();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 30,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: pilih20
                                                  ? Colors.pink.shade100
                                                  : Colors.grey.shade100,
                                              border: Border.all(
                                                width: 2,
                                                color: pilih20
                                                    ? Colors.pink.shade300
                                                    : Colors.grey.shade300,
                                              ),
                                            ),
                                            child: Text(
                                              "20",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                color: pilih20
                                                    ? Colors.pink.shade300
                                                    : Colors.grey.shade300,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            pesan30();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 30,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              color: pilih30
                                                  ? Colors.pink.shade100
                                                  : Colors.grey.shade100,
                                              border: Border.all(
                                                width: 2,
                                                color: pilih30
                                                    ? Colors.pink.shade300
                                                    : Colors.grey.shade300,
                                              ),
                                            ),
                                            child: Text(
                                              "30",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 15,
                                                color: pilih30
                                                    ? Colors.pink.shade300
                                                    : Colors.grey.shade300,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Text(
                                    "Jumlah pesanan lainnya",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 10,
                                    ),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: Colors.black12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            remove();
                                          },
                                          child: Icon(
                                            Icons.remove,
                                            size: 20,
                                            color: Colors.pink.shade300,
                                          ),
                                        ),
                                        Text(
                                          number.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                            color: Colors.pink.shade300,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            add();
                                          },
                                          child: Icon(
                                            Icons.add,
                                            size: 20,
                                            color: Colors.pink.shade300,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Rp",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                          Text(
                            totalHarga.toString(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),
                      (number == 0) ? buttonOff() : buttonOn(),
                    ],
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  TextButton buttonOn() {
    return TextButton(
      style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          backgroundColor: Colors.pink),
      onPressed: () {
        _detailController.Addpesanan(id, number);
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pesan Sekarang",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            SizedBox(
              width: 7,
            ),
            Icon(
              Icons.shopping_cart_checkout,
              size: 25,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ],
        ),
      ),
    );
  }

  TextButton buttonOff() {
    return TextButton(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        backgroundColor: Colors.black12,
      ),
      onPressed: null,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pesan Sekarang",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            SizedBox(
              width: 7,
            ),
            Icon(
              Icons.shopping_cart_checkout,
              size: 25,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ],
        ),
      ),
    );
  }

  Container Headerdetail(img) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Image.asset(
              img,
            ),
          ),
          Text(
            DataDetailGas[0]['name_gas'],
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
                fontFamily: 'Poppins-bold',
                color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ],
      ),
    );
  }
}

class LoadingContentDetail extends StatelessWidget {
  const LoadingContentDetail(
      {super.key, required this.width, required this.height});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                height: MediaQuery.of(context).size.height * height,
                width: MediaQuery.of(context).size.width * width,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LoadingHeaderdetail extends StatelessWidget {
  const LoadingHeaderdetail({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 50),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                      ],
                    ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
