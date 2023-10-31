// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_element, use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gastrack/controller/transaksicontroller.dart';
import 'package:get/get.dart';

class BayarTransaksiPage extends StatefulWidget {
  const BayarTransaksiPage({super.key, required this.id});

  final int id;

  @override
  State<BayarTransaksiPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<BayarTransaksiPage> {
  final TransaksiController _controller = TransaksiController();
  late var id = widget.id.toInt();

  void getFilePicker() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      final selectedFile = File(result.files.first.path as String);

      if (selectedFile.existsSync()) {
        final bytes = await selectedFile.readAsBytes();
        final controller = StreamController<List<int>>();
        controller.sink.add(bytes);

        setState(() {
          _controller.photoprofile = PlatformFile(
            path: selectedFile.path,
            name: selectedFile.uri.pathSegments.last,
            readStream: controller.stream,
            size: bytes.length,
            bytes: bytes,
          );
        });
      }
    }
    _showPopupBayar(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.70,
          child: const Center(
            child: Text(
              'Pembayaran',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
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
              ],
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(249, 1, 131, 1.0),
              Color.fromRGBO(128, 38, 198, 1.0)
            ],
          ),
        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 122, 122, 122)
                            .withOpacity(0.15), // Warna bayangan
                        spreadRadius: 0,
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pilih Metode Pembayaran :',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins-bold',
                                fontSize: 12,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Text(
                                'Tranfer Bank',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins-bold',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: PilihTranfer(
                                      context,
                                      "BANK BRI",
                                      "09898087382979427",
                                      "assets/icon/icon_bri.png"),
                                ),
                                Expanded(
                                  child: PilihTranfer(
                                      context,
                                      "BANK BNI",
                                      "09898392787927",
                                      "assets/icon/icon_bni.png"),
                                ),
                                Expanded(
                                  child: PilihTranfer(context, "BANK BCA",
                                      "09898427", "assets/icon/icon_bca.png"),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      _showPopupDetail(
                                          context,
                                          "BANK MANDIRI",
                                          "098983928380980",
                                          "assets/icon/icon_mandiri.png",
                                          50);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 50,
                                      child: Center(
                                        child: Image.asset(
                                          "assets/icon/icon_mandiri.png",
                                          width: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: const Text(
                                'Tranfer E-Money',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Poppins-bold',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: PilihTranfer(
                                      context,
                                      "DANA",
                                      "0812 2121 2312",
                                      "assets/icon/icon_DANA.png"),
                                ),
                                Expanded(
                                  child: Container(
                                    child: PilihTranfer(
                                        context,
                                        "SHOPEE PAY",
                                        "0812 2121 2312",
                                        "assets/icon/icon_SPay.png"),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: PilihTranfer(
                                        context,
                                        "OVO",
                                        "0812 2121 2312",
                                        "assets/icon/icon_OVO.png"),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: PilihTranfer(
                                        context,
                                        "GoPay",
                                        "0812 2121 2312",
                                        "assets/icon/icon_GoPay.png"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Petunjuk Pembayaran :',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Poppins-bold',
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '1.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: const Text(
                                      "Pilih salah satu metode pembayaran di atas",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '2.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: const Text(
                                      "Lakukan Transfer pada metode pembayaran yang sudah dipilih",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '3.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: const Text(
                                      "Screenshot bukti pembayaran jika sudah berhasil melakukan tranfer pada metode pembayaran yang dipilih",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '4.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 10,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: const Text(
                                      "Upload screenshot bukti pembayaran tadi pada tombol Upload pembayaran di halaman ini",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Poppins',
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _showPopupBayar(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 122, 122, 122)
                              .withOpacity(0.15), // Warna bayangan
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      color: const Color.fromRGBO(249, 1, 131, 1.0),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(40),
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: 60,
                    child: const Center(
                      child: Text(
                        "Upload Pembayaran",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InkWell PilihTranfer(
      BuildContext context, String norek, String bank, String logo) {
    return InkWell(
      onTap: () {
        _showPopupDetail(context, norek, bank, logo, 30);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        child: Center(
          child: Image.asset(
            logo,
            width: 30,
          ),
        ),
      ),
    );
  }

  void _showPopupBayar(BuildContext context) async {
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: 'bayar',
        context: context,
        transitionDuration: const Duration(milliseconds: 400),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          Tween<Offset> tween;
          tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
          return SlideTransition(
            position: tween.animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          );
        },
        pageBuilder: (context, _, __) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Center(
              child: Container(
                height: 550,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 246, 246, 246),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.transparent,
                  body: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    border: Border.all(
                                        width: 1, color: Colors.grey)),
                                child: _controller.photoprofile == null
                                    ? const Center(child: Text('Pilih Foto'))
                                    : Image.file(
                                        File(_controller.photoprofile!.path!),
                                        width: double.infinity,
                                      ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            getFilePicker();
                                            Navigator.of(context).pop();
                                          },
                                          child:
                                              _controller.photoprofile == null
                                                  ? const Text("Pilih Foto")
                                                  : const Text(
                                                      "Pilih Foto Lainnya"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            _controller.Pembayaran(id);
                                          },
                                          child: const Text("Unggah foto"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      const Positioned(
                        left: 0,
                        right: 0,
                        bottom: -50,
                        child: Icon(
                          Icons.close_rounded,
                          color: Color.fromARGB(184, 255, 255, 255),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  void _showPopupDetail(BuildContext context, String jenis, String norek,
      String logo, double width) async {
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: 'Detail',
        context: context,
        transitionDuration: const Duration(milliseconds: 400),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          Tween<Offset> tween;
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
          return SlideTransition(
            position: tween.animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          );
        },
        pageBuilder: (context, _, __) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  // height: MediaQuery.of(context).size.height * 0.50,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Header_detail(context, jenis, logo, width),
                      No_rekening(context, norek),
                      jenis.contains('BANK')
                          ? Footer_detail(context)
                          : Footer_detail_emoney(context)
                    ],
                  ),
                ),
              ],
            );
          });
        });
  }

  Container Footer_detail(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Noted :",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins-bold',
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Bayar pesanan Anda ke nomor rekening di atas dengan atas nama ",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          Text(
            '"CV. Anugerah Surya Techindo"',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins-bold',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Container Footer_detail_emoney(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Noted :",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins-bold',
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Bayar pesanan Anda melalui E-money dengan nomor telpon di atas",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container No_rekening(BuildContext context, String norek) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        border: Border(
            top: BorderSide(width: 1, color: Colors.black12),
            bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: const Text(
              "No. Rekening",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 12,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  norek,
                  style: const TextStyle(
                    color: Color.fromRGBO(249, 1, 131, 1.0),
                    fontFamily: 'Poppins',
                    fontSize: 18,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: norek));
                    Get.snackbar(
                      "Disalin",
                      "Rekening disalin ke clipboard",
                      colorText: Colors.white,
                    );
                  },
                  child: const Text(
                    "SALIN",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container Header_detail(
      BuildContext context, String jenis, String logo, double width) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Row(
        children: [
          Image.asset(
            logo,
            width: width,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              jenis,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
