import 'package:bloc_example/cubit/internet_cubit.dart';
import 'package:bloc_example/presentation/router/app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/counter_cubit.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.appRouter,
    required this.connectivity,
  });

  final AppRouter appRouter;
  final Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (context) => CounterCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // Navigating using generated routes
        onGenerateRoute: appRouter.onGenerateRoute,
        //
        // Navigating using named routes
        // routes: {
        //   '/': (context) => BlocProvider.value(
        //         value: _counterCubit,
        //         child: const HomeScreen(
        //           title: 'Home Screen',
        //           color: Colors.blueAccent,
        //         ),
        //       ),
        //   '/second': (context) => BlocProvider.value(
        //         value: _counterCubit,
        //         child: const SecondScreen(
        //           title: 'Second Screen',
        //           color: Colors.redAccent,
        //         ),
        //       ),
        //   '/third': (context) => BlocProvider.value(
        //         value: _counterCubit,
        //         child: const ThirdScreen(
        //           title: 'Third Screen',
        //           color: Colors.greenAccent,
        //         ),
        //       ),
        // },
        //
        // Navigating using anonymous routing
        // home: BlocProvider.value<CounterCubit>(
        //   create: (context) => CounterCubit(),
        //   child: const HomeScreen(
        //     title: 'Flutter Demo Home Page',
        //     color: Colors.blueAccent,
        //   ),
        // ),
      ),
    );
  }
}
