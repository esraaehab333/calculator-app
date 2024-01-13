import 'package:calculator/constants/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userInput = "";

  String result = "0";

  List<String> builderList = [
    "AC",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    "C",
    "0",
    ".",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyBlack3,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2.5,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(fontSize: 32, color: MyWhite),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerRight,
                    child: Text(
                      result,
                      style: TextStyle(
                          fontSize: 48,
                          color: MyWhite,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18 ,vertical: 20),
              decoration: BoxDecoration(color: MyBlack2,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
              ),
              child: GridView.builder(
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1 / 1),
                itemBuilder: (BuildContext context, int index) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        handelButton(builderList[index]);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: MyWhite, // Background color
                      backgroundColor: getByColor(
                          builderList[index]), // Text Color (Foreground color)
                    ),
                    child: Text(
                      builderList[index],
                      style: TextStyle(
                          fontSize: 15, color: getColor(builderList[index])),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  handelButton(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }
    if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }
    if (text == "=") {
      result = calc();
      userInput = result;
      if (userInput.endsWith(".0")) {
        (userInput = userInput.replaceAll(".0", ""));
      }
      if (result.endsWith(".0")) {
        (result = result.replaceAll(".0", ""));
        return;
      }
    }
    userInput = userInput + text;
  }

  String calc() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "-" ||
        text == "+" ||
        text == "C" ||
        text == ")" ||
        text == "(") {
      return MyGreen;
    }
    return MyWhite;
  }

  getByColor(String text) {
    if (text == "AC") return MyRed;
    if (text == "=") return MyGreen;
    return MyBlack2;
  }
}
