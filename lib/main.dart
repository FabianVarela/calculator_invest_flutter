import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Invest Calculator App', 
      home: CalculateFrom(),
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        accentColor: Colors.blueAccent,
        brightness: Brightness.dark
      ),
    )
  );
}

class CalculateFrom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalculateFormState();
  }
}

class CalculateFormState extends State<CalculateFrom> {
  var currencies = ['COP','USD','EUR','Other'];
  final minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Invest Calculator')
      ),
      body: Container(
        margin: EdgeInsets.all(minimumPadding * 2),
        child: ListView(
          children: <Widget>[
            getAssetImage(),
            Padding(
              padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
              child: TextField(
                keyboardType: TextInputType.number,
                style: textStyle,
                decoration: InputDecoration(
                  labelText: 'Principal value',
                  hintText: 'Enter percent value',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
              child: TextField(
                keyboardType: TextInputType.number,
                style: textStyle,
                decoration: InputDecoration(
                  labelText: 'Rate of interest',
                  hintText: 'Enter principal value, ej, 10000',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      decoration: InputDecoration(
                        labelText: 'Time',
                        hintText: 'Time in years',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                        )
                      ),
                    )
                  ),
                  Container(width: minimumPadding * 5),
                  Expanded(
                    child: DropdownButton<String>(
                      items: currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value)
                        );
                      }).toList(),
                      value: currencies[0],
                      onChanged: (String newValueSelected) {

                      },
                    )
                  )
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('Calculate', textScaleFactor: 1.5),
                      onPressed: () {

                      }
                    ),
                  ),
                  Container(width: minimumPadding *1),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.grey,
                      textColor: Colors.white,
                      child: Text('Reset', textScaleFactor: 1.5),
                      onPressed: () {
                        
                      }
                    ),
                  )
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.all(minimumPadding * 2),
              child: Text('Todo text', style: textStyle)
            )
          ],
        )
      )
    );
  }

  Widget getAssetImage() {
    AssetImage assetImage = AssetImage('images/invest.png');
    Image image = Image(image: assetImage, width: 125, height: 125);

    return Container(child: image, margin: EdgeInsets.all(minimumPadding * 10));
  }
}
