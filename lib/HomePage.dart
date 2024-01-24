import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Notification icon and circle avatar
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.notifications, color: Colors.blue),
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Good Morning Text
              const Text(
                'Good Morning, Trimity!',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              // Discover Text
              const Text(
                'Discover your closest\nlaundry lockers',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              // Location Button
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.location_on),
                    Text("Taylor's University"),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Special Event Title
              const Text(
                'Special Event',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // RecyclerView for images
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4, // The number of items in the list
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset(
                          'assets/images/special_event_${index + 1}.png'
                      ),
                    );
                  },
                ),
              ),
              const Divider(),
              const Text(
                'Ongoing Order',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // Ongoing Order Section
              const SizedBox(height: 5),// ...

              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    // Left side (6 flex)
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '#906912',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Laundry In Progress',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '“Leave it to Trimi - cleaning\nmagic in progress!”',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Stack(
                            children: <Widget>[
                              Container(
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Container(
                                height: 10,
                                width: 200 * 0.7, // Assuming the container is 200 wide, 70% filled
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const Positioned(
                                right: 10,
                                top: -2,
                                child: Text(
                                  '70%',
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Implement the button action
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white, // Button color
                              onPrimary: Colors.black, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: const Text('Check'),
                          ),
                        ],
                      ),
                    ),
                    // Right side (4 flex)
                    Expanded(
                      flex: 4,
                      child: Container(
                        // Placeholder for the image
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/hp_order_1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
