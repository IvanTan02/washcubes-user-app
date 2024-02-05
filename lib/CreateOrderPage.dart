import 'package:flutter/material.dart';

class CreateOrderPage extends StatefulWidget {
  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  String selectedLocker = '';

  void _handleLockerSelection(String status) {
    setState(() {
      selectedLocker = status;
    });

    if (status == 'available') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => PickOrderPage()));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Locker is Occupied'),
            content: Text('Please choose another locker.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Locker'),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: 24,
          itemBuilder: (BuildContext context, int index) {
            final status = index == 4 || index == 8 || index == 11 ? 'available' : 'occupied';
            final isAvailable = status == 'available';
            final lockerNumber = 'L${(index + 1).toString().padLeft(2, '0')}';

            return GestureDetector(
              onTap: () => _handleLockerSelection(status),
              child: Container(
                margin: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey),
                  color: isAvailable ? Colors.green : Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      lockerNumber,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(status),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PickOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Order'),
      ),
      body: Center(
        child: Text('Pick your order from the locker.'),
      ),
    );
  }
}
//
// void main() {
//   runApp(MaterialApp(home: CreateOrderPage()));
// }
