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
  final _minimumPadding = 5.0;

  var _formKey = GlobalKey<FormState>();
  var _currencies = ['COP','USD','EUR'];
  var _currentItemSelected = '';

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding * 2),
          child: ListView(
            children: <Widget>[
              getAssetImage(),
              Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalValueController,
                  validator: (String value) {
                    if(value.isEmpty) {
                      return 'Please enter principal amount';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Principal value',
                    hintText: 'Enter principal value, ej, 10000',
                    labelStyle: textStyle,
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 15
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: rateValueController,
                  validator: (String value) {
                    if(value.isEmpty) {
                      return 'Please enter rate value';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Rate of interest',
                    hintText: 'Enter percent value',
                    labelStyle: textStyle,
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 15
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: textStyle,
                        controller: timeValueController,
                        validator: (String value) {
                          if(value.isEmpty) {
                            return 'Please enter the time value';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Time',
                          hintText: 'Time in years',
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 15
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                          )
                        ),
                      )
                    ),
                    Container(width: _minimumPadding * 5),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value)
                          );
                        }).toList(),
                        value: _currentItemSelected,
                        onChanged: (String newValueSelected) {
                          dropDownItemSelected(newValueSelected);
                        },
                      )
                    )
                  ],
                )
              ),
              Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Text('Calculate', textScaleFactor: 1.5),
                        onPressed: () {
                          setState(() {
                            if(_formKey.currentState.validate()) {
                              displayText = calculateTotal();
                            }
                          });
                        }
                      ),
                    ),
                    Container(width: _minimumPadding *1),
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
                padding: EdgeInsets.all(_minimumPadding * 2),
                child: Text(displayText, style: textStyle)
              )
            ],
          )
        )
      )
    );
  }

  Widget getAssetImage() {
    AssetImage assetImage = AssetImage('images/invest.png');
    Image image = Image(image: assetImage, width: 125, height: 125);

    return Container(child: image, margin: EdgeInsets.all(_minimumPadding * 10));
  }

  void dropDownItemSelected(String newValueSelected) {
    setState(() {
      _currentItemSelected = newValueSelected;
    });
  }

  String calculateTotal() {
    double principal = double.parse(principalValueController.text);
    double rate = double.parse(rateValueController.text);
    double time = double.parse(timeValueController.text);

    double result = principal + (principal * rate * time) / 100;

    return 'After $time years your investment will be worth $result in $_currentItemSelected';
  }

  void reset() {
    principalValueController.text = '';
    rateValueController.text = '';
    timeValueController.text = '';

    displayText = '';
    _currentItemSelected = _currencies[0];
  }
}
