import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

import 'model/locations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hey Hub',
      home: TestMapPolyline(),
    );
  }
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

  bool findPoint(double lat, double long, double accurecy) {
    int sides = latlngSegment.length - 1;
    int j = sides - 1;
    bool pointStatus = false;
    for (int i = 0; i < sides; i++) {
      if (latlngSegment[i].longitude + (accurecy * 0.000009000009) < long &&
              latlngSegment[j].longitude + (accurecy * 0.000009000009) >=
                  long ||
          latlngSegment[j].longitude + (accurecy * 0.000009000009) < long &&
              latlngSegment[i].longitude + (accurecy * 0.000009000009) >=
                  long) {
        if (latlngSegment[i].latitude +
                (accurecy * 0.000009000009) +
                (long -
                        latlngSegment[i].longitude +
                        (accurecy * 0.000009000009)) /
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
  Widget build(BuildContext context) {
    TextEditingController latvalue = TextEditingController();
    TextEditingController longvalue = TextEditingController();
    TextEditingController accurecy = TextEditingController();
    bool _validate = false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hey Hub Location'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300.0,
              child: Center(
                child: FutureBuilder(
                    future: DefaultAssetBundle.of(context)
                        .loadString('asset/hub.json'),
                    builder: (context, snapshot) {
                      var newdata = Location.fromJson(
                          json.decode(snapshot.data.toString()));
                      for (var item in newdata.results.geometry) {
                        latlngSegment.add(new LatLng(item.lat, item.lon));
                      }
                      return GoogleMap(
                        //zoomGesturesEnabled: true,
                        polylines: _polyline,
                        markers: _markers,
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(latlngSegment[0].latitude,
                              latlngSegment[0].longitude),
                          zoom: 15.0,
                        ),
                        mapType: MapType.normal,
                      );
                    }),
              ),
            ),
            Container(
              height: 70.0,
              width: 300.0,
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: latvalue,
                decoration: InputDecoration(
                  errorText: _validate ? 'Please enter latitude value' : null,
                  hintText: "Latitude",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              height: 70.0,
              width: 300.0,
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: longvalue,
                decoration: InputDecoration(
                  errorText: _validate ? 'Please enter lognitude value' : null,
                  hintText: "Longitude",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              height: 70.0,
              width: 300.0,
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: accurecy,
                decoration: InputDecoration(
                  errorText: _validate ? 'Please enter Accurecy Value' : null,
                  hintText: "Accuracy",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            RaisedButton(
              onPressed: () {
                latvalue.text.isEmpty ? _validate = true : _validate = false;
                longvalue.text.isEmpty ? _validate = true : _validate = false;
                accurecy.text.isEmpty ? _validate = true : _validate = false;

                bool iflocaction = findPoint(double.parse(latvalue.text),
                    double.parse(longvalue.text), double.parse(accurecy.text));
                return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(iflocaction.toString()),
                      );
                    });
              },
              child: Text(
                'Calculate',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.blue,
              padding: EdgeInsets.all(10.0),
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      _markers.add(Marker(
        markerId: MarkerId(LatLng(44.197736, 1.183339).toString()),
        position: LatLng(44.197736, 1.183339),
        infoWindow: InfoWindow(
          title: 'Awesome Polyline tutorial',
          snippet: 'This is a snippet',
        ),
      ));

      _polyline.add(Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        points: latlngSegment,
        width: 2,
        color: Colors.blue,
      ));
    });
  }
}
