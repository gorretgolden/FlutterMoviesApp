import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigate to login screen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the logo from the internet
            Image.network(
              'https://example.com/your-logo.png', // Replace with your logo's URL
              height: 150, // Adjust the height as needed
              width: 150, // Adjust the width as needed
            ),
            SizedBox(height: 20), // Add spacing between logo and text
            Text(
              'MovieApp',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Future: In Flutter/Dart, a Future represents a value that will be available at
// some point in the future, such as after a delay or the completion of an asynchronous operation.
// Future.delayed(Duration, Function): This method is a convenience function that schedules a piece
// of code (the provided callback function) to run after a specified amount of time (defined by the Duration).

// Clean navigation: Using Navigator.pushReplacementNamed ensures the splash screen is not accessible
// via the back button, improving the flow of the app.