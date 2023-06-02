import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'constants.dart' as k;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded = false;
  late num temp;
  late num press;
  late num humid;
  late num cover;
  late String cityname = '';
  TextEditingController controller = TextEditingController();








  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffebf4f5),
              Color(0xffb5c6e0)
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight
          )
        ) ,
        child: Visibility(
          visible: isLoaded,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.height*0.06,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Center(
                  child: TextFormField(
                    onFieldSubmitted: (String s){
                      setState(() {
                        cityname=s;
                        getCityWeather(s);
                        isLoaded=false;
                        controller.clear();

                      });

                    },
                    controller: controller,
                    cursorColor: Colors.white,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,

                    ),
                    decoration: InputDecoration(
                      hintText: 'Search City',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.7)
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        size: 25,
                        color: Colors.white.withOpacity(0.7),

                      )

                    ),


                  ),
                ),
              ),
              SizedBox(
                height: 30,

              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                        Icons.pin_drop,
                        color: Colors.red,
                        size: 40,

                    ),
                    Text(
                      cityname,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold
                      ),

                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.12,
                margin: EdgeInsets.symmetric(
                  vertical: 10,

                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15),),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade900,
                      offset: Offset(
                        1,2
                      ),
                      blurRadius: 3,
                      spreadRadius: 1,

                    )
                  ],
                ),
                child: Row(
                  children: [
                    Padding(

                      padding: const EdgeInsets.only(left: 7.0),
                      child: Image(

                          image: AssetImage('images/thermo.png',),
                          width: MediaQuery.of(context).size.width*0.07,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Temperature: ${temp.toStringAsFixed(3)} °C',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600
                      ),
                    )

                  ],
                ),
              ), // temperature
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.12,
                margin: EdgeInsets.symmetric(
                  vertical: 10,

                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15),),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade900,
                      offset: Offset(
                          1,2
                      ),
                      blurRadius: 3,
                      spreadRadius: 1,

                    )
                  ],
                ),
                child: Row(
                  children: [
                    Padding(

                      padding: const EdgeInsets.only(left: 7.0),
                      child: Image(

                        image: AssetImage('images/humid.png',),
                        width: MediaQuery.of(context).size.width*0.07,

                      ),
                    ),
                    SizedBox(
                      width: 10,

                    ),
                    Text(
                      'humididty: ${humid.toInt()} %',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),
                    )

                  ],
                ),
              ), //humidity
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.12,
                margin: EdgeInsets.symmetric(
                  vertical: 10,

                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15),),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade900,
                      offset: Offset(
                          1,2
                      ),
                      blurRadius: 3,
                      spreadRadius: 1,

                    )
                  ],
                ),
                child: Row(
                  children: [
                    Padding(

                      padding: const EdgeInsets.only(left: 7.0),
                      child: Image(

                        image: AssetImage('images/barometer.png',),
                        width: MediaQuery.of(context).size.width*0.07,

                      ),
                    ),
                    SizedBox(
                      width: 10,

                    ),
                    Text(
                      'Pressure: ${press.toStringAsFixed(2)} hPa',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),
                    )

                  ],
                ),
              ) , //pressure
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.12,
                margin: EdgeInsets.symmetric(
                  vertical: 10,

                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15),),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade900,
                      offset: Offset(
                          1,2
                      ),
                      blurRadius: 3,
                      spreadRadius: 1,

                    )
                  ],
                ),
                child: Row(
                  children: [
                    Padding(

                      padding: const EdgeInsets.only(left: 7.0),
                      child: Image(

                        image: AssetImage('images/cloud.png',),
                        width: MediaQuery.of(context).size.width*0.07,

                      ),
                    ),
                    SizedBox(
                      width: 10,

                    ),
                    Text(
                      'Cloud Cover: ${cover.toInt()} %',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                      ),
                    )

                  ],
                ),
              ), //cloud

            ],
          ),
          replacement: Center(child: CircularProgressIndicator()),
          


        ),
      ),

      
    ));
  }
  getCurrentLocation() async{
    var p=await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      forceAndroidLocationManager: true,


    );
    if(p != null){
      print('Lat:${p.latitude},Long:${p.longitude}');
      getCurrentCityWeather(p);
      
    }
    else{
      print('Data unavailable');
    }



  }
  getCurrentCityWeather(Position position) async{

    var client = http.Client();
    var uri =
        '${k.domain}?lat=${position.latitude}&lon=${position.longitude}&appid=${k.apikey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData=json.decode(data);
      print(data);
      updateUI(decodedData);
      setState(() {
        isLoaded = true;

      });
    }else{
      print('the statuscode is ${response.statusCode}');

    }



  }

  updateUI(var decodedData){
    if (decodedData==null){
      temp=0;
      press=0;
      humid=0;
      cover=0;
      cityname='Not available';
    }
    else{
      temp=decodedData['main']['temp']-273;
      press=decodedData['main']['pressure'];
      humid=decodedData['main']['humidity'];
      cover=decodedData['clouds']['all'];
      cityname=decodedData['name'];

    }

  }


  getCityWeather(String cityname) async{
    var client = http.Client();
    var uri =
        '${k.domain}?q=$cityname&appid=${k.apikey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData=json.decode(data);
      print(data);
      updateUI(decodedData);
      setState(() {
        isLoaded = true;

      });
    }else{
      print('the statuscode is ${response.statusCode}');

    }

  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();

    super.dispose();
  }


}
