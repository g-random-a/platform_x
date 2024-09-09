// import 'package:connectivity/connectivity.dart';

Future<bool> checkInternetConnection() async {
  // if (Platform.isAndroid || Platform.isIOS) {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile ||
  //       connectivityResult == ConnectivityResult.wifi) {
  //     // Internet connection available
  //     return true;
  //   } else {
  //     // No internet connection
  //     return false;
  //   }
  // } else if (Platform.isWindows) {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       return true;
  //     }
  //   } on SocketException catch (_) {
  //     return false;
  //   }
  //   return false;
  // } else {
  //   // Platform not supported
  //   return true;
  // }
  return true;
}
