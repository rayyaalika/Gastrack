// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gastrack/controller/updatedatauserController.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapsAlamat extends StatefulWidget {
  const MapsAlamat({Key? key}) : super(key: key);

  @override
  State<MapsAlamat> createState() => _HomePageState();
}

class _HomePageState extends State<MapsAlamat> {
  final UpdateDataUserController _controller = UpdateDataUserController();
  //get map controller to access map
  final Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  late LatLng _draggedtLatLng;
  late String stringLatLng;
  late String Kelurahan = "Mencari Lokasi";
  late String Alamat = "... ... ... ...";

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() {
    //set default latlng for camera position
    _defaultLatLng = const LatLng(-7, 130);
    _draggedtLatLng = _defaultLatLng;
    stringLatLng = _draggedtLatLng.toString();
    _cameraPosition =
        CameraPosition(target: _defaultLatLng, zoom: 15 // number of map view
            );

    //map will redirect to my current location when loaded
    _gotoUserCurrentPosition();
    getLatlong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(children: [_getMap(), _getCustomPin(), _showDraggedAddress()]);
  }

  Widget _showDraggedAddress() {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 122, 122, 122)
                        .withOpacity(0.15), // Warna bayangan
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(71, 109, 109, 109)
                          .withOpacity(0.15),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Tentukan Titik Lokasi Anda',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.black38,
                          width: 1,
                        )),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                      ),
                      onPressed: () {
                        _gotoUserCurrentPosition();
                      },
                      child: const Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.gps_fixed,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "Gunakan Lokasi Saat Ini",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 15,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            // Salin alamat ketika teks diketuk
                            Clipboard.setData(
                                ClipboardData(text: _controller.latlong));
                            // Tampilkan pesan atau umpan balik lainnya
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Koordinat disalin ke clipboard'),
                              ),
                            );
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              _controller.latlong,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black26,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Salin alamat ketika teks diketuk
                            Clipboard.setData(ClipboardData(
                                text: _controller.draggedAddress));
                            // Tampilkan pesan atau umpan balik lainnya
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Alamat disalin ke clipboard'),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsetsDirectional.symmetric(
                                vertical: 10),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Text(
                                        Kelurahan,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 2),
                                        child: Icon(
                                          Icons.not_listed_location_sharp,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    Alamat,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black45,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(249, 1, 131, 1.0),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 122, 122, 122)
                                          .withOpacity(0.55), // Warna bayangan
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: const RoundedRectangleBorder(),
                              ),
                              onPressed: () {
                                _controller.ChangeAlamat();
                              },
                              child: const Text(
                                "Pilih Lokasi & Lanjutkan",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getMap() {
    return GoogleMap(
      initialCameraPosition:
          _cameraPosition!, //initialize camera position for map
      mapType: MapType.normal,
      onCameraIdle: () {
        //this function will trigger when user stop dragging on map
        //every time user drag and stop it will display address
        _getAddress(_draggedtLatLng);
      },
      onCameraMove: (cameraPosition) {
        //this function will trigger when user keep dragging on map
        //every time user drag this will get value of latlng
        _draggedtLatLng = cameraPosition.target;
        stringLatLng = _draggedtLatLng.toString();
        getLatlong();
      },
      onMapCreated: (GoogleMapController controller) {
        //this function will trigger when map is fully loaded
        if (!_googleMapController.isCompleted) {
          //set controller to google map when it is fully loaded
          _googleMapController.complete(controller);
        }
      },
    );
  }

  Widget _getCustomPin() {
    return Center(
      child: SizedBox(
        width: 50,
        child: Lottie.asset("assets/js/pin.json"),
      ),
    );
  }

  //get address from dragged pin
  Future _getAddress(LatLng position) async {
    //this will list down all address around the position
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark address = placemarks[0]; // get only first and closest address
    String kelurahan = "${address.subLocality}";
    String alamat =
        "${address.locality}, ${address.subAdministrativeArea}, ${address.administrativeArea}, ${address.country}";
    String addresStr =
        "${address.street}, ${address.subLocality}, ${address.locality}, ${address.subAdministrativeArea}, ${address.administrativeArea}, ${address.country}";
    setState(() {
      _controller.draggedAddress = addresStr;
      Kelurahan = kelurahan;
      Alamat = alamat;
    });
  }

  Future getLatlong() async {
    final match = RegExp(r'LatLng\(([^)]+)\)').firstMatch(stringLatLng);

    if (match != null) {
      final latLngString = match.group(1);
      setState(() {
        _controller.latlong = '$latLngString';
      });
    }
  }

  //get user's current location and set the map's camera to that location
  Future _gotoUserCurrentPosition() async {
    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
        LatLng(currentPosition.latitude, currentPosition.longitude));
  }

  //go to specific position by latlng
  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 17.5)));
    //every time that we dragged pin , it will list down the address here
    await _getAddress(position);
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {
      print("user don't enable location permission");
    }

    locationPermission = await Geolocator.checkPermission();

    //check if user denied location and retry requesting for permission
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        print("user denied location permission");
      }
    }

    //check if user denied permission forever
    if (locationPermission == LocationPermission.deniedForever) {
      print("user denied permission forever");
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }
}
