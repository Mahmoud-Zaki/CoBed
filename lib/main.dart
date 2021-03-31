import 'package:cobed/Models/User.dart';
import 'package:cobed/Provider/Auth.dart';
import 'package:cobed/Provider/CountryCases.dart';
import 'package:cobed/Provider/EditOrganization.dart';
import 'package:cobed/Provider/LoadingAndScrolling.dart';
import 'package:cobed/Provider/MapNotifier.dart';
import 'package:cobed/Provider/OrgAuth.dart';
import 'package:cobed/Provider/PostNotifier.dart';
import 'package:cobed/Provider/SearchNotifier.dart';
import 'package:cobed/Screens/Authentication/ChooseAccount.dart';
import 'package:cobed/Screens/Home.dart';
import 'package:cobed/Services/SharedPreferences.dart';
import 'package:cobed/Utils/Constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget{
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  User user;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  void _getUserData() async{
    User tempUser = await SharedPreferenceHandler.getUserData();
    setState(() {
      user = tempUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => OrgAuth()),
        ChangeNotifierProvider(create: (_) => EditOrganization()),
        ChangeNotifierProvider(create: (_) => CountryCases()),
        ChangeNotifierProvider(create: (_) => MapNotifier()),
        ChangeNotifierProvider(create: (_) => SearchNotifier()),
        ChangeNotifierProvider(create: (_) => PostNotifier()),
        ChangeNotifierProvider(create: (_) => LoadingAndScrolling()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Constants.ScaffoldColor,
          accentColor: Constants.OrangeColor,
        ),
        debugShowCheckedModeBanner: false,
        title: 'CoBed',
        color: Constants.OrangeColor,
         home: (user == null) ? ChooseAccount() :
            Home(isUser: (user.accessToken == '') ? true : false, name: user.name),
      ),
    );
  }
}