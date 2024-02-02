import 'package:flutter/material.dart';
import 'CreateOrderCameraPage.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
        actions: [
           Container(
          margin: EdgeInsets.only(right: 16), 
          child: ElevatedButton.icon(
            onPressed: () {
                showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("i3wash Would Like to Access the Camera"),
              content: Text("Allow access to your camera?"),
              actions: <Widget>[
                TextButton(
                  child: Text("Don't Allow"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                  Navigator.of(context).pop();
                   Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CreateOrderCameraPage(),
                    ),
                  );
          },
        ),
      ],
    );
  },
);

            },
            icon: Icon(Icons.add),
            label: Text('Create'), 
            style: ElevatedButton.styleFrom(
              primary: Colors.blue, 
              onPrimary: Colors.white, 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), 
              ),
              padding: EdgeInsets.symmetric(horizontal: 16), 
            ),
          ),
        )

        ],
      ),
      body: ListView(
        children: <Widget>[
          OrderCard(orderNumber: '131233213', date: 'NOV 23', location: 'Taylor’s University', status: 'Collected by Operator'),
          OrderCard(orderNumber: '131233233', date: 'NOV 24', location: 'Taylor’s University', status: 'Order Error'),
          OrderCard(orderNumber: '131233443', date: 'NOV 26', location: 'Taylor’s University', status: 'In Progress'),
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String date;
  final String location;
  final String status;

  OrderCard({
    Key? key,
    required this.orderNumber,
    required this.date,
    required this.location,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: status == 'Order Error' ? Colors.red.shade100 : Colors.blue.shade100,
      child: ListTile(
        title: Text('Order No: $orderNumber'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Location: $location'),
            Text('Status: $status'),
          ],
        ),
        trailing: Text(date),
        onTap: () {
          // Handle the tap if necessary
        },
      ),
    );
  }
}
