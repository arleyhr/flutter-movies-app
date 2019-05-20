import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ButtonGroup extends StatelessWidget {
  Function onPressed;
  Widget child;

  ButtonGroup({ @required this.onPressed, @required this.child });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          child: RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            elevation: 0,
            onPressed: onPressed,
            child: child,
          ),
        )
    )
  }
}


class ButtonsGroup extends StatelessWidget {

  List<ButtonGroup> children;
  ButtonsGroup({ @required this.children });

  @override
  Widget build(BuildContext context) {
    print(children);
    return SizedBox(
        child: Row(
            children: children
        )
    );
  }
}
