import 'package:alcohol_or_gas/widgets/logo.widget.dart';
import 'package:alcohol_or_gas/widgets/submit-form.dart';
import 'package:alcohol_or_gas/widgets/success.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _gasCtrl = new MoneyMaskedTextController();

  Color _color;

  var _alcCtrl = new MoneyMaskedTextController();

  var _busy = false;

  var _completed = false;

  var _resultText = "Compensa utilizar álcool";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AnimatedContainer(
        duration: Duration(milliseconds: 2800),
        color: _color,
        child: ListView(
          children: <Widget>[
            Logo(),
            _completed
                ? Success(
                    result: _resultText,
                    reset: reset,
                  )
                : SubmitForm(
                    gasCtrl: _gasCtrl,
                    alcCtrl: _alcCtrl,
                    busy: _busy,
                    submitFunc: calculate,
                  ),
            Center(
                child: Text(
              "Desenvolvido pelo Emerson Murilo",
              style: TextStyle(
                color: Colors.white,
              ),
            )),
          ],
        ),
      ),
    );
  }

  Future calculate() {
    double alc =
        double.parse(_alcCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;

    double gas =
        double.parse(_gasCtrl.text.replaceAll(new RegExp(r'[,.]'), '')) / 100;
    double res;
    if (gas > 0 && alc > 0) {
      res = alc / gas;
    }

    setState(() {
      _color = Theme.of(context).primaryColorDark;
      _completed = false;
      _busy = true;
    });

    return Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        if (gas > 0 && alc > 0) {
          if (res >= 0.7) {
            _resultText = "Compensa utilizar Gasolina!";
          } else {
            _resultText = "Compensa utilizar Álcool!";
          }
        } else {
          _resultText = "Insira algum valor nos dois campos!";
        }
        _busy = false;
        _completed = true;
      });
    });
  }

  reset() {
    setState(() {
      _color = Theme.of(context).primaryColor;
      _alcCtrl = new MoneyMaskedTextController();
      _gasCtrl = new MoneyMaskedTextController();
      _completed = false;
      _busy = false;
    });
  }
}
