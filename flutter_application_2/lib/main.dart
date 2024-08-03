import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _callApis();
    });
  }

  Future<void> _callApis() async {
    _showProgressDialog();
    List<String> messages = [];

    await Future.wait([
      _callApi1().then((message) => messages.add(message)),
      _callApi2().then((message) => messages.add(message)),
      _callApi3().then((message) => messages.add(message)),
      _callApi4().then((message) => messages.add(message)),
      _callApi5().then((message) => messages.add(message)),
    ]);

    _closeProgressDialog();

    for (String message in messages) {
      _showMessageDialog(message);
    }
  }

  Future<String> _callApi1() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      if (response.statusCode == 200) {
        return 'API 1: Fetched successfully!';
      } else {
        return 'API 1: Failed to fetch data.';
      }
    } catch (e) {
      return 'API 1: Error occurred: $e';
    }
  }

  Future<String> _callApi2() async {
    try {
      final response =
          await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
      if (response.statusCode == 200) {
        return 'API 2: Fetched successfully!';
      } else {
        return 'API 2: Failed to fetch data.';
      }
    } catch (e) {
      return 'API 2: Error occurred: $e';
    }
  }

  Future<String> _callApi3() async {
    try {
      final response = await http.get(Uri.parse('https://catfact.ninja/fact'));
      if (response.statusCode == 200) {
        return 'API 3: Fetched successfully!';
      } else {
        return 'API 3: Failed to fetch data.';
      }
    } catch (e) {
      return 'API 3: Error occurred: $e';
    }
  }

  Future<String> _callApi4() async {
    try {
      final response =
          await http.get(Uri.parse('https://api.jikan.moe/v3/anime/1'));
      if (response.statusCode == 200) {
        return 'API 4: Fetched successfully!';
      } else {
        return 'API 4: Failed to fetch data.';
      }
    } catch (e) {
      return 'API 4: Error occurred: $e';
    }
  }

  Future<String> _callApi5() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=London&appid=YOUR_API_KEY'));
      if (response.statusCode == 200) {
        return 'API 5: Fetched successfully!';
      } else {
        return 'API 5: Failed to fetch data.';
      }
    } catch (e) {
      return 'API 5: Error occurred: $e';
    }
  }

  void _showProgressDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text('Loading...'),
              ],
            ),
          ),
        );
      },
    );
  }

  void _closeProgressDialog() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  void _showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Result'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
