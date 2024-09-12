import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';  // Ensure this import is correct and the package is installed

// Function to perform string manipulations
Map<String, dynamic> manipulateString(String userInput) {
  return {
    'original': userInput,
    'uppercase': userInput.toUpperCase(),
    'reversed': userInput.split('').reversed.join(),
    'length': userInput.length
  };
}

// Function to save data to a file with date and time
Future<void> saveToFile(List<Map<String, dynamic>> data) async {
  final file = File('manipulated_data_log.txt');
  final sink = file.openWrite(mode: FileMode.append);

  for (var entry in data) {
    sink.writeln('Time: ${entry['timestamp']}');
    sink.writeln('Original: ${entry['original']}');
    sink.writeln('Uppercase: ${entry['uppercase']}');
    sink.writeln('Reversed: ${entry['reversed']}');
    sink.writeln('Length: ${entry['length']}');
    sink.writeln('-' * 40);
  }

  await sink.close();
}

void main() async {
  List<Map<String, dynamic>> results = []; // Collection to store manipulated results

  while (true) {
    // Accept user input
    stdout.write("Enter a string to manipulate (or 'exit' to quit): ");
    String userInput = stdin.readLineSync(encoding: utf8)!;

    // Break the loop if the user types 'exit'
    if (userInput.toLowerCase() == 'exit') {
      break;
    }

    // Perform string manipulation
    var manipulatedData = manipulateString(userInput);

    // Add timestamp to the manipulated data
    manipulatedData['timestamp'] = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    // Store the result in the list
    results.add(manipulatedData);

    // Display the manipulated data
    print("\nManipulated Data:");
    print("Original: ${manipulatedData['original']}");
    print("Uppercase: ${manipulatedData['uppercase']}");
    print("Reversed: ${manipulatedData['reversed']}");
    print("Length: ${manipulatedData['length']}");
    print("Timestamp: ${manipulatedData['timestamp']}\n");
  }

  // Save all results to a file
  await saveToFile(results);
  print("All manipulated data has been saved to 'manipulated_data_log.txt'.");
}
