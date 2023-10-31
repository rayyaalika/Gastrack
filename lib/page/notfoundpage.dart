import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
        height: MediaQuery.sizeOf(context).height,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: Lottie.asset("assets/js/notfound_page.json"),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Halaman Tidak Tersedia',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      fontFamily: 'Poppins-bold',
                      color: Colors.black),
                ),
              ),
              SizedBox(
                width: 250,
                child: Text(
                  'Mohon maaf halaman ini sedang dalam pengerjaan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    color: Colors.black.withOpacity(0.25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
