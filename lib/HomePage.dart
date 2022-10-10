import 'package:address/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomeViewModel homeViewModel = HomeViewModel("0.0", "0.0", "", "", 0, 0);

  @override
  Widget build(BuildContext context) {
    print("build called");
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: homeViewModel.onPressed(context),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                textAlign: TextAlign.center,
                initialValue: homeViewModel.latitude,
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  homeViewModel.latitude = value;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: TextFormField(
                textAlign: TextAlign.center,
                initialValue: homeViewModel.longitude,
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  homeViewModel.longitude = value;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "Native: ${homeViewModel.addressFromMethodChannel}  \n Time Taken: ${homeViewModel.timeTakenFromMethodChannel} \n"
                "Inbuilt: ${homeViewModel.addressFromPlaceMark}  \n Time Taken: ${homeViewModel.timeTakenFromPlaceMark}",
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
