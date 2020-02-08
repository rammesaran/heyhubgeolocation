import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

import 'model/locations.dart';


void main() {
  runApp(TestMapPolyline());
}

class TestMapPolyline extends StatefulWidget {
  @override
  _TestMapPolylineState createState() => _TestMapPolylineState();
}

class _TestMapPolylineState extends State<TestMapPolyline> {
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  GoogleMapController controller;

  List<LatLng> latlngSegment = List();
  // static LatLng _lat1 = LatLng(50.8404969, -0.1504184);
  // static LatLng _lat2 = LatLng(50.8400879, -0.1499697);
  // static LatLng _lat3 = LatLng(50.8397147, -0.149544);
  // static LatLng _lat4 = LatLng(50.8395274, -0.149197);
  // static LatLng _lat5 = LatLng(50.8391651, -0.1484959);
  // static LatLng _lat6 = LatLng(50.8390762, -0.1483239);
  // static LatLng _lat7 = LatLng(50.8384232, -0.1471598);
  // static LatLng _lat8 = LatLng(50.8380022, -0.1463473);
  // static LatLng _lat9 = LatLng(50.837404, -0.1452608);
  // static LatLng _lat10 = LatLng(50.8366421, -0.1438767);
  // static LatLng _lat11 = LatLng(50.8365324, -0.143661);
  // static LatLng _lat12 = LatLng(50.8364603, -0.1435131);
  // static LatLng _lat13 = LatLng(50.8364653, -0.1433272);
  // static LatLng _lat14 = LatLng(50.8365378, -0.142962);
  // static LatLng _lat15 = LatLng(50.836581, -0.1428312);
  // static LatLng _lat16 = LatLng(50.8367978, -0.1427949);
  // static LatLng _lat17 = LatLng(50.8376857, -0.1429831);
  // static LatLng _lat18 = LatLng(50.8386696, -0.1432138);
  // static LatLng _lat19 = LatLng(50.8413691, -0.1444104);
  // static LatLng _lat20 = LatLng(50.8440534, -0.1456728);
  // static LatLng _lat21 = LatLng(50.8440443, -0.145926);
  // static LatLng _lat22 = LatLng(50.8439954, -0.1469245);
  // static LatLng _lat23 = LatLng(50.8437566, -0.1483785);
  // static LatLng _lat24 = LatLng(50.8436649, -0.1487061);
  // static LatLng _lat25 = LatLng(50.8424651, -0.1481685);
  // static LatLng _lat26 = LatLng(50.8423318, -0.1485973);
  // static LatLng _lat27 = LatLng(50.8419149, -0.1489308);
  // static LatLng _lat28 = LatLng(50.8420108, -0.1491414);
  // static LatLng _lat29 = LatLng(50.841986, -0.1493002);
  // static LatLng _lat30 = LatLng(50.8420274, -0.1493182);
  // static LatLng _lat31 = LatLng(50.8420094, -0.1494606);
  // static LatLng _lat32 = LatLng(50.8419646, -0.1494901);
  // static LatLng _lat33 = LatLng(50.8419488, -0.1495438);
  // static LatLng _lat34 = LatLng(50.8419538, -0.1496013);
  // static LatLng _lat35 = LatLng(50.841985, -0.1496454);
  // static LatLng _lat36 = LatLng(50.8419149, -0.1502386);
  // static LatLng _lat37 = LatLng(50.8418668, -0.1504934);
  // static LatLng _lat38 = LatLng(50.8417828, -0.1510933);
  // static LatLng _lat39 = LatLng(50.8414955, -0.1510378);
  // static LatLng _lat40 = LatLng(50.8414212, -0.1510021);
  // static LatLng _lat41 = LatLng(50.8408752, -0.1506862);
  // static LatLng _lat42 = LatLng(50.8404969, -0.1504184);

  // LatLng _lastMapPosition = _lat1;

