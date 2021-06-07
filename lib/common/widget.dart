import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quize_app_elaunch/common/quiz_type_enum.dart';

Widget generalQuestionOption({String title, Color color, Function onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30.0),
          shape: BoxShape.rectangle,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

class CheckBoxWidget extends StatelessWidget {
  const CheckBoxWidget({
    this.label,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Checkbox(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
            Expanded(child: Text(label)),
          ],
        ),
      ),
    );
  }
}

class RadioButtonWidget extends StatefulWidget {
  const RadioButtonWidget({
    this.label,
    this.padding,
    this.value,
    this.groupValue,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final RadioEnum value;
  final RadioEnum groupValue;
  final Function onChanged;

  @override
  _RadioButtonWidgetState createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Row(
        children: <Widget>[
          Radio<RadioEnum>(
            value: widget.value,
            onChanged: widget.onChanged,
            groupValue: widget.groupValue,
          ),
          Expanded(
            child: Text(widget.label),
          ),
        ],
      ),
    );
  }
}

Widget checkAnswerCircle({Color color, String title}) {
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
    ),
    child: Center(
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    ),
  );
}

Widget fillAnswerQuestion({String option}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
    child: Container(
      width: MediaQuery.of(Get.context).size.width / 2,
      child: Text(
        option,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    ),
  );
}
