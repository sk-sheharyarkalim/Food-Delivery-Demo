import 'src/imports/core_imports.dart';
import 'src/app.dart';


Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await AppConfig.init();

  runApp(
    const StateWrapper(
      child: App(),
    ),
  );
}