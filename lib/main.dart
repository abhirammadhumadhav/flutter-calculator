import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:my_work/colors.dart';

void main() {
  runApp(const MaterialApp(
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;

  buttonClick(value) {
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == '<') {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == '=') {
      if (input.isNotEmpty) {
        var userinput = input;
        userinput = userinput.replaceAll("X", "*"); // Replace X with *
        Parser p = Parser();
        Expression expression = p.parse(userinput);
        ContextModel cm = ContextModel();
        var finalvalue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalvalue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
      }
    } else {
      input = input + value;
      hideInput = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hideInput ? '' : input,
                  style: const TextStyle(fontSize: 48, color: Colors.white),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  output,
                  style: const TextStyle(fontSize: 52, color: Colors.white),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          )),
          Row(
            children: [
              button(
                  text: "AC", buttonBgcolor: operatorcolor, tColor: orangcolor),
              button(
                  text: "<", buttonBgcolor: operatorcolor, tColor: orangcolor),
              button(text: "", buttonBgcolor: Colors.transparent),
              button(
                  text: "/", buttonBgcolor: operatorcolor, tColor: orangcolor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                  text: "X", buttonBgcolor: operatorcolor, tColor: orangcolor),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                  text: "-", buttonBgcolor: operatorcolor, tColor: orangcolor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                  text: "+", buttonBgcolor: operatorcolor, tColor: orangcolor),
            ],
          ),
          Row(
            children: [
              button(text: "%"),
              button(text: "0"),
              button(text: "."),
              button(text: "=", buttonBgcolor: orangcolor),
            ],
          )
        ],
      ),
    );
  }

  Widget button({text, tColor, buttonBgcolor = buttoncolor}) {
    return Expanded(
        child: Container(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22)),
                  padding: const EdgeInsets.all(22),
                  backgroundColor: buttonBgcolor),
              onPressed: () {
                buttonClick(text);
              },
              child: Text(
                text,
                style: TextStyle(
                    color: tColor, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )));
  }
}
