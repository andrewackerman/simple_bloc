import 'package:flutter/material.dart';
import 'package:simple_bloc/simple_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  State createState() => MyAppState();

}

class MyAppState extends State<MyApp> {

  final CounterBlocController controller = CounterBlocController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('simple_counter_page_with_inheritence'),
        ),
        body: Center(
          child: InheritedBloc(
            bloc: controller,
            child: SimpleCounterPage(),
          ),
        ),
      ),
    );
  }

}

class SimpleCounterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final controller = InheritedBloc.of<CounterBlocController>(context);
    
    return Container(
      padding: EdgeInsets.all(8),
      child: BlocWidget(controller: controller, builder: (cxt, bloc) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Current value of the counter bloc:',
            ),
            Text(
              '${bloc.counter}',
              style: Theme.of(context).textTheme.display1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: bloc.decrementCounter,
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: bloc.incrementCounter,
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

}

class CounterBlocController extends BlocController {

  int counter;

  CounterBlocController()  {
    counter = 0;
  }

  incrementCounter() {
    counter++;
    publishUpdate();
  }

  decrementCounter() {
    counter--;
    publishUpdate();
  }
  
}
