import 'package:flutter/material.dart';
import 'package:recipe/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Username extends StatefulWidget {
  const Username({super.key});

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  TextEditingController username = TextEditingController();
  String warning = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade400,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           CircleAvatar(
            radius: 80,
            backgroundColor:Colors.orange.shade400 ,
            backgroundImage:  AssetImage('assets/chef.png',)),
          SizedBox(height: 20),
          Text(
            'Welcome to RecipeX!',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 350,
              child: TextField(
                onChanged: (_) {
                  setState(() {
                    if (username != '') {
                      warning = '';
                    }
                  });
                },
                controller: username,
                decoration: InputDecoration(
                  hintText: 'Enter username here',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 1.5, color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(width: 1.5, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          warning != ''
              ? Text(
                  warning,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                )
              : SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              var pref = await SharedPreferences.getInstance();
              await pref.setString('username', username.text.trim());
              if (username.text.isNotEmpty) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Homepage()),
                );
              } else {
                warning = 'Please enter username!';
                setState(() {
                  
                });
              }
            },
            child: Text(
              'Proceed',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
