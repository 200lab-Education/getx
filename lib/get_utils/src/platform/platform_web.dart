// TODO: resolve platform/desktop by JS browser agent.
// ignore: avoid_web_libraries_in_flutter
import '../../get_utils.dart';

// ignore: avoid_classes_with_only_static_members
class GeneralPlatform {
  static bool get isWeb => true;

  static bool get isMacOS => false;

  static bool get isWindows => false;

  static bool get isLinux => false;

  // @check https://developer.chrome.com/multidevice/user-agent
  static bool get isAndroid => false;

  static bool get isIOS => false;

  static bool get isFuchsia => false;

  static bool get isDesktop => false;
}
