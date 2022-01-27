import 'package:flutter/widgets.dart';
import '../../../get_state_manager/get_state_manager.dart';
import '../../../get_utils/get_utils.dart';
import '../routes/custom_transition.dart';
import '../routes/observers/route_observer.dart';
import '../routes/transitions_type.dart';

class GetMaterialController extends GetxController {
  bool testMode = false;
  Key? unikey;

  bool defaultPopGesture = false;
  bool defaultOpaqueRoute = true;

  Transition? defaultTransition;
  Duration defaultTransitionDuration = Duration(milliseconds: 300);
  Curve defaultTransitionCurve = Curves.easeOutQuad;

  Curve defaultDialogTransitionCurve = Curves.easeOutQuad;

  Duration defaultDialogTransitionDuration = Duration(milliseconds: 300);

  final routing = Routing();

  Map<String, String?> parameters = {};

  CustomTransition? customTransition;

  var _key = GlobalKey<NavigatorState>(debugLabel: 'Key Created by default');

  GlobalKey<NavigatorState> get key => _key;

  GlobalKey<NavigatorState>? addKey(GlobalKey<NavigatorState> newKey) {
    _key = newKey;
    return key;
  }

  Map<dynamic, GlobalKey<NavigatorState>> keys = {};

  void restartApp() {
    unikey = UniqueKey();
    update();
  }
}
