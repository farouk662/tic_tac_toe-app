import 'package:flutter/material.dart';

class MyGamePage extends StatefulWidget {


 final String oPLayerName;

  final String xPLayerName;

   const MyGamePage({Key? key, required this.oPLayerName, required this.xPLayerName,}) : super(key: key);


  @override
  State<MyGamePage> createState() => _MyGamePageState();
}

class _MyGamePageState extends State<MyGamePage> {


  List<List<String>> xOro = [
    ['', '', ''],
    ['', '', ''],
    ['', '', '']
  ];
  int oScore = 0;
  int xScore = 0;
 // String x2=;

  String x = 'assets/letter-x.png';
  String o = 'assets/letter-o.png';
  bool oTurn = true;
  bool firstTurn = false;
  int counter = 1;

  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: (
              //padding: const EdgeInsets.all(8.0),
              Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.grey[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Text(
                         widget.oPLayerName,
                          style: TextStyle(
                              color: oTurn ? Colors.black : Colors.grey,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        if (oTurn)
                          Container(
                            color: Colors.black,
                            height: 2,
                            width: 80,
                          )
                      ],
                    )),
                    // SizedBox(width: 10,),
                    Card(
                      margin: EdgeInsets.zero,
                      elevation: 8,
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: const BoxDecoration(
                            //borderRadius: BorderRadius.circular(40),
                            //color: Colors.white,
                            ),
                        child: Center(
                            child: Text(
                          '$oScore : $xScore',
                          style: const TextStyle(
                            fontSize: 25,
                          ),
                        )),
                      ),
                    ),
                    //SizedBox(width: 10,),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.xPLayerName,
                          style: TextStyle(
                              color: !oTurn ? Colors.black : Colors.grey,
                              fontSize: 24,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        if (!oTurn)
                          Container(
                            color: Colors.black,
                            height: 2,
                            width: 80,
                          )
                      ],
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 10,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                    color: Colors.white,
                    height: 455,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    child: ListView.separated(
                        itemBuilder: (context, index) => rowBulider(index),
                        separatorBuilder: (context, index) => verticalDivider(),
                        itemCount: 3)),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    clear();
                  });
                },
                child: Card(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(9)),
                  elevation: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    width: 110,
                    height: 45,
                    child: const Center(
                        child: Text(
                      'Clear',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              )
            ],
          )),
        ));
  }

  Widget rowBulider(int index) => Container(
        height: 130,
        child: Row(
          children: [
            squareBuilder(index, 0),
            horizontalDivider(),
            squareBuilder(index, 1),
            horizontalDivider(),
            squareBuilder(index, 2)
          ],
        ),
      );

  Widget squareBuilder(int index1, int index2) => Expanded(
        child: InkWell(
          onTap: () {
            setState(() {
              if (oTurn && xOro[index1][index2] == '') {
                xOro[index1][index2] = o;
                print('o');
                filledBoxes++;
                oTurn = !oTurn;
                checkWinner();
              } else if (!oTurn && xOro[index1][index2] == '') {
                xOro[index1][index2] = x;
                filledBoxes++;
                oTurn = !oTurn;
                print('x');
                checkWinner();
              }
              //print(filledBoxes);

              if (filledBoxes == 9) {
                showDrawDialog('no');
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            color: Colors.white38,
            child: xOro[index1][index2] != ''
                ? Image.asset(xOro[index1][index2])
                : Container(),
          ),
        ),
      );

  Widget horizontalDivider() => Container(
        color: Colors.grey,
        width: 1,
      );

  Widget verticalDivider() => Container(
        color: Colors.grey,
        height: 1,
      );

  void showDrawDialog(String text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            content: Image.asset('assets/winner.gif'),
            actions: [
              MaterialButton(
                child: const Text("Play Again"),
                onPressed: () {
                  setState(() {
                    clear();
                    Navigator.of(context).pop();
                  });
                },
              )
            ],
          );
        });
  }

  void checkWinner() {
    if (xOro[0][0] == xOro[0][2] &&
        xOro[0][0] == xOro[0][1] &&
        xOro[0][0] != '') {
      oTurn = firstTurn;
      firstTurn = !firstTurn;
      if (xOro[0][0] == x) {
        showDrawDialog('${widget.xPLayerName} is winner');
        xScore++;
      } else if (xOro[0][0] == o) {
        showDrawDialog('${widget.oPLayerName} is winner');
        oScore++;
      }
    }
    if (xOro[0][1] == xOro[1][1] &&
        xOro[0][1] == xOro[2][1] &&
        xOro[0][1] != '') {
      oTurn = firstTurn;
      firstTurn = !firstTurn;
      if (xOro[0][1] == x) {
        showDrawDialog('${widget.xPLayerName} is winner');
        xScore++;
      } else if (xOro[0][1] == o) {
        showDrawDialog('${widget.oPLayerName} is winner');
        oScore++;
      }
    }
    if (xOro[0][0] == xOro[1][0] &&
        xOro[0][0] == xOro[2][0] &&
        xOro[0][0] != '') {
      oTurn = firstTurn;
      firstTurn = !firstTurn;
      if (xOro[0][0] == x) {
        showDrawDialog('${widget.xPLayerName} is winner');
        xScore++;
      } else if (xOro[0][0] == o) {
        showDrawDialog('${widget.oPLayerName} is winner');
        oScore++;
      }
    }

    if (xOro[1][2] == xOro[0][2] &&
        xOro[0][2] == xOro[2][2] &&
        xOro[0][2] != '') {
      oTurn = firstTurn;
      firstTurn = !firstTurn;
      if (xOro[0][2] == x) {
        showDrawDialog('${widget.xPLayerName} is winner');
        xScore++;
      } else if (xOro[0][2] == o) {
        showDrawDialog('${widget.oPLayerName} is winner');
        oScore++;
      }
    }
    if (xOro[2][0] == xOro[2][2] &&
        xOro[2][0] == xOro[2][1] &&
        xOro[2][0] != '') {
      oTurn = firstTurn;
      firstTurn = !firstTurn;
      if (xOro[2][0] == x) {
        showDrawDialog('${widget.xPLayerName} is winner');
        xScore++;
      } else if (xOro[2][0] == o) {
        showDrawDialog('${widget.oPLayerName} is winner');
        oScore++;
      }
    }
    if (xOro[1][0] == xOro[1][1] &&
        xOro[1][0] == xOro[1][2] &&
        xOro[1][0] != '') {
      oTurn = firstTurn;
      firstTurn = !firstTurn;
      if (xOro[1][0] == x) {
        showDrawDialog('${widget.xPLayerName} is winner');
        xScore++;
      } else if (xOro[1][0] == o) {
        showDrawDialog('${widget.oPLayerName} is winner');
        oScore++;
      }
    }
    if (xOro[0][0] == xOro[1][1] &&
        xOro[0][0] == xOro[2][2] &&
        xOro[0][0] != '') {
      oTurn = firstTurn;
      firstTurn = !firstTurn;
      if (xOro[0][0] == x) {
        showDrawDialog('${widget.xPLayerName} is winner');
        xScore++;
      } else if (xOro[0][0] == o) {
        showDrawDialog('${widget.oPLayerName} is winner');
        oScore++;
      }
    }
    if (xOro[0][2] == xOro[1][1] &&
        xOro[0][2] == xOro[2][0] &&
        xOro[0][2] != '') {
      oTurn = firstTurn;
      firstTurn = !firstTurn;
      if (xOro[1][1] == x) {
        showDrawDialog('${widget.xPLayerName} is winner');
        xScore++;
      } else if (xOro[1][1] == o) {
        showDrawDialog('${widget.oPLayerName} is winner');
        oScore++;
      }
    }
  }

  void clear() {
    setState(() {
      xOro = [
        ['', '', ''],
        ['', '', ''],
        ['', '', '']
      ];
    });
    filledBoxes = 0;
    //oTurn=firstTurn;
  }
}
