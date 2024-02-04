import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackRatingsPage extends StatefulWidget {
  const FeedbackRatingsPage({super.key});

  @override
  _FeedbackRatingsPageState createState() => _FeedbackRatingsPageState();
}

class _FeedbackRatingsPageState extends State<FeedbackRatingsPage> {
  double _rating = 0;
  final _improvementOptions = [
    'Overall Service',
    'Pick Up and Delivery Service',
    'Payment Process',
    'Speed & Efficiency',
    'Order Status Updates',
    'Customer Support'
  ];
  final _selectedImprovements = <String>{};
  final _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Ratings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Rate Our Service',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Are you satisfied with our service?'),
          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Tell us what can be improved?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Wrap(
            spacing: 8,
            children: _improvementOptions.map((option) {
              return ChoiceChip(
                label: Text(option),
                selected: _selectedImprovements.contains(option),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedImprovements.add(option);
                    } else {
                      _selectedImprovements.remove(option);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _feedbackController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Tell us how we can improve...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text('Submit'),
            onPressed: () {
              // Implement submission logic
              print('Rating: $_rating');
              print('Improvements: ${_selectedImprovements.join(', ')}');
              print('Feedback: ${_feedbackController.text}');
            },
          ),
        ],
      ),
    );
  }
}
