import 'package:flutter/material.dart';

class TipCalculator extends StatefulWidget {
  //const TipCalculator({super.key});

  @override
  State<TipCalculator> createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  double _billamount = 0;
  int _personcount = 1;
  int _tipercentage = 0;
  //double _tipamount = _billamount * ( _tipercentage / 100);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Tip  Calculator',
          style: TextStyle(
              color: Color.fromARGB(255, 244, 25, 98),
              fontSize: 32,
              fontWeight: FontWeight.bold),
        )),
        toolbarHeight: 95,
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              //alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 244, 25, 98),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    '\t Total Bill Per Person\n\t\t\tRs  ${calculatetotalperperson(_billamount, _personcount, _tipercentage)}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )),
            ),
            Container(
                margin: EdgeInsets.only(top: 80),
                padding: EdgeInsets.all(12.0),
                //color: Colors.transparent,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        color: Colors.blueGrey, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(
                          color: Colors.black,
                          //fontWeight: FontWeight.bold,
                          fontSize: 28),
                      decoration: const InputDecoration(
                        prefixText: "Bill Amount:  ",
                        prefixStyle:
                            TextStyle(color: Colors.black, fontSize: 28),
                        prefixIcon: Icon(
                          Icons.attach_money,
                          color: Color.fromARGB(255, 244, 25, 98),
                        ),
                      ),
                      onChanged: (String value) {
                        setState(() {
                          try {
                            _billamount = double.parse(value);
                          } catch (exception) {
                            _billamount = 0.0;
                          }
                        });
                      },
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Split",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            color: Color.fromARGB(255, 244, 25, 98),
                          ),
                          child: Center(
                            child: Text(
                              "-",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            if (_personcount > 1) {
                              _personcount--;
                            }
                          });
                        },
                      ),
                      Text("$_personcount",
                          style: TextStyle(color: Colors.black, fontSize: 28)),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 244, 25, 98),
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          child: Center(
                            child: Text(
                              "+",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            _personcount++;
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Tip Amount",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Rs ${calculatetotaltip(_billamount, _tipercentage, _personcount)}',
                        style: TextStyle(color: Colors.black, fontSize: 28),
                      )
                    ],
                  )
                ],
              ),
            ),
            Column(
              //bcz 2 widgets
              children: <Widget>[
                Text(
                  "$_tipercentage%",
                  style: TextStyle(
                      color: Color.fromARGB(255, 244, 25, 98),
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                Slider(
                    min: 0,
                    max: 100,
                    activeColor: Color.fromARGB(255, 244, 25, 98),
                    inactiveColor: Color.fromARGB(255, 245, 172, 196),
                    value: _tipercentage.toDouble(),
                    //divisions: 10,
                    onChanged: (double value) {
                      setState(() {
                        _tipercentage = value.round();
                      });
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  calculatetotalperperson(double billAmount, int splitby, int tipercentage) {
    var totalperperson =
        (calculatetotaltip(billAmount, tipercentage, splitby) + billAmount) /
            splitby;
    return totalperperson;
  }

  calculatetotaltip(double billAmount, int tipercetage, int splitby) {
    double totaltip = 0;
    if (billAmount < 0 || !(billAmount.toString().isEmpty)) {
      totaltip = (billAmount * tipercetage) / 100;
    }
    return totaltip;
  }
}
