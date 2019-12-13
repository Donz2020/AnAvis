import 'package:an_avis/views/schermata_questionario.dart';
import "package:flutter/material.dart";

class SchermataOrario extends StatefulWidget {
  final String giorno;

  SchermataOrario(this.giorno);

  @override
  _SchermataOrarioState createState() => _SchermataOrarioState();
}

class _SchermataOrarioState extends State<SchermataOrario> {
  String oraSelezionata;

  List<DropdownMenuItem> _getOrariDelGiorno() {
    return [
      DropdownMenuItem(
        child: Text("10:00"),
        value: "10:00",
      ),
      DropdownMenuItem(
        child: Text("11:00"),
        value: "11:00",
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      color: Colors.blue[50],
      child: Column(
        children: <Widget>[
          Text(
            "Scegli l'orario",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.red[900],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(25),
            child: DropdownButton(
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red[900],
              ),
              isExpanded: true,
              value: oraSelezionata,
              items: _getOrariDelGiorno(),
              onChanged: (value) {
                setState(() {
                  oraSelezionata = value;
                });
              },
            ),
          ),
          ButtonTheme(
            minWidth: 300,
            height: 50,
            buttonColor: Colors.blue[100],
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(
                "Compila questionario",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900],
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/questionario");
              },
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                buttonColor: Colors.greenAccent[700],
                child: RaisedButton(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 40,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 10,
              ),
              ButtonTheme(
                buttonColor: Colors.red,
                child: RaisedButton(
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 40,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
