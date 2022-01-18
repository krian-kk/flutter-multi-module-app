import 'package:flutter/material.dart';
import 'package:ably_flutter/ably_flutter.dart' as ably;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final clientOptions = ably.ClientOptions.fromKey(
      'Bhx6Fw.aCUXHg:n2zxpPV1-KGRfII2lkZDzNOfTnhkVg8Aq9tVU17-X8Y');

  @override
  void initState() {
    super.initState();
    ably.Realtime realtime = ably.Realtime(options: clientOptions);
    realtime.connection
        .on()
        .listen((ably.ConnectionStateChange stateChange) async {
      print('---------------------------- n      ----------------->>>>>');
      print('Realtime connection state changed: ${stateChange.event}');
      setState(() {
        // _realtimeConnectionState = stateChange.current;
      });
    });

    // print('API Key => ${ablyApiKey}');
  }

  Future<void> _incrementCounter() async {
    // const String ablyApiKey = String.fromEnvironment('');
    // final clientOptions = ably.ClientOptions.fromKey(
    //     'Bhx6Fw.uAdtJQ:27y_9k1lfzMZfBcOueH1K5DjMxjPpdwp0WEZlVD07F0');
    clientOptions.logLevel = ably.LogLevel.verbose;
    ably.Rest rest = ably.Rest(options: clientOptions);
    ably.RestChannel channel = rest.channels.get('Chinnadurai');

    await channel.publish(name: "Hello", data: "Ably");
    await channel.publish(name: "Jones", data: "Ably");
    await channel.publish(name: "Nandha", data: "Ably");
    await channel.publish(name: "Chinnadurai", data: "Ably");
    await channel.publish(name: "Flutter", data: "Ably");
    ably.RealtimeChannel chatChannels =
        ably.Realtime(options: clientOptions).channels.get('Chinnadurai');
    var messageStream = chatChannels.subscribe();

    chatChannels.publish(name: 'jdljdjd');

    var channelMessageSubscription =
        messageStream.listen((ably.Message message) {
      print('=================== Message ============');
      print("New message arrived ${message.data}");
    });

    setState(() {
      _counter++;
    });
  }

  void getHistory([ably.RestHistoryParams? params]) async {
    clientOptions.logLevel = ably.LogLevel.verbose;
    ably.Rest rest = ably.Rest(options: clientOptions);
    ably.RestChannel channel = rest.channels.get('Chinnadurai');
    var result = await channel.history(params);
    print(
        '================== Result ==================== > ${await result.items}');

    var messages = result.items;
    print('Messagen => ${result}');
    var hasNextPage = result.hasNext(); // tells whether there are more results
    if (hasNextPage) {
      result = await result.next(); // will fetch next page results
      messages = result.items;
    }
    if (!hasNextPage) {
      result = await result.first(); // will fetch first page results
      messages = result.items;
    }
    print('================== Message ==================== > ${messages}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: getHistory,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
