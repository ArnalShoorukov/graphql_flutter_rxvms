import 'package:flutter_graphql/models/welcome.dart';
import 'package:flutter_graphql/services/graphql_service.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../service_locator.dart';

class DataManager{
  var logger = Logger();
  final BehaviorSubject<Characters> dataSubject = BehaviorSubject<Characters>();

  Stream<Characters> get data$ => dataSubject.stream;

  String query = r'''
      query {
        characters(page: 1) {
          results {
            id
            name
            status
          }
        }
      }
    ''';

  Stream<Characters>_getData(){
    return
      Stream.fromFuture(sl<GraphQLService>().performQuery(query));
  }

  DataManager(){
    _getData().listen((event) {
      logger.d(event.results);
    dataSubject.add(event);
    });
  }
}