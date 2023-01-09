import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Models/currency..dart';
import 'global.dart';
import 'helpers/helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Currency?> getCurrencyData;

  String dropdownValue1 = 'INR';
  String dropdownValue2 = 'INR';

  String pickerValue1 = "AMD";
  String pickerValue2 = "AMD";
  String? value;
  String answer = '';

  final currencyExchangeFormKey = GlobalKey<FormState>();
  final TextEditingController amountofCurrencyController =
      TextEditingController();
  final TextEditingController iosAmountofCurrencyController =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrencyData = CurrencyAPIHelper.apiHelper.fetchCurrencyData();
  }

  @override
  Widget build(BuildContext context) {
    return (Global.isIos == false)
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),
            home: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Currency Converter"),
                actions: [
                  Switch(
                    value: Global.isIos,
                    onChanged: (val) {
                      setState(() {
                        Global.isIos = val;
                      });
                    },
                  ),
                ],
              ),
              body: Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: currencyExchangeFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder(
                        future: getCurrencyData,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error : ${snapshot.error}"),
                            );
                          } else if (snapshot.hasData) {
                            Currency? data = snapshot.data;

                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Card(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    elevation: 10,
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, right: 70),
                                            child: TextField(
                                              cursorColor: Colors.blueGrey,
                                              cursorHeight: 30,
                                              controller:
                                                  amountofCurrencyController,
                                              decoration: const InputDecoration(
                                                hintText: "Enter Your Amount..",
                                                hintStyle: TextStyle(
                                                  fontSize: 15,
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blueGrey),
                                                ),
                                                border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    style: BorderStyle.solid,
                                                  ),
                                                ),
                                                icon: Icon(
                                                    size: 40,
                                                    Icons.currency_exchange),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Stack(
                                            alignment: Alignment.centerRight,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                height: 50,
                                                width: 340,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                  border: Border.all(
                                                    width: 1,
                                                  ),
                                                ),
                                                child: DropdownButton<String>(
                                                  items: data!.rates.keys
                                                      .toSet()
                                                      .toList()
                                                      .map<
                                                          DropdownMenuItem<
                                                              String>>((value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  value: dropdownValue1,
                                                  elevation: 16,
                                                  icon: const Icon(
                                                    Icons.flag,
                                                  ),
                                                  iconSize: 24,
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      dropdownValue1 = value!;
                                                    });
                                                  },
                                                ),
                                              ),
                                              const Icon(Icons.arrow_drop_down),
                                            ],
                                          ),
                                          const SizedBox(height: 20),
                                          Stack(
                                            alignment: Alignment.centerRight,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                height: 50,
                                                width: 340,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                    border: Border.all(
                                                      width: 1,
                                                    )),
                                                child: DropdownButton<String>(
                                                  items: data.rates.keys
                                                      .toSet()
                                                      .toList()
                                                      .map<
                                                          DropdownMenuItem<
                                                              String>>((value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(value),
                                                    );
                                                  }).toList(),
                                                  value: dropdownValue2,
                                                  elevation: 16,
                                                  icon: const Icon(
                                                    Icons.flag,
                                                  ),
                                                  iconSize: 24,
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      dropdownValue2 = value!;
                                                    });
                                                  },
                                                ),
                                              ),
                                              const Icon(Icons.arrow_drop_down),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 25),
                                  InkWell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.blueGrey,
                                      ),
                                      child: const Text(
                                        "Convert",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        answer =
                                            "${amountofCurrencyController.text} $dropdownValue1 = ${convertansy(
                                          data.rates,
                                          amountofCurrencyController.text,
                                          dropdownValue1,
                                          dropdownValue2,
                                        )}$dropdownValue2";
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 25),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          offset: Offset(0, 0),
                                          blurRadius: 1,
                                          spreadRadius: 1,
                                        ),
                                      ],
                                      color: Colors.grey,
                                    ),
                                    child: Text(
                                      answer,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        : CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              navigationBar: CupertinoNavigationBar(
                backgroundColor: Colors.blueGrey,
                middle: const Text(
                  "Currency Converter",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                trailing: CupertinoSwitch(
                  activeColor: Colors.teal,
                  value: Global.isIos,
                  onChanged: (val) {
                    setState(() {
                      Global.isIos = val;
                    });
                  },
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: currencyExchangeFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder(
                        future: getCurrencyData,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error : ${snapshot.error}"),
                            );
                          } else if (snapshot.hasData) {
                            Currency? data = snapshot.data;

                            List keys = [data!.rates.keys.toString()];
                            return Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 50),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      right: 100,
                                      left: 100,
                                    ),
                                    child: Column(
                                      children: [
                                        CupertinoTextField(
                                          cursorColor: Colors.blueGrey,
                                          placeholder: "Enter Your Amount",
                                          controller:
                                              iosAmountofCurrencyController,
                                          prefix: const Icon(
                                            CupertinoIcons.money_dollar,
                                            size: 40,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    width: double.infinity,
                                    height: 330,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CupertinoButton(
                                          color: Colors.blueGrey,
                                          child: const Text(
                                            'Chose Currency',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 30,
                                            ),
                                          ),
                                          onPressed: () {
                                            showCupertinoModalPopup(
                                              context: context,
                                              builder: (_) => Container(
                                                width: 300,
                                                height: 250,
                                                child: CupertinoPicker(
                                                  backgroundColor: Colors.white,
                                                  itemExtent: 30,
                                                  scrollController:
                                                      FixedExtentScrollController(
                                                    initialItem:
                                                        dropdownValue1.length,
                                                  ),
                                                  children: data.rates.keys
                                                      .toSet()
                                                      .toList()
                                                      .map<
                                                          DropdownMenuItem<
                                                              String>>((value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Center(
                                                        child: Text(value),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onSelectedItemChanged: (val) {
                                                    List<String> Country = data
                                                        .rates.keys
                                                        .toSet()
                                                        .toList();
                                                    setState(() {
                                                      pickerValue1 =
                                                          Country[val];
                                                    });
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Text(
                                          pickerValue1,
                                          style: const TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 40,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Icon(
                                          Icons.import_export,
                                          size: 60,
                                          color: Colors.blueGrey,
                                        ),
                                        const SizedBox(height: 10),
                                        CupertinoButton(
                                          color: Colors.blueGrey,
                                          child: const Text(
                                            'Chose Currency',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 30,
                                            ),
                                          ),
                                          onPressed: () {
                                            showCupertinoModalPopup(
                                              context: context,
                                              builder: (_) => SizedBox(
                                                width: 300,
                                                height: 250,
                                                child: CupertinoPicker(
                                                  backgroundColor: Colors.white,
                                                  itemExtent: 30,
                                                  scrollController:
                                                      FixedExtentScrollController(
                                                    initialItem:
                                                        dropdownValue2.length,
                                                  ),
                                                  children: data.rates.keys
                                                      .toSet()
                                                      .toList()
                                                      .map<
                                                          DropdownMenuItem<
                                                              String>>((value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Center(
                                                        child: Text(value),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onSelectedItemChanged: (val) {
                                                    List<String> Country = data
                                                        .rates.keys
                                                        .toSet()
                                                        .toList();
                                                    setState(() {
                                                      pickerValue2 =
                                                          Country[val];
                                                    });
                                                  },
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Text(
                                          pickerValue2,
                                          style: const TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                  CupertinoButton(
                                    color: Colors.blueGrey,
                                    onPressed: () {
                                      setState(() {
                                        answer =
                                            '${iosAmountofCurrencyController.text} $pickerValue1 ${convertansy(
                                          data.rates,
                                          iosAmountofCurrencyController.text,
                                          pickerValue1,
                                          pickerValue2,
                                        )} $pickerValue2';
                                      });
                                    },
                                    child: const Text(
                                      "Convert",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: Text(
                                      answer,
                                      style: const TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const Center(
                            child: CupertinoActivityIndicator(
                              animating: true,
                              radius: 5,
                              color: Colors.blueGrey,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
