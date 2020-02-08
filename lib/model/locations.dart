class Location {
  Results results;

  Location({this.results});

  Location.fromJson(Map<String, dynamic> json) {
    results =
        json['results'] != null ? new Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.toJson();
    }
    return data;
  }
}

class Results {
  String type;
  int id;
  Bounds bounds;
  List<Geometry> geometry;
  Tags tags;

  Results({this.type, this.id, this.bounds, this.geometry, this.tags});

  Results.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    bounds =
        json['bounds'] != null ? new Bounds.fromJson(json['bounds']) : null;
    if (json['geometry'] != null) {
      geometry = new List<Geometry>();
      json['geometry'].forEach((v) {
        geometry.add(new Geometry.fromJson(v));
      });
    }
    tags = json['tags'] != null ? new Tags.fromJson(json['tags']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    if (this.bounds != null) {
      data['bounds'] = this.bounds.toJson();
    }
    if (this.geometry != null) {
      data['geometry'] = this.geometry.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags.toJson();
    }
    return data;
  }
}

class Bounds {
  double minlat;
  double minlon;
  double maxlat;
  double maxlon;

  Bounds({this.minlat, this.minlon, this.maxlat, this.maxlon});

  Bounds.fromJson(Map<String, dynamic> json) {
    minlat = json['minlat'];
    minlon = json['minlon'];
    maxlat = json['maxlat'];
    maxlon = json['maxlon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minlat'] = this.minlat;
    data['minlon'] = this.minlon;
    data['maxlat'] = this.maxlat;
    data['maxlon'] = this.maxlon;
    return data;
  }
}

class Geometry {
  double lat;
  double lon;

  Geometry({this.lat, this.lon});

  Geometry.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}

class Tags {
  String name;

  Tags({this.name});

  Tags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}