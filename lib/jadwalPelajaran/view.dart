import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import "dart:io";

class JadwalPelajaran extends StatefulWidget {
  const JadwalPelajaran({super.key});

  @override
  State<JadwalPelajaran> createState() => _JadwalPelajaranState();
}

List _listsData = [];

class _JadwalPelajaranState extends State<JadwalPelajaran> {
  Future<dynamic> ListJadwals() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      var url = Uri.parse(
          'http://192.168.63.33:8080/api/jadwal?id_kelas=1&id_siswa=15');
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });
      // print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // print(data);
        setState(() {
          _listsData = data['data'];
          print(_listsData);
        });
      }
    } catch (e) {
      // print(e);
    }
  }

  // Sample data for three lists
  @override
  void initState() {
    super.initState();
    ListJadwals();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Pelajaran',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: _listsData.length,
        itemBuilder: (context, index) => Card(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Hari ${_listsData[index]['hari'].toString()}'),
                  ),
                  const Divider(),
                  ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text('Kelas ${_listsData[index]["nama_kelas"]}'),
                          ),
                          ListTile(
                            title: Text('Jadwal Pelajaran ${_listsData[index]["nama_mapel"]}'),
                          ),
                          ListTile(
                            title: Text('Jam ${_listsData[index]["jam"]}'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
      ),
    );
  }
}

class CardList extends StatefulWidget {
  final List<String> listData;

  CardList({required this.listData});

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: _listsData.length,
            itemBuilder: (_, i) => Card(
              margin: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text('List ${widget.listData[0]}'),
                  ),
                  const Divider(),
                  ListView.builder(
                    itemCount: widget.listData.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(widget.listData[index]),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
