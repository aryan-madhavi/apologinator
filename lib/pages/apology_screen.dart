import 'package:flutter/material.dart';

class ApologyScreen extends StatelessWidget {
  final String apologyMessage;

  ApologyScreen({required this.apologyMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Apology"),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Here is your generated apology message:", style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              Text(
                apologyMessage,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);  // Navigate back to the main screen
                },
                child: Text("Go Back"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}