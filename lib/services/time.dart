import 'package:ntp/ntp.dart';

class TimeService {
  Future<DateTime> fetchCurrentTime() async {
    DateTime startDate = new DateTime.now().toLocal();
    int offset = await NTP.getNtpOffset(localTime: startDate);
    print('offset: $offset');
    final currentTime = await NTP.now();
    return currentTime;
  }
}
