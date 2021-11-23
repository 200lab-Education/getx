import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mpcore/mpcore.dart';

import '../../../get_core/get_core.dart';
import '../../../get_instance/get_instance.dart';
import '../../../get_state_manager/get_state_manager.dart';
import '../../../get_utils/get_utils.dart';
import '../../get_navigation.dart';
import 'root_controller.dart';

class GetMPApp extends StatelessWidget {
  const GetMPApp({
    Key? key,
    this.navigatorKey,
    this.home,
    Map<String, Widget Function(BuildContext)> this.routes =
        const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    List<NavigatorObserver> this.navigatorObservers =
        const <NavigatorObserver>[],
    this.builder,
    this.textDirection,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.fallbackLocale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.debugShowMaterialGrid = false,
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
    this.scrollBehavior,
    this.customTransition,
    this.translationsKeys,
    this.translations,
    this.onInit,
    this.onReady,
    this.onDispose,
    this.routingCallback,
    this.defaultTransition,
    this.getPages,
    this.opaqueRoute,
    this.enableLog = kDebugMode,
    this.logWriterCallback,
    this.popGesture,
    this.transitionDuration,
    this.defaultGlobalState,
    this.smartManagement = SmartManagement.full,
    this.initialBinding,
    this.unknownRoute,
    this.actions,
  })  : routeInformationProvider = null,
        routeInformationParser = null,
        routerDelegate = null,
        backButtonDispatcher = null,
        super(key: key);

  final GlobalKey<NavigatorState>? navigatorKey;
  final Widget? home;
  final Map<String, WidgetBuilder>? routes;
  final String? initialRoute;
  final RouteFactory? onGenerateRoute;
  final InitialRouteListFactory? onGenerateInitialRoutes;
  final RouteFactory? onUnknownRoute;
  final List<NavigatorObserver>? navigatorObservers;
  final TransitionBuilder? builder;
  final String title;
  final GenerateAppTitle? onGenerateTitle;
  final CustomTransition? customTransition;
  final Color? color;
  final Map<String, Map<String, String>>? translationsKeys;
  final Translations? translations;
  final TextDirection? textDirection;
  final Locale? locale;
  final Locale? fallbackLocale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final LocaleListResolutionCallback? localeListResolutionCallback;
  final LocaleResolutionCallback? localeResolutionCallback;
  final Iterable<Locale> supportedLocales;
  final bool showPerformanceOverlay;
  final bool checkerboardRasterCacheImages;
  final bool checkerboardOffscreenLayers;
  final bool showSemanticsDebugger;
  final bool debugShowCheckedModeBanner;
  final ScrollBehavior? scrollBehavior;
  final Map<Type, Action<Intent>>? actions;
  final bool debugShowMaterialGrid;
  final ValueChanged<Routing?>? routingCallback;
  final Transition? defaultTransition;
  final bool? opaqueRoute;
  final VoidCallback? onInit;
  final VoidCallback? onReady;
  final VoidCallback? onDispose;
  final bool? enableLog;
  final LogWriterCallback? logWriterCallback;
  final bool? popGesture;
  final SmartManagement smartManagement;
  final Bindings? initialBinding;
  final Duration? transitionDuration;
  final bool? defaultGlobalState;
  final List<GetPage>? getPages;
  final GetPage? unknownRoute;
  final RouteInformationProvider? routeInformationProvider;
  final RouteInformationParser<Object>? routeInformationParser;
  final RouterDelegate<Object>? routerDelegate;
  final BackButtonDispatcher? backButtonDispatcher;

  Route<dynamic> generator(RouteSettings settings) {
    return PageRedirect(settings: settings, unknownRoute: unknownRoute).page();
  }

  List<Route<dynamic>> initialRoutesGenerate(String name) {
    return [
      PageRedirect(
        settings: RouteSettings(name: name),
        unknownRoute: unknownRoute,
      ).page()
    ];
  }

  @override
  Widget build(BuildContext context) => GetBuilder<GetMaterialController>(
        init: Get.rootController,
        dispose: (d) {
          onDispose?.call();
        },
        initState: (i) {
          Get.engine!.addPostFrameCallback((timeStamp) {
            onReady?.call();
          });
          if (locale != null) Get.locale = locale;

          if (fallbackLocale != null) Get.fallbackLocale = fallbackLocale;

          if (translations != null) {
            Get.addTranslations(translations!.keys);
          } else if (translationsKeys != null) {
            Get.addTranslations(translationsKeys!);
          }

          Get.customTransition = customTransition;

          initialBinding?.dependencies();
          if (getPages != null) {
            Get.addPages(getPages!);
          }

          //Get.setDefaultDelegate(routerDelegate);
          Get.smartManagement = smartManagement;
          onInit?.call();

          Get.config(
            enableLog: enableLog ?? Get.isLogEnable,
            logWriterCallback: logWriterCallback,
            defaultTransition: defaultTransition ?? Get.defaultTransition,
            defaultOpaqueRoute: opaqueRoute ?? Get.isOpaqueRouteDefault,
            defaultPopGesture: popGesture ?? Get.isPopGestureEnable,
            defaultDurationTransition:
                transitionDuration ?? Get.defaultTransitionDuration,
          );
        },
        builder: (_) => MPApp(
          key: _.unikey,
          navigatorKey:
              (navigatorKey == null ? Get.key : Get.addKey(navigatorKey!)),
          routes: routes ?? const <String, WidgetBuilder>{},
          onGenerateRoute: (getPages != null ? generator : onGenerateRoute),
          navigatorObservers: (navigatorObservers == null
              ? <NavigatorObserver>[GetObserver(routingCallback, Get.routing)]
              : <NavigatorObserver>[GetObserver(routingCallback, Get.routing)]
            ..addAll(navigatorObservers!)),
          title: title,
          color: color,
        ),
      );
}
