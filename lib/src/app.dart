import 'package:food_delivery/src/imports/core_imports.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final current = _buildMaterialApp(context);
    return ScreenUtilWrapper(child: current);
  }

  Widget _buildMaterialApp(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        navigatorKey: rootNavigatorKey,
        initialBinding: AppBindings(),
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: buildLightTheme(primaryColorHex: '#FF6B35'),
        darkTheme: buildDarkTheme(primaryColorHex: '#FF6B35'),
        themeMode: ThemeMode.system,
        initialRoute: AppRoutes.login,
        getPages: AppRouter.getPages,
        defaultTransition: Transition.rightToLeft,
        transitionDuration: AppDurations.pageTransition,
        builder: (context, child) {
          Widget current = child!;
          current = SkeletonWrapper(child: current);
          current = SessionListenerWrapper(child: current);
          return current;
        },
      ),
    );
  }
}