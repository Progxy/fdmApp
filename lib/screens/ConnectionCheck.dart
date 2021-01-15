import 'package:connectivity/connectivity.dart';

class ConnectionCheck {
  bool isConnected = false;
  check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isConnected = false;
    } else {
      isConnected = true;
    }
    print(isConnected);
  }
}
