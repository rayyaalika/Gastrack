// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_element, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gastrack/page/BayarPage.dart';
import 'package:gastrack/provider/TransaksiProvider.dart';
import 'package:gastrack/page/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:gastrack/provider/Base_provider.dart';

class DetailTransaksi extends StatefulWidget {
  const DetailTransaksi({super.key, required this.id});

  final int id;

  @override
  State<DetailTransaksi> createState() => _MyStatefulWidgetState();
}
// {
//   'id_transaksi': 2,
//   'nama_agen': "haasstt",
//   'koordinat': "-7.656374139475053, 111.53173729777336",
//   'tanggal_pemesanan': "2023-10-26 16:12",
//   'status_pengiriman': "Belum Dikirim",
//   'resi_transaksi': "GTK-202310261612433W",
//   'nama_gas': "Gas Melon",
//   'harga_gas': 20000,
//   'jenis_gas': "Isi Ulang",
//   'berat_gas': 3,
//   'tanggal_pembayaran': null,
//   'status_pembayaran': "Belum Bayar",
//   'jumlah_transaksi': 2,
//   'total_transaksi': 40000
// }

class _MyStatefulWidgetState extends State<DetailTransaksi> {
  final BaseProvider _baseProvider = BaseProvider();
  late var id = widget.id.toInt();
  List<Map<String, dynamic>> DataDetailTransaksi = [];

