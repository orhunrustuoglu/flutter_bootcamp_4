import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //The design inspired from:
  //https://www.uplabs.com/posts/calculator-illustrations
  var currentNumber;
  String operationString = "";
  var result;
  var buttons = [1, 2, 3, 4, 5, 6, 7, 8, 9]; //to dynamically map the gridview

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Only Addition Calculator",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      height: 50,
                      child: Text(operationString,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 24))),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 80,
                    child: Text(
                      "${result ?? ""}",
                      style: const TextStyle(color: Colors.white, fontSize: 42),
                    ),
                  ),
                ]),
            const Divider(
              color: Colors.grey,
            ),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              children: [
                ...buttons
                    .map(
                      (n) => TextButton(
                          onPressed: () {
                            setState(() {
                              if (currentNumber == null) {
                                currentNumber = n;
                              } else {
                                currentNumber = int.parse("$currentNumber$n");
                              }
                              operationString = "$operationString$n";
                            });
                          },
                          child: Text(
                            n.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                          )),
                    )
                    .toList(),
                TextButton(
                    onPressed: () {
                      setState(() {
                        operationString = "";
                        currentNumber = null;
                        result = null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "Values are resetted.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                        backgroundColor: Colors.grey,
                      ));
                    },
                    child: const Text(
                      "AC",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    )),
                TextButton(
                    onPressed: () {
                      if (currentNumber != null) {
                        //specific if case for the number 0
                        setState(() {
                          currentNumber = int.parse("${currentNumber}0");
                          operationString = "${operationString}0";
                        });
                      }
                    },
                    child: const Text(
                      "0",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    )),
                TextButton(
                    onPressed: () {
                      if (operationString == "") {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            "Enter values to sum up!",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                      result = null; //clear the result from the last opreation
                      if (operationString.endsWith(" + ")) {
                        operationString = operationString.substring(
                            0,
                            operationString.length -
                                3); //to get rid of the + at the end, if exists
                      }
                      var tempList = operationString.split(" + ");
                      for (var numString in tempList) {
                        if (result != null) {
                          result = result +
                              int.parse(numString); //if the result is empty
                        } else {
                          result = int.parse(numString);
                        }
                      }
                      setState(() {
                        currentNumber = null;
                        operationString = "";
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "Success!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                        backgroundColor: Colors.green,
                      ));
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        "=",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    )),
              ],
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    if (currentNumber != null) {
                      setState(() {
                        operationString = "$operationString + ";
                        currentNumber = null;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.orangeAccent,
                      shape: const CircleBorder()),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "+",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
