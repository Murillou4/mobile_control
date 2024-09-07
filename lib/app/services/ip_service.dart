import 'dart:io';

class IpService {
  Future<String> getLocalIP() async {
    try {
      final interfaces = await NetworkInterface.list();

      List<InternetAddress> addresses = interfaces
          .where((interface) => interface.addresses
              .any((address) => address.type == InternetAddressType.IPv4))
          .map((interface) => interface.addresses.firstWhere(
              (address) => address.type == InternetAddressType.IPv4))
          .toList();
      String ethernetIp = addresses
          .where((address) => address.address.contains('192.168.'))
          .first
          .address;
      return ethernetIp;
    } catch (e) {
      return 'IP indisponiível';
    }
  }
}