  @override
  void initState() {
    TransaksiProvider().getDataTransaksiById(id).then((value) {
      if (value.statusCode == 200) {
        var data = value.body['datauser'][0];
        setState(() {
          DataDetailTransaksi.add(data);
        });
        // print(data);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.70,
          child: const Center(
            child: Text(
              'Detail Transaksi',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
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
        child: DataDetailTransaksi.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DataDetailTransaksi[0]['status_pengiriman'] == 'Belum Dikirim'
                      ? DataDetailTransaksi[0]['status_pembayaran'] ==
                              'Belum Bayar'
                          ? const AppbardetailTransaksi(
                              Status: 'Pesanan Menunggu Pembayaran',
                              icon: FontAwesomeIcons.tag,
                              background: Color.fromRGBO(128, 38, 198, 1.0),
                            )
                          : const AppbardetailTransaksi(
                              Status: 'Pesanan diproses',
                              icon: FontAwesomeIcons.arrowRotateLeft,
                              background: Color.fromRGBO(189, 20, 165, 1.0),
                            )
                      : DataDetailTransaksi[0]['status_pengiriman'] == 'Dikirim'
                          ? const AppbardetailTransaksi(
                              Status: 'Pesanan dikirim',
                              icon: FontAwesomeIcons.truck,
                              background: Color.fromRGBO(249, 1, 131, 1.0),
                            )
                          : const AppbardetailTransaksi(
                              Status: 'Pesanan Selesai',
                              icon: FontAwesomeIcons.circleCheck,
                              background: Color.fromRGBO(0, 218, 153, 1.0),
                            ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.grey.withOpacity(0.25), // Warna bayangan
                          spreadRadius: 0, // Seberapa jauh bayangan menyebar
                          blurRadius: 4, // Seberapa kabur bayangan
                          offset: const Offset(0, 1), // Posisi bayangan (x, y)
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 25),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.asset(
                            "assets/icon/location_icon.png",
                            width: 30,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'Alamat Pengiriman',
                                  style: TextStyle(
                                    fontFamily: 'Poppins-bold',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: FutureBuilder<Widget>(
                                  future: getdetailAlamat(
                                      DataDetailTransaksi[0]['koordinat']),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<Widget> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return snapshot.data ??
                                          const Text('Memuat ulang alamat...');
                                    } else {
                                      return const Text(
                                          'Memuat ulang alamat...');
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.grey.withOpacity(0.25), // Warna bayangan
                          spreadRadius: 0, // Seberapa jauh bayangan menyebar
                          blurRadius: 4, // Seberapa kabur bayangan
                          offset: const Offset(0, 1), // Posisi bayangan (x, y)
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.asset(
                            "assets/icon/belumbayar_icon.png",
                            width: 30,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Informasi Pembayaran',
                                style: TextStyle(
                                  fontFamily: 'Poppins-bold',
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                DataDetailTransaksi[0]['status_pembayaran'],
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 9,
                                  color: Colors.black26,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: DataDetailTransaksi[0]
                                                ['status_pembayaran'] ==
                                            'Belum Bayar'
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                  child: BayarTransaksiPage(
                                                    id: id,
                                                  ),
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              "Bayar Sekarang",
                                              style: TextStyle(
                                                fontFamily: 'Poppins-bold',
                                                fontSize: 9,
                                                color: Color.fromRGBO(
                                                    249, 1, 131, 1.0),
                                              ),
                                            ),
                                          )
                                        : DataDetailTransaksi[0]
                                                    ['status_pembayaran'] ==
                                                'Sudah Bayar'
                                            ? InkWell(
                                                onTap: () {
                                                  _showPopupBuktiPembayaran(
                                                      context);
                                                },
                                                child: const Text(
                                                  "Lihat Bukti Pembayaran",
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins-bold',
                                                    fontSize: 9,
                                                    color: Color.fromRGBO(
                                                        249, 1, 131, 1.0),
                                                  ),
                                                ),
                                              )
                                            : const Text(
                                                "Pembayaran Sedang diproses",
                                                style: TextStyle(
                                                  fontFamily: 'Poppins-bold',
                                                  fontSize: 9,
                                                  color: Color.fromRGBO(
                                                      249, 1, 131, 1.0),
                                                ),
                                              ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 25),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.25), // Warna bayangan
                            spreadRadius: 0, // Seberapa jauh bayangan menyebar
                            blurRadius: 4, // Seberapa kabur bayangan
                            offset:
                                const Offset(0, 1), // Posisi bayangan (x, y)
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                // color: Colors.red,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Pemesanan",
                                      style: TextStyle(
                                        fontFamily: 'Poppins-bold',
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${(DataDetailTransaksi[0]['jenis_gas'])} ${(DataDetailTransaksi[0]['nama_gas'])} ${(DataDetailTransaksi[0]['berat_gas'].toString())} Kg',
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ),
                                        Text(
                                          '${(DataDetailTransaksi[0]['jumlah_transaksi'])} buah',
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Detail Pembayaran",
                                          style: TextStyle(
                                            fontFamily: 'Poppins-bold',
                                            fontSize: 14,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Harga Gas',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ),
                                              Text(
                                                '${(DataDetailTransaksi[0]['jumlah_transaksi'])} buah x Rp${(DataDetailTransaksi[0]['harga_gas'])}',
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomPaint(
                                                size: Size(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        .85,
                                                    1),
                                                painter: DashedLinePainter(),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                  'Total Transaksi',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  ),
                                                ),
                                                Text(
                                                  'Rp${(DataDetailTransaksi[0]['total_transaksi'])}',
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomPaint(
                                                size: Size(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        .85,
                                                    1),
                                                painter: DashedLinePainter(),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "No. Pemesanan",
                                          style: TextStyle(
                                            fontFamily: 'Poppins-bold',
                                            fontSize: 14,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                        ),
                                        Text(
                                          '${(DataDetailTransaksi[0]['resi_transaksi'])}',
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            color: Color.fromRGBO(
                                                128, 38, 198, 1.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Waktu Pemesanan",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                            ),
                                            Text(
                                              '${(DataDetailTransaksi[0]['tanggal_pemesanan'])}',
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Waktu Pembayaran",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                            ),
                                            DataDetailTransaksi[0][
                                                        'tanggal_pembayaran'] ==
                                                    null
                                                ? const Text(
                                                    "Belum melakukan pembayaran",
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                    ),
                                                  )
                                                : Text(
                                                    '${(DataDetailTransaksi[0]['tanggal_pembayaran'])}',
                                                    style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Waktu Pengiriman",
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                            ),
                                            DataDetailTransaksi[0][
                                                        'tanggal_pengiriman'] ==
                                                    null
                                                ? const Text(
                                                    'Pesanana Sedang Diproses',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                    ),
                                                  )
                                                : Text(
                                                    '${(DataDetailTransaksi[0]['tanggal_pengiriman'])}',
                                                    style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _showPopupBuktiPembayaran(BuildContext context) async {
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: 'bukti pembayaran',
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
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.network(
                    ' ${(_baseProvider.UrlImage)}/${(DataDetailTransaksi[0]['bukti_pembayaran'])}',
                    fit: BoxFit.contain,
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
            );
          });
        });
  }
}

class AppbardetailTransaksi extends StatelessWidget {
  const AppbardetailTransaksi(
      {super.key,
      required this.Status,
      required this.icon,
      required this.background});

  final String Status;
  final icon;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: background,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 22),
      child: Row(
        children: [
          Text(
            Status,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 5),
              child: FaIcon(
                icon,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black12
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    const double dashWidth = 5.0;
    const double dashSpace = 5.0;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
