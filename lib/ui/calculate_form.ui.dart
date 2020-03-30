import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class CalculateFrom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalculateFormState();
}

class CalculateFormState extends State<CalculateFrom> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> _currencies = <String>['COP', 'USD', 'EUR'];
  final NumberFormat _formatCurrency = NumberFormat.simpleCurrency();

  String _currentItemSelected = '';

  MoneyMaskedTextController _principalValueController =
      MoneyMaskedTextController(precision: 1);
  TextEditingController _rateValueController = TextEditingController();
  TextEditingController _timeValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  @override
  void dispose() {
    _principalValueController.dispose();
    _rateValueController.dispose();
    _timeValueController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _setHeader(),
            _setForm(),
          ],
        ),
      ),
    );
  }

  Widget _setHeader() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * .7,
            height: MediaQuery.of(context).size.height * .3,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
            ),
            child: Center(
              child: Text(
                'Simple Invest Calculator',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  color: Theme.of(context).backgroundColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * .15,
            right: MediaQuery.of(context).size.width * .12,
            child: Image(
              image: AssetImage('images/invest.png'),
              fit: BoxFit.fill,
              width: 150,
              height: 100,
            ),
          ),
          Positioned(
            top: 50,
            right: 30,
            child: InkWell(
              onTap: () => setState(_reset),
              customBorder: CircleBorder(),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.clear_all, size: 40),
                    Text('Clear', style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _setForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: _setTextField(
                _principalValueController,
                'Principal value',
                'Enter principal value, ej, 10000',
                'Please enter principal amount',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: _setTextField(
                _rateValueController,
                'Rate of interest',
                'Enter percent value',
                'Please enter rate value',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: _setTextField(
                _timeValueController,
                'Time',
                'Time in years',
                'Please enter the time value',
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _currentItemSelected,
                    onChanged: (String value) {
                      setState(() => _currentItemSelected = value);
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 32,
                      color: Theme.of(context).primaryColor,
                    ),
                    items: _currencies.map(_setDropDownItem).toList(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: _setCalculateButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _setTextField(TextEditingController controller, String label,
      String hint, String message) {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 15,
        color: Theme.of(context).primaryColor,
      ),
      controller: controller,
      validator: (String value) =>
          value.isEmpty || value == '0,0' ? message : null,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(
          fontSize: 15,
          color: Theme.of(context).primaryColor,
        ),
        errorStyle: TextStyle(fontSize: 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }

  Widget _setCalculateButton() {
    return RaisedButton(
      color: Theme.of(context).accentColor,
      elevation: 5,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Text(
        'Calculate',
        textScaleFactor: 1.5,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).backgroundColor,
        ),
      ),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          _showDialog(_calculateTotal());
        }
      },
    );
  }

  DropdownMenuItem<String> _setDropDownItem(String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: TextStyle(
          fontSize: 15,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  String _calculateTotal() {
    final double principal = _principalValueController.numberValue;
    final double rate = double.parse(_rateValueController.text);
    final double time = double.parse(_timeValueController.text);

    final double result = principal + (principal * rate * time) / 100;

    return 'After ${time.toStringAsFixed(0)} years your investment will be '
        'worth $_currentItemSelected ${_formatCurrency.format(result)}';
  }

  void _reset() {
    _principalValueController.updateValue(0);
    _rateValueController.text = '';
    _timeValueController.text = '';
    _currentItemSelected = _currencies[0];

    _formKey.currentState.reset();
  }

  void _showDialog(String message) {
    showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(.4),
      pageBuilder: (_, __, ___) => null,
      transitionDuration: Duration(milliseconds: 300),
      transitionBuilder: (BuildContext context, Animation<double> anim1,
          Animation<double> anim2, Widget child) {
        final double curvedValue =
            Curves.easeInOutBack.transform(anim1.value) - 1;

        return Transform(
          transform: Matrix4.translationValues(0, curvedValue * 200, 0),
          child: Opacity(
            opacity: anim1.value,
            child: AlertDialog(
              elevation: 10,
              backgroundColor: Theme.of(context).backgroundColor,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              title: Text(
                'Success!!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              content: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
