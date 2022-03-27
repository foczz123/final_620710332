import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<dynamic> futureAnimal;

  @override
  void initState() {
    super.initState();
    futureAnimal = fetchAnimal();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder<dynamic>(
            future: futureAnimal,
            builder: (context, snapshot) {
             if (snapshot.hasData) {
                return ListView.builder(//สร้าง Widget ListView
                    padding: EdgeInsets.all(16.0),
                    itemBuilder: (context, i) {
                      //หากไม่สร้าง Object สามารถเรียกใช้งานแบบนี้ได้เลย
                      return _buildRow(snapshot.data[i]['answer'].toString());
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // รูป Spiner ขณะรอโหลดข้อมูล
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
Future<dynamic> fetchAnimal() async {
  final response = await http.get(Uri.parse('https://cpsu-test-api.herokuapp.com/quizzes'),headers: {'id': '620710332'});
  var json = jsonDecode(response.body);
  var animal = json['data'];
  //List<String> list = List<String>.from(json['choice_list']);
  print(animal);
  //print(list);


  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load animal');
  }
}
Widget _buildRow(String dataRow) {
  return ListTile(
    title: Text(
      dataRow,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}