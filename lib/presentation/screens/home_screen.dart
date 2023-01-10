import 'package:bloc_example/constants/enums.dart';
import 'package:bloc_example/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/counter_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.title,
    required this.color,
  });

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // BlocListener<InternetCubit, InternetState>(
    //   listener: (context, state) {
    //     if (state is InternetConnected &&
    //         state.connectionType == ConnectionType.wifi) {
    //       BlocProvider.of<CounterCubit>(context).increment();
    //     } else if (state is InternetConnected &&
    //         state.connectionType == ConnectionType.mobile) {
    //       BlocProvider.of<CounterCubit>(context).decrement();
    //     }
    //   },)
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.wifi) {
                  return const Text(
                    'Wi-Fi',
                  );
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.mobile) {
                  return const Text(
                    'Mobile',
                  );
                } else {
                  return const Text('No internet connection!');
                }
              },
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.isIncremented!) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Incremented!'),
                    duration: Duration(milliseconds: 300),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Decremented!'),
                    duration: Duration(milliseconds: 300),
                  ));
                }
              },
              builder: (context, state) {
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            const SizedBox(height: 20),
            Builder(
              builder: (context) {
                final counterState = context.watch<CounterCubit>().state;
                final internetState = context.watch<InternetCubit>().state;

                if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.mobile) {
                  return Text(
                    'Counter: ${counterState.counterValue}\nInternet: Mobile',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  );
                } else if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.wifi) {
                  return Text(
                    'Counter: ${counterState.counterValue}\nInternet: WiFi',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  );
                } else {
                  return Text(
                    'Counter: ${counterState.counterValue}\nInternet: No internet connection!',
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            Builder(
              builder: (context) {
                final counterValue = context
                    .select((CounterCubit cubit) => cubit.state.counterValue);

                return Text(
                  'Counter: $counterValue',
                  style: Theme.of(context).textTheme.headline6,
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 0,
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                    // context.read<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: 1,
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/second');
              },
              color: color,
              child: const Text('Go to Second Screen'),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/third');
              },
              color: color,
              child: const Text('Go to Third Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
