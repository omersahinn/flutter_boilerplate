import 'package:flutter/material.dart';

class BaseView extends StatefulWidget {
  BaseView({Key key}) : super(key: key);

  @override
  BaseViewState createState() => BaseViewState();
}

class BaseViewState<T extends BaseView> extends State<T> {

  @override
  Widget build(BuildContext context) {
    return Container();
  }

}