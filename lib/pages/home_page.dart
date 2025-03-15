import 'package:apologinator/services/generate_apology.dart';
import 'package:flutter/material.dart';
//import 'generate_apology.dart'; // The file where we wrote the API function

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Predefined selections
  String _selectedTone = 'Formal';
  String _selectedRelationship = 'Friend';

  String _name = '';
  String _actionDone = '';
  String _messageLength = 'Short';
  bool _isLoading = false;

  // Text controllers
  final TextEditingController _nameController = TextEditingController(text: "XYZ");
  final TextEditingController _actionController = TextEditingController(text: "I made a mistake and I am truly sorry for it");

  // Custom input dialog controllers
  List<String> _tones = ['Formal', 'Casual', 'Humorous', 'Custom'];
  final TextEditingController _customToneController = TextEditingController();
  List<String> _relationships = ['Friend', 'Colleague', 'Partner', 'Family', 'Custom'];
  final TextEditingController _customRelationshipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Apologinator", 
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 32,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              // Action Text
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0, bottom: 48.0),
                  child: Text(
                    "Let's create your apology!", 
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ),
              
              Text("Name:", style: TextStyle(color: Color(0xFFEAEAEA)),),
              SizedBox(height: 5,),
              TextField(
                controller: _nameController,
                maxLines: 1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter their name...',
                ),
              ),
              SizedBox(height: 20),

              // Tone selection
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Tone of the Message",
                  border: OutlineInputBorder(),
                ),
                value: _selectedTone,
                items: _tones.map((tone) => DropdownMenuItem<String>(
                          value: tone,
                          child: Text(tone),
                        ))
                      .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == 'Custom') {
                      _showCustomToneDialog();
                    } else {
                      _selectedTone = value!;
                    }
                  });
                },
              ),
              SizedBox(height: 20),
        
              // Relationship selection
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Relationship to recipient",
                  border: OutlineInputBorder(),
                ),
                value: _selectedRelationship,
                items: _relationships.map((relation) => DropdownMenuItem<String>(
                          value: relation,
                          child: Text(relation),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == 'Custom') {
                      _showCustomRelationshipDialog();
                    } else {
                      _selectedRelationship = value!;
                    }
                  });
                },
              ),
              SizedBox(height: 20),
        
              // Action done input
              Text("What happened (describe the situation):",style: TextStyle(color: Color(0xFFEAEAEA)),),
              SizedBox(height: 5,),
              TextField(
                controller: _actionController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Explain what you did wrong...',
                ),
              ),
              SizedBox(height: 20),
              
              // Length selection
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Length of the message",
                  border: OutlineInputBorder(),
                ),
                value: _messageLength,
                items: ['Short', 'Medium', 'Long']
                    .map((length) => DropdownMenuItem<String>(
                          value: length,
                          child: Text(length),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _messageLength = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              
              _isLoading
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: CircularProgressIndicator(color: Color(0xFFCBA135),)
                      )
                    )
                  : Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                      
                            _name = _nameController.text.isEmpty
                              ? "XYZ"
                              : _nameController.text;

                            // Check if the "Action Done" field is empty, if so use a placeholder
                            _actionDone = _actionController.text.isEmpty
                                ? "I made a mistake and I am truly sorry for it"
                                : _actionController.text;

                            if (_selectedRelationship == 'Custom' || _selectedTone == 'Custom') {
                              _selectedRelationship = _relationships[0];
                              _selectedTone = _tones[0];
                            }
                      
                            // Call the API function to get the apology message
                            try {
                              String apologyMessage = await generateApologyMessage(
                                _name,
                                _selectedTone,
                                _selectedRelationship,
                                _actionDone,
                                _messageLength,
                              )  ;

                              

                              // Navigate to the next screen with the generated apology
                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ApologyScreen(
                                      apologyMessage: apologyMessage),
                                ),
                              );*/
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(apologyMessage),
                              ));
                              
                            } catch (e) {
                              // Handle any error that occurs during the API call
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Failed to generate message: $e'),
                              ));
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                          child: Text("Generate Apology"),
                        ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _customToneController.dispose();
    super.dispose();
  }

  // Custome Tone Dialog
  void _showCustomToneDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Custom Tone'),
          content: TextField(
            controller: _customToneController,
            decoration: InputDecoration(
              hintText: 'Enter tone...',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                String customTone = _customToneController.text.trim();
                if (customTone.isNotEmpty && !_tones.contains(customTone)) {
                  setState(() {
                    _tones.insert(_tones.length - 1, customTone); // Add before "Custom"
                    _selectedTone = customTone;
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Custom Relationship Dialog
  void _showCustomRelationshipDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Custom Relationship'),
          content: TextField(
            controller: _customRelationshipController,
            decoration: InputDecoration(
              hintText: 'Enter relationship...',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  String customValue = _customRelationshipController.text.trim();
                  if (customValue.isNotEmpty && !_relationships.contains(customValue)) {
                    _relationships.insert(_relationships.length - 1, customValue); // Add before "Custom"
                  }
                  _selectedRelationship = customValue;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}