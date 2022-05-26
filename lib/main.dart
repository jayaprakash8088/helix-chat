import 'package:flutter/material.dart';
import 'package:helix_chat_app/App/utils/string_constants.dart';
import 'package:helix_chat_app/App/view/login_screen.dart';
import 'package:helix_chat_app/App/view/splash_screen.dart';
import 'package:helix_chat_app/App/view_model/login_view_model.dart';
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  // creating client
  final client = Client(
    'Matrix Example Chat',
    databaseBuilder: (_) async {
      final dir = await getApplicationSupportDirectory();
      final db = FluffyBoxDatabase('matrix_example_chat', dir.path);
      await db.open();
      return db;
    },
  );
  await client.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginViewModel()),
    ],
    child:  MyApp(client: client,),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required this.client, Key? key}) : super(key: key);
  final Client client;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
//      initialRoute: '/',
      builder: (context, child) => Provider<Client>(
        create: (context) => client,
        child: child,
      ),
      home: SplashScreen(),
//      routes: {
//        '/': (context) =>  SplashScreen(),
//        '/login': (context) =>  LoginScreen()
//      },
    );
  }
}
