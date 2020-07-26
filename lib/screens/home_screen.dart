import 'package:flutter/material.dart';
import 'package:flutter_graphql/managers/data_manager.dart';
import 'package:flutter_graphql/models/welcome.dart';

import '../service_locator.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: sl<DataManager>().data$,
            builder: (BuildContext context, AsyncSnapshot<Characters> snapshot) {
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.none: return Text('Select lot');
                case ConnectionState.waiting: return CircularProgressIndicator();
                case ConnectionState.active: return _buildBody(snapshot.data);
                case ConnectionState.done: return Text('${snapshot.data} (closed)');
              }
              return null;
            }),
      ),
    );
  }

  Widget _buildBody(Characters characters) {
    return Container(
      child: ListView.builder(
        itemCount: characters.results.length,
        itemBuilder: (BuildContext context, int index) {
          var item = characters.results[index];
          return Card(
            elevation: 4.0,
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Text(item.id),
              title: Text(item.name),
              trailing: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: item.status == 'Dead'
                      ? Colors.red.withOpacity(0.3)
                      : item.status == 'Alive'
                      ? Colors.green.withOpacity(0.3)
                      : Colors.amber.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(32.0),
                ),
                child: Text(
                  item.status.toString(),
                  style: TextStyle(
                      color: item.status == 'Dead'
                          ? Colors.red
                          : item.status == 'Alive'
                          ? Colors.green
                          : Colors.amber),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}