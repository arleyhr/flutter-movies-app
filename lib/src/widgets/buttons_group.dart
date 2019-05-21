import 'package:flutter/material.dart';


class ButtonGroup extends StatelessWidget {
  Function onPressed;
  Widget child;
  bool isActived;

  ButtonGroup({ @required this.onPressed, @required this.child, this.isActived = false });

  @override
  Widget build(BuildContext context) {
    Color color = isActived ? Colors.red : Colors.white;
    Color textColor = isActived ? Colors.white : Colors.black87;

    return Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30)
          ),
          child: RaisedButton(
            color: color,
            textColor: textColor,
            elevation: 0,
            onPressed: onPressed,
            child: child,
          ),
        )
    );
  }
}


class ButtonsGroup extends StatelessWidget {

  List<ButtonGroup> children;
  ButtonsGroup({ @required this.children });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(
            children: children
        )
    );
  }
}
