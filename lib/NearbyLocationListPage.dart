import 'package:flutter/material.dart';

class NearbyLocationListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Nearby Locations'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildLocationTile(
                  'Taylor\'s University',
                  '1, Jln Taylors, 47500 Subang Jaya, Selangor',
                  '900 M',
                  true,
                ),
                _buildLocationTile(
                  'Sunway Geo Residences',
                  'Persiaran Tasik Timur, Sunway South Quay, Bandar Sunway, 47500 Subang Jaya, Selangor',
                  '1.6 KM',
                  false,
                ),
                _buildLocationTile(
                  'Tropicana City Office Tower',
                  'Ground Floor, Damansara Intan, 40150 Petaling Jaya, Selangor',
                  '15 KM',
                  true,
                ),
                _buildLocationTile(
                  'Garden Plaza',
                  'Persiaran Harmoni, Cyber 3, 62000 Cyberjaya, Selangor',
                  '34 KM',
                  false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationTile(
      String title,
      String address,
      String distance,
      bool isAvailable,
      ) {
    return ListTile(
      leading: Icon(
        isAvailable ? Icons.check_circle : Icons.cancel,
        color: isAvailable ? Colors.green : Colors.red,
      ),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(address),
          Text(
            distance,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
