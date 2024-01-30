import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'NearbyLocationPage.dart';

void main() {
  runApp(NearbyLocationListPage());
}

class NearbyLocationListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NearbyLocationsScreen(),
    );
  }
}

class NearbyLocationsScreen extends StatefulWidget {
  @override
  _NearbyLocationsScreenState createState() => _NearbyLocationsScreenState();
}

class _NearbyLocationsScreenState extends State<NearbyLocationsScreen> {
  Position? _currentPosition;
  List<LocationData> _locations = [
    LocationData(
      name: "Taylor’s University",
      latitude: 3.0698,
      longitude: 101.5986,
      isAvailable: true,
      address: "1, Jln Taylors, 47500 Subang Jaya, Selangor",
    ),
    LocationData(
      name: "Sunway Geo Residences",
      latitude: 3.0731,
      longitude: 101.6077,
      isAvailable: false,
      address: "Persiaran Tasik Timur, Sunway South Quay, Bandar Sunway, 47500 Subang Jaya, Selangor",
    ),
    LocationData(
      name: "Tropicana City Office Tower",
      latitude: 3.1339,
      longitude: 101.6381,
      isAvailable: true,
      address: "Ground Floor, Damansara Intan, 40150 Petaling Jaya, Selangor",
    ),
    LocationData(
      name: "Garden Plaza",
      latitude: 2.9254,
      longitude: 101.6597,
      isAvailable: false,
      address: "Persiaran Harmoni, Cyber 3, 62000 Cyberjaya, Selangor",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentPosition = Position(
      latitude: 3.0698,
      longitude: 101.5986,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  double _calculateDistance(LocationData location) {
    if (_currentPosition != null) {
      double distanceInMeters = Geolocator.distanceBetween(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
        location.latitude,
        location.longitude,
      );
      return distanceInMeters / 1000; // Convert meters to kilometers
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearby Locations"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NearbyLocationPage()),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: _locations.length,
        itemBuilder: (context, index) {
          LocationData location = _locations[index];
          double distance = _calculateDistance(location);

          return LocationCard(
            name: location.name,
            distance: "${distance.toStringAsFixed(2)} KM",
            address: location.address,
            isAvailable: location.isAvailable,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getCurrentLocation();
        },
        child: Icon(
          Icons.location_on,
          color: Colors.black),
        backgroundColor: Color(0xFFD7ECF7),
      ),
    );
  }
}

class LocationData {
  final String name;
  final double latitude;
  final double longitude;
  final bool isAvailable;
  final String address;

  LocationData({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.isAvailable,
    required this.address,
  });
}

class LocationCard extends StatelessWidget {
  final String name;
  final String distance;
  final String address;
  final bool isAvailable;

  LocationCard({
    required this.name,
    required this.distance,
    required this.address,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          isAvailable ? Icons.check_circle : Icons.cancel,
          color: isAvailable ? Colors.green : Colors.red,
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(distance, style: const TextStyle(color: Colors.grey)),
            Text(address), // Display the address here
          ],
        ),
      ),
    );
  }
}
