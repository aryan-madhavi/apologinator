import 'dart:convert';
import 'package:http/http.dart' as http;

// Function to send the request to OpenAI API
Future<String> generateApologyMessage(
    String name,
    String tone,
    String relationship,
    String actionDone,
    String messageLength) async {
  const String apiKey = "YOUR_OPENAI_API_KEY";  // Replace with your API key

  // Construct the prompt based on user input
  String prompt = '''
  Write an apology text message in a $tone tone to a $relationship whose name is $name, apologizing for the following reason: 
  "$actionDone". The message should be of $messageLength length.
  The message should be heartfelt and sincere.
  Do not include your name at the end.
  ''';

  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/chat/completions'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: json.encode({
      "model": "gpt-4o-mini", // You can use GPT-3 or GPT-4 if available
      "messages" : [
        {
          "role" : "developer",
          "content" : prompt
        }
      ],
      "temperature": 0.7,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0,
    }),
  );

  // Check if the response is successful
  if (response.statusCode == 200) {
    // Parse the response and return the generated apology message
    final Map<String, dynamic> data = json.decode(response.body);
    return data['choices'][0]['message']['content'].toString().trim();
  } else {
    // If the request failed, return an error message
    throw Exception('Failed to generate apology message');
  }
}