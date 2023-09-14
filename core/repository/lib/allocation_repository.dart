abstract class AllocationRepository {
  Future<void> putCurrentLocation(double lat,double long);
}

class AllocationRepositoryImpl extends AllocationRepository {
  @override
  Future<void> putCurrentLocation(double lat,double long) async {
    ///do api call
    // await APIRepository.apiRequest(
    //     APIRequestType.put,
    //     HttpUrl.updateDeviceLocation +
    //         'lat=${result.latitude}&lng=${result.longitude}');
  }
}
