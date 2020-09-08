import 'dart:async';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' as io;

// Future
void useFuture1() {
  fetchUser(5)
      .then((value) {
    value['processed'] = "true";
    return value;
  })
      .then(print)
      .catchError((err) {
    print(err);
  });
}

void useFuture2() async {
  var result = await fetchUser(2);
  print(result);
}

Future<Map<String, String>> fetchUser(int userId) async {
  var response = await http.get('https://jsonplaceholder.typicode.com/users/$userId');
  var map = json.decode(response.body) as Map;
  return {'id': map['id'].toString(), 'name': map['name']};
}

String main() {
  // useFuture2();
  startServer();
}

void useStream1() async {
  var stream = streamOfInts()
      .where((number) => number < 2000)
      .take(1);
  await for(int number in stream) {
    print(number);
  }
}
void useStream2() {
  streamControllerExample().skip(2).listen((event) {
    print(event);
  });
}

// Stream
Stream<int> streamOfInts() async* {
  for(var i = 0; i < 5; i++ ) {
    var randomNumber = Random().nextInt(3000);
    await Future.delayed(Duration(milliseconds: randomNumber));
    yield randomNumber;
  }
}

void readFile() async{
  var content = io.File('lib/file.txt').openRead();

  // 1
  /*  var stream = content
      .transform(utf8.decoder)
      .transform(LineSplitter());

  await for(var line in stream) {
    print(line);
  }*/

  // stream to future
  // var lines = await content.transform(utf8.decoder).transform(LineSplitter()).toList();

  // transform existing stream
  var stream = content.transform(utf8.decoder).transform(LineSplitter());
  var lines = await transformedFileContent(stream).toList();
  print(lines);
}

Stream<String> transformedFileContent(Stream<String> stream) async*{
  await for(var line in stream) {
    yield '::> $line';
  }
}

// StreamController
Stream<int> streamControllerExample() {
  var controller = StreamController<int>();
  controller.sink.add(Random().nextInt(1000));
  controller.add(Random().nextInt(1000));
  controller.add(Random().nextInt(1000));

  return controller.stream;
}

void startServer() async {
  var server = await io.HttpServer.bind('localhost', 4444);
  server.listen((io.HttpRequest request) {
    request.response.write('Hello from dart async example');
    request.response.close();
  });
}