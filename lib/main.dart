import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Invest Calculator App', 
      home: CalculateFrom(),
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        accentColor: Colors.blueAccent
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
  final minimumPadding = 5.0;
  
  var currencies = ['COP','USD','EUR'];
  var currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    currentItemSelected = currencies[0];
  }

  TextEditingController principalValueController = TextEditingController();
  TextEditingController rateValueController = TextEditingController();
  TextEditingController timeValueController = TextEditingController();

  var displayText = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
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
                controller: principalValueController,
                decoration: InputDecoration(
                  labelText: 'Principal value',
                  hintText: 'Enter principal value, ej, 10000',
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
                controller: rateValueController,
                decoration: InputDecoration(
                  labelText: 'Rate of interest',
                  hintText: 'Enter percent value',
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
                      controller: timeValueController,
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
                      value: currentItemSelected,
                      onChanged: (String newValueSelected) {
                        dropDownItemSelected(newValueSelected);
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
                        setState(() {
                          displayText = calculateTotal();
                        });
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
                        setState(() {
                          reset();
                        });
                      }
                    ),
                  )
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.all(minimumPadding * 2),
              child: Text(displayText, style: textStyle)
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

  void dropDownItemSelected(String newValueSelected) {
    setState(() {
      this.currentItemSelected = newValueSelected;
    });
  }

  String calculateTotal() {
    double principal = double.parse(principalValueController.text);
    double rate = double.parse(rateValueController.text);
    double time = double.parse(timeValueController.text);

    double result = principal + (principal * rate * time) / 100;

    return 'After $time years your investment will be worth $result in $currentItemSelected';
  }

  void reset() {
    principalValueController.text = '';
    rateValueController.text = '';
    timeValueController.text = '';

    displayText = '';
    currentItemSelected = currencies[0];
  }
}
