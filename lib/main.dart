import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/view/news_layout_screen.dart';

import 'controller/cubit.dart';
import 'controller/states.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/local/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getDate(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var color = '191919';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScience()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) => {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                  //statusBarBrightness: Brightness.dark,
                ),
                titleTextStyle: TextStyle(
                  color: Color(0xFFEF5B0C),
                  fontSize: 20.0,
                ),
                iconTheme: IconThemeData(
                  color: Color(
                    0xFFEF5B0C,
                  ),
                ),
                centerTitle: false,
                backgroundColor: Colors.white,
                elevation: 1.0,
                //toolbarHeight: 10.0,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Color(0xFFEF5B0C),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                showSelectedLabels: true,
                showUnselectedLabels: false,
                backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
                elevation: 20.0,
                selectedItemColor: Color(0xFFEF5B0C),
                unselectedItemColor: Colors.grey,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor(color),
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor(color),
                  statusBarIconBrightness: Brightness.light,
                  //statusBarBrightness: Brightness.dark,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                centerTitle: false,
                backgroundColor: HexColor(color),
                elevation: 1.0,
                //toolbarHeight: 10.0,
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: HexColor(color),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: HexColor(color),
                  type: BottomNavigationBarType.fixed,
                  elevation: 20.0,
                  selectedItemColor: Color(0xFFEF5B0C),
                  unselectedItemColor: Colors.grey),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: NewsLayoutScreen(),
          );
        },
      ),
    );
  }
}
