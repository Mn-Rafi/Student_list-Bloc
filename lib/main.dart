import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_list_bloc/Logic/bloc/search_bloc.dart';
import 'package:student_list_bloc/Logic/cubit/studentlist_cubit.dart';
import 'package:student_list_bloc/Presentation/Screens/HomeScreen/screen_home.dart';
import 'package:student_list_bloc/data/studentdb.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String studentDb = 'StudentDb';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<StudentDb>(StudentDbAdapter());
  await Hive.openBox<StudentDb>(studentDb);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => StudentlistCubit(),),
        BlocProvider(create: (context) => SearchBloc(),),
      ], 
      child: const MaterialApp(
        home: ScreenHome(),
      ),
    );
  }
}
