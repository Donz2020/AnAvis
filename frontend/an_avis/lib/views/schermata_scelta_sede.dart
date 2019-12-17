import 'package:an_avis/models/prenotazione.dart';
import 'package:an_avis/widgets/circular_loading.dart';
import 'package:an_avis/widgets/pulsante_listview.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert";

import 'package:provider/provider.dart';

class SchermataSceltaSede extends StatefulWidget {
  @override
  _SchermataSceltaSedeState createState() => _SchermataSceltaSedeState();
}

class _SchermataSceltaSedeState extends State<SchermataSceltaSede> {
  TextEditingController controller = new TextEditingController();
  String filter;

  Future<List<PulsanteListView>> _getSediAvis() async {
    http.Response response =
        await http.get("http://10.0.2.2:8080/prenotazioni");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<PulsanteListView> sediAvis = [];
      for (var d in data) {
        sediAvis.add(PulsanteListView(
            text: d["sede"]["citta"],
            function: () => Navigator.pushNamed(context, "/sceltaMese")));
      }
      return sediAvis;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  @override
  initState() {
    super.initState();
    _getSediAvis();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(Provider.of<PrenotazioneProvider>(context).tipoDonazione);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.red[900],
              height: 4.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
        backgroundColor: Colors.blue[900],
        title: Text(
          "Scegli la sede in cui donare",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Roboto",
              ),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Cerca sede",
                  fillColor: Colors.red,
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 32.0),
                      borderRadius: BorderRadius.circular(25.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 32.0),
                      borderRadius: BorderRadius.circular(25.0))),
              controller: controller,
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: _getSediAvis(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return new RequestCircularLoading();
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return new RequestCircularLoading();
                    case ConnectionState.done:
                      if (snapshot.hasError)
                        return new RequestCircularLoading();
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return filter == null || filter == ""
                              ? snapshot.data[index]
                              : snapshot.data[index].text
                                      .toLowerCase()
                                      .contains(filter.toLowerCase())
                                  ? snapshot.data[index]
                                  : Container();
                        },
                      );
                  }
                  return null;
                }),
          ),
        ],
      ),
    );
  }
}
