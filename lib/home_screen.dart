import 'package:flutter/material.dart';

import 'game_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var xPlayer = TextEditingController();
    var oPlayer = TextEditingController();
    xPlayer.text = 'Player 1';
    oPlayer.text = 'Player 2';
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/letter-x.png',
                      height: 170,
                    ),
                    Image.asset(
                      'assets/letter-o.png',
                      height: 170,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
                const SizedBox(
                  height: 150,
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              height: 133,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.name,
                                      controller: xPlayer,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.close,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.name,
                                      controller: oPlayer,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.circle_outlined,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              MaterialButton(
                                child: const Text("Play"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyGamePage(
                                        xPLayerName: xPlayer.text,
                                        oPLayerName: oPlayer.text,
                                      ),
                                    ),
                                    // (route) => false,
                                  );
                                },
                              )
                            ],
                          );
                        });
                  },
                  child: Card(
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    elevation: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      width: 110,
                      height: 45,
                      child: const Center(
                          child: Text(
                        'Play',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
