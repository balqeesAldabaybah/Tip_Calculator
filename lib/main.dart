import 'dart:core';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.amber,
        fontFamily: 'Amorino',
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
 
 

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['business','education','pandora charm bracelet','chest','games','golf','cook','recipe','children','kid','random','shuffle','home','smart','generator','ads','manager','list','ToDo','letters','teaching','schools','winner','music','sounds','flutter','modanisa','hijab','shopping','laptop','Technology','red','hospital','mediciine','booking.com','hotels','donate','charity','live','apple','goverment'
      ,'cars','LG','IKEA','empathy','pubg','run','marathon','kitchen','beko','swimming','socks','hp','health','parking','Netflix','trainer','IOT','IT','glasses','shoes','teeth','paste','scarfs','accessories','GPU','CPU','mouse','rain','romance','books','good reader','secrests'
      'joly','saiva ','dallas','trivago','anything'],
      childDirected: false,
    );

  InterstitialAd interAd;
  InterstitialAd buildinterAd(){
    return InterstitialAd(
      adUnitId: "ca-app-pub-6067078449221772/7361434094",
      //adUnitId: InterstitialAd.testAdUnitId,

      targetingInfo: targetingInfo,
       listener: (MobileAdEvent event) {
          print("InterstitialAd event is $event");
        },
      );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-6067078449221772~4452199721");
    interAd =  buildinterAd()..load();
  }

   var billAmount = 'How much was the bill?';
   var serviceRate = 'How was the service ?';
    var serviceGood = 'Good' ;
    var servicePoor = 'Poor' ;
    var serviceAverage = 'Average' ;
    var peopleAmount = 'How many people were there?';
    int _radioValue =0;
    int service=0;
    String amount;
    String people;

    void _handleRadioValueChanged(int value){
      setState(() {
           service =value; 
        });
        switch (value) {
          case 0:
            setState(() {
             _radioValue = value; 
            });
            break;
          case 1:
            setState(() {
             _radioValue = value; 
            });
            break;
          case 2:
              setState(() {
             _radioValue = value; 
            });
            break;
          
          default: setState(() {
             _radioValue = value; 
            });
        }
    }
    Widget buildText(var text){
      return new Text(text , style: new TextStyle(fontSize: 25.0),);
    }

    Widget buildNumberTextFeild(var label, bool isforbill){
      return new Padding(
        padding: EdgeInsets.only(top:10.0,bottom: 10.0,left: 20.0,right: 45.0),
        child:  new TextField(
          decoration: new InputDecoration(labelText: label),
          keyboardType: TextInputType.number,
          onSubmitted: (String value){
            if(isforbill){
              setState(() {
               amount =value; 
              });
            }else{
              setState(() {
               people =value; 
              });
            }
          },
        ),
      );
    }
    Widget buildRadio(int value){
      return new Radio(value: value, groupValue: _radioValue,onChanged: _handleRadioValueChanged,);
    }
    Widget buildRowServiceRate(){
      return new Center(
        child:new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            buildRadio(0),
            Text(serviceGood),
            buildRadio(1),
            Text(serviceAverage),
            buildRadio(2),
            Text(servicePoor)

          ],
        ),
      );
    }
    Widget buildRaisedButton(BuildContext context){
     return new ButtonTheme(
      minWidth: 100.0,
      height: 50.0,
      child: RaisedButton(
        onPressed: (){calculate(context);},
        textColor: Colors.black,
        color: Colors.amber,
        padding: const EdgeInsets.all(8.0),
        child: new Text(
          "Calculate",
          style: new TextStyle(
            fontSize: 20.0
          ),
        ),
    ));
  }
   void  calculate(BuildContext context){
     
      double bill =-1.0;
      int peple ;
     if(amount !=null && people != null){
       bill = double.parse(amount);
       peple = int.parse(people);
     }
     
     if(bill == 0 || amount == null || peple == 0 || people==null){
       showSnakBar(context, 'Please enter all the feilds correctly, Zeros are not allowed');
     }else
     {
      double result;
      
      if(service == 0){
        result =bill *0.15;
      }else if(service == 1){
        result = bill * 0.1;
      }else if(service == 2){
        result = bill *0.05;
      }
      result = result/peple;
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Tips amount'),
            content: new Text('${result.toStringAsFixed(2)}\$ per person'),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Ok' , style: new TextStyle(fontSize: 20.0),),
                onPressed: (){
                  interAd..load()..show();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      );
     }
    }
   void showSnakBar(BuildContext context,var mesg){
      Scaffold.of(context).showSnackBar(new SnackBar( content: new Text(mesg),));
   }
  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(
      body: Builder(
        builder: (context)=>
          new Center(
          child: new SingleChildScrollView(
            child: new Padding(
              padding: EdgeInsets.only(left: 0.0,right: 0.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Tip Calculator', style: new TextStyle(fontSize: 40.0, fontWeight: FontWeight.w100),),
                  Container(height: 20.0,),
                  new Container(
                      decoration: new BoxDecoration(
                        border: Border.all(color: Colors.amber, width: 1.0)
                      ),
                  ),
                  Container(height: 20.0,),
                  Container(
                    padding: EdgeInsets.only(left: 45.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        buildText(billAmount),
                        buildNumberTextFeild("Enter the amount...",true),
                        Container(height: 25.0,),
                        buildText(serviceRate),
                        buildRowServiceRate(),
                        Container(height: 25.0,),
                        buildText(peopleAmount),
                        buildNumberTextFeild("Enter the number of people...",false),
                        Container(height: 25.0,),
                      ],
                    ),
                  ),
                  buildRaisedButton(context),
                ],
              ),
            )
          )
        ),
      )
    );
  }
}
