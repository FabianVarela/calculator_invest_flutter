import 'package:calculator_invest_flutter/view/widgets/custom_button.dart';
import 'package:calculator_invest_flutter/view/widgets/custom_segmented_control.dart';
import 'package:calculator_invest_flutter/view/widgets/label_form.dart';
import 'package:calculator_invest_flutter/view/widgets/slide_number_container.dart';
import 'package:flutter/material.dart';

class InvestFormSection extends StatefulWidget {
  const InvestFormSection({Key? key}) : super(key: key);

  @override
  _InvestFormSectionState createState() => _InvestFormSectionState();
}

class _InvestFormSectionState extends State<InvestFormSection> {
  static const _currencyList = <String>['\$', '€', '£'];
  static const _contributionList = <String>['Month', 'Quarter', 'Year'];
  static const _compoundedList = <String>['Monthly', 'Quarterly', 'Yearly'];

  late double _initialInvestment = 1200;
  late double _additionalContribution = 500;
  late double _interestRate = 3.5;
  late double _yearsGrow = 10;

  int _currency = 0;
  int _contributeIndex = 0;
  int _compoundIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const LabelForm(title: 'Currency'),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: CustomSegmentedControl(
              groupText: _currencyList,
              currentValue: _currency,
              onChange: (val) {
                setState(() => _currency = val);
              },
            ),
          ),
          const LabelForm(title: 'Initial Investment'),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: SlideNumberContainer(
              maxSliderValue: 100000,
              value: _initialInvestment,
              isRounded: true,
              leadingText: _currencyList[_currency],
              onChangeValue: (value) {
                print('CHANGE: $value');
                setState(() => _initialInvestment = value);
              },
            ),
          ),
          const LabelForm(title: 'Additional Contribution'),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: SlideNumberContainer(
              maxSliderValue: 50000,
              value: _additionalContribution,
              isRounded: true,
              leadingText: _currencyList[_currency],
              onChangeValue: (value) {
                print('CHANGE: $value');
                setState(() => _additionalContribution = value);
              },
            ),
          ),
          const LabelForm(title: 'Contribute each'),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: CustomSegmentedControl(
              groupText: _contributionList,
              currentValue: _contributeIndex,
              onChange: (val) {
                setState(() => _contributeIndex = val);
              },
            ),
          ),
          const LabelForm(title: 'Interest Rate'),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: SlideNumberContainer(
              maxSliderValue: 10,
              value: _interestRate,
              leadingText: '%',
              isEnabledText: false,
              onChangeValue: (value) {
                print('CHANGE: $value');
                setState(() => _interestRate = value);
              },
            ),
          ),
          const LabelForm(title: 'Interest is compounded'),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: CustomSegmentedControl(
              groupText: _compoundedList,
              currentValue: _compoundIndex,
              onChange: (val) {
                setState(() => _compoundIndex = val);
              },
            ),
          ),
          const LabelForm(title: 'Years to grow'),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SlideNumberContainer(
              maxSliderValue: 30,
              value: _yearsGrow,
              isRounded: true,
              isEnabledText: false,
              onChangeValue: (value) {
                print('CHANGE: $value');
                setState(() => _yearsGrow = value);
              },
            ),
          ),
          CustomButton(
            text: 'Calculate',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
