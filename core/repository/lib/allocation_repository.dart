abstract class AllocationRepository {
  Future<void> putCurrentLocation();
}

class AllocationRepositoryImpl extends AllocationRepository {
  @override
  Future<void> putCurrentLocation() async {
    //update location

    // await APIRepository.apiRequest(
    //     APIRequestType.put,
    //     HttpUrl.updateDeviceLocation +
    //         'lat=${result.latitude}&lng=${result.longitude}');
  }
}
