import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  var busy = false;
  var invert = false;
  Function func;
  var text = "";
  LoadingButton({
    @required this.busy,
    @required this.invert,
    @required this.func,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return this.busy
        ? Container(
            alignment: Alignment.center,
            height: 50,
            child: CircularProgressIndicator(
              backgroundColor: invert
                  ? Theme.of(context).primaryColor
                  : Colors.white.withOpacity(0.8), //arrumar
            ),
          )
        : Container(
            width: double.infinity,
            margin: EdgeInsets.all(30),
            height: 60,
            decoration: BoxDecoration(
              color: invert
                  ? Theme.of(context).primaryColor
                  : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(
                60,
              ),
            ),
            child: FlatButton(
              child: Text(
                this.text,
                style: TextStyle(
                  color: invert
                      ? Colors.white.withOpacity(0.8)
                      : Theme.of(context).primaryColor,
                  fontSize: 25,
                  fontFamily: "Big Shoulders Display",
                ),
              ),
              onPressed: func,
            ),
          );
  }
}
