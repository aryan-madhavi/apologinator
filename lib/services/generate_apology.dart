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
  Ensure that the message is grammatically correct and has no errors.
  ''';

  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/chat/completions'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
      'Accept': 'application/json; charset=UTF-8'
    },
    body: json.encode({
      "model": "gpt-4o-mini",
      "messages": [
        {
          "role": "user", 
          "content": prompt
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
    // Properly decode UTF-8 response to prevent character encoding issues
    final String responseBody = utf8.decode(response.bodyBytes);
    final Map<String, dynamic> data = json.decode(responseBody);
    // Extract the message content
    //print(data['choices'][0]['message']['content'].toString().trim());
    return data['choices'][0]['message']['content'].toString().trim();
  } else {
    //print('Error ${response.statusCode}: ${response.body}');
    throw Exception('Failed to generate apology message');
  }
}