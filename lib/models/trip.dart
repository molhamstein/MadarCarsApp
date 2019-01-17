class Trip {
  bool fromAirport;
  bool toAirport;
  bool inCity;
  int locationId;

  Trip(this.fromAirport, this.toAirport, this.inCity, this.locationId);

  Trip.init() {
    fromAirport = false;
    toAirport = false;
    inCity = false;
  }
}
