import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String receivedData = "";
  var tfControl = TextEditingController();
  String img1 = "neutral_emoji.png";
  String img2 = "smiling_emoji.png";
  String imageName = "baklava.png";
  bool switchControl = false;
  bool checkBoxControl = false;
  int radioValue = 0;
  bool progressControl = false;
  double progress = 30;
  var tfClock = TextEditingController();
  var tfDate = TextEditingController();
  String selectedCountry = "Türkiye";
  List countries = [];
  var tfAlert = TextEditingController();

  @override
  void initState() {
    super.initState();
    countries.add("Türkiye");
    countries.add("Italy");
    countries.add("Japan");
  }

  @override
  void dispose() {
    super.dispose();
    tfControl.dispose();
    tfClock.dispose();
    tfDate.dispose();
    tfAlert.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Widget Usecases")),
        body: SingleChildScrollView(
          child: Center(
              child: Column(children: [
            Text(receivedData),
            TextField(
              controller: tfControl,
              decoration: const InputDecoration(hintText: ""),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            ElevatedButton(
                onPressed: () => setState(() => receivedData = tfControl.text),
                child: const Text("SUBMIT")),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                  onPressed: () => setState(() => imageName = "kofte.png"),
                  child: const Text("IMAGE 1")),
              //Image.asset("images/$img1"),
              SizedBox(
                width: 48,
                height: 48,
                child: Image.network(
                    "http://kasimadalan.pe.hu/yemekler/resimler/$imageName"),
              ),
              ElevatedButton(
                  onPressed: () => setState(() => imageName = "ayran.png"),
                  child: const Text("IMAGE 2"))
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  child: SwitchListTile(
                      title: const Text("Dart"),
                      controlAffinity:
                          ListTileControlAffinity.leading, //switch on the left
                      value: switchControl,
                      onChanged: (val) {
                        setState(() {
                          switchControl = val;
                        });
                      }),
                ),
                SizedBox(
                  width: 200,
                  child: CheckboxListTile(
                      value: checkBoxControl,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text("Flutter"),
                      onChanged: (val) {
                        setState(() {
                          checkBoxControl = val ?? false;
                        });
                      }),
                ),
              ],
            ),
            Row(children: [
              SizedBox(
                width: 200,
                child: RadioListTile(
                    value: 1,
                    title: const Text("Barcelona"),
                    groupValue: radioValue,
                    onChanged: (_) {
                      setState(() {
                        radioValue = 1;
                      });
                    }),
              ),
              SizedBox(
                width: 200,
                child: RadioListTile(
                    value: 2,
                    title: const Text("Real Madrid"),
                    groupValue: radioValue,
                    onChanged: (_) {
                      setState(() {
                        radioValue = 2;
                      });
                    }),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      progressControl = true;
                    });
                  },
                  child: const Text("Start")),
              Visibility(
                  visible: progressControl,
                  child: const CircularProgressIndicator()),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      progressControl = false;
                    });
                  },
                  child: const Text("Stop"))
            ]),
            Text(progress.toInt().toString()),
            Slider(
                min: 0,
                max: 100,
                value: progress,
                onChanged: (val) {
                  setState(() {
                    progress = val;
                  });
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: tfClock,
                    decoration: const InputDecoration(hintText: "Clock"),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                      ).then((value) => {
                            tfClock.text =
                                "${value!.hour.toString()} : ${value.minute}"
                          });
                    },
                    icon: const Icon(Icons.access_time)),
                SizedBox(
                  width: 120,
                  child: TextField(
                    controller: tfDate,
                    decoration: const InputDecoration(hintText: "Date"),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2010),
                              lastDate: DateTime(2030))
                          .then((value) => {
                                tfDate.text =
                                    "${value!.day}/${value.day}/${value.year}"
                              });
                    },
                    icon: const Icon(Icons.date_range))
              ],
            ),
            DropdownButton(
                value: selectedCountry,
                icon: const Icon(Icons.arrow_drop_down),
                items: countries.map((c) {
                  return DropdownMenuItem(
                    value: c,
                    child: Text(c),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    selectedCountry = val! as String;
                  });
                }),
            GestureDetector(
              onTap: () {
                print("pressed once");
              },
              onDoubleTap: () {
                print("pressed twice");
              },
              onLongPress: () {
                print("pressed&hold");
              },
              child: Container(
                color: Colors.red,
                width: 200,
                height: 50,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content:
                            const Text("Are you sure you want to delete it?"),
                        backgroundColor: Colors.amber,
                        action: SnackBarAction(
                            label: "Yes",
                            textColor: Colors.white,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.green,
                                      behavior: SnackBarBehavior.floating,
                                      content: Text("The item is deleted.")));
                            }),
                      ));
                    },
                    child: const Text("SnackBar")),
                ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: const Text("No internet connection..."),
                        backgroundColor: Colors.grey,
                        action: SnackBarAction(
                            label: "TRY AGAIN",
                            textColor: Colors.white,
                            onPressed: () {
                              print("Connecting...");
                            }),
                      ));
                    },
                    child: const Text("SnackBar(S)")),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("ALERT!"),
                              content: const Text("U done f'ed up..."),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.green,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: Text("Approved.")));
                                    },
                                    child: const Text("OK")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.red,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: Text("Canceled...")));
                                    },
                                    child: const Text("CANCEL"))
                              ],
                            );
                          });
                    },
                    child: const Text("Alert")),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey,
                              title: const Text("Registry"),
                              content: TextField(
                                controller: tfAlert,
                                decoration: const InputDecoration(
                                    hintText: "Info here"),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.green,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: Text(
                                                  "Info: ${tfAlert.text}")));
                                    },
                                    child: const Text(
                                      "SAVE",
                                      style: TextStyle(color: Colors.black),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.red,
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: Text("Canceled...")));
                                    },
                                    child: const Text(
                                      "CANCEL",
                                      style: TextStyle(color: Colors.black),
                                    ))
                              ],
                            );
                          });
                    },
                    child: const Text("Alert(S)"))
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  print("switch status: $switchControl");
                  print("checkbox status: $checkBoxControl");
                  print("radio value: $radioValue");
                  print("slider value: $progress");
                  print("selected country: $selectedCountry");
                },
                child: const Text("Show"))
          ])),
        ));
  }
}