  bool findPoint(double lat, double long, double accurecy) {
    int sides = latlngSegment.length - 1;
    int j = sides - 1;
    bool pointStatus = false;
    for (int i = 0; i < sides; i++) {
      if (latlngSegment[i].longitude + (accurecy * 0.000009000009)  < long &&
              latlngSegment[j].longitude + (accurecy * 0.000009000009) >= long ||
          latlngSegment[j].longitude + (accurecy * 0.000009000009) < long &&
              latlngSegment[i].longitude + (accurecy * 0.000009000009) >= long) {
        if (latlngSegment[i].latitude +
                (accurecy * 0.000009000009) +
                (long - latlngSegment[i].longitude + (accurecy * 0.000009000009)) /
                    (latlngSegment[j].longitude +
                        (accurecy * 0.000009000009) -
                        latlngSegment[i].longitude +
                        (accurecy * 0.000009000009)) *
                    (latlngSegment[j].latitude +
                        (accurecy * 0.000009000009) -
                        latlngSegment[i].latitude +
                        (accurecy * 0.000009000009)) <
            lat) {
          pointStatus = !pointStatus;
        }
      }
      j = i;
    }
    return pointStatus;
  }

  @override
  void initState() {
    super.initState();
    //line segment
    // latlngSegment.add(_lat1);
    // latlngSegment.add(_lat2);
    // latlngSegment.add(_lat3);
    // latlngSegment.add(_lat4);
    // latlngSegment.add(_lat4);
    // latlngSegment.add(_lat5);
    // latlngSegment.add(_lat6);
    // latlngSegment.add(_lat7);
    // latlngSegment.add(_lat8);
    // latlngSegment.add(_lat9);
    // latlngSegment.add(_lat10);
    // latlngSegment.add(_lat11);
    // latlngSegment.add(_lat12);
    // latlngSegment.add(_lat13);
    // latlngSegment.add(_lat14);
    // latlngSegment.add(_lat15);
    // latlngSegment.add(_lat16);
    // latlngSegment.add(_lat17);
    // latlngSegment.add(_lat18);
    // latlngSegment.add(_lat19);
    // latlngSegment.add(_lat20);
    // latlngSegment.add(_lat21);
    // latlngSegment.add(_lat22);
    // latlngSegment.add(_lat23);
    // latlngSegment.add(_lat24);
    // latlngSegment.add(_lat25);
    // latlngSegment.add(_lat26);
    // latlngSegment.add(_lat27);
    // latlngSegment.add(_lat28);
    // latlngSegment.add(_lat29);
    // latlngSegment.add(_lat30);
    // latlngSegment.add(_lat31);
    // latlngSegment.add(_lat32);
    // latlngSegment.add(_lat33);
    // latlngSegment.add(_lat34);
    // latlngSegment.add(_lat35);
    // latlngSegment.add(_lat36);
    // latlngSegment.add(_lat37);
    // latlngSegment.add(_lat38);
    // latlngSegment.add(_lat39);
    // latlngSegment.add(_lat40);
    // latlngSegment.add(_lat41);
    // latlngSegment.add(_lat42);
    // latlngSegment.add(_lat1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            bool iflocaction = findPoint(50.854067 , -0.163824  , 10000);
            print(iflocaction);
          },
          child: Icon(Icons.navigation),
          backgroundColor: Colors.green,
        ),
        body: Container(
          child: Center(
            child:  FutureBuilder (
          future:  DefaultAssetBundle.of(context).loadString('asset/hub.json'),
          builder: (context, snapshot){
                              var newdata =  Location.fromJson(json.decode(snapshot.data.toString()));
                       for (var item in newdata.results.geometry) {
                         latlngSegment.add(new LatLng(item.lat,item.lon));
                       }
                              return GoogleMap(
            //that needs a list<Polyline>
            polylines: _polyline,
            markers: _markers,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(latlngSegment[0].latitude, latlngSegment[0].longitude),
              zoom: 11.0,
            ),
            mapType: MapType.normal,
          );
          }
          ),
          ),
          ),
          ),
    );
  }
  

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId( LatLng(44.197736 , 1.183339).toString()),
        //_lastMapPosition is any coordinate which should be your default
        //position when map opens up
        position: LatLng(44.197736 , 1.183339),
        infoWindow: InfoWindow(
          title: 'Awesome Polyline tutorial',
          snippet: 'This is a snippet',
        ),
      ));

      _polyline.add(Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        //latlng is List<LatLng>
        points: latlngSegment,
        width: 2,
        color: Colors.blue,
      ));
    });
  }
          
}        

