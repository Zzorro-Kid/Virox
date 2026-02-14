import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:virox/core/data/sources/base_remote_data_source.dart';
import 'package:virox/core/error/exceptions.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockHttpClient;
  late BaseRemoteDataSource dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = BaseRemoteDataSource(client: mockHttpClient);
  });

  group('handleObjectResponse', () {
    test('should return decoded Map if status code is 200', () {
      // arrange
      final response = http.Response('{"status": "ok"}', 200);
      // act
      final result = dataSource.handleObjectResponse(response);
      // assert
      expect(result, {'status': 'ok'});
    });

    test('should return empty Map if status code is 200 and body is empty', () {
      // arrange
      final response = http.Response('', 200);
      // act
      final result = dataSource.handleObjectResponse(response);
      // assert
      expect(result, {});
    });

    test('should throw UnexpectedException with correct errorCode '
        'if status code is not 200', () {
      // arrange
      final response = http.Response('', 404);
      // act
      // assert
      try {
        dataSource.handleObjectResponse(response);
        throw Exception();
      } on UnexpectedException catch (e) {
        expect(e.errorCode, 404);
      }
    });
  });

  group('handleListResponse', () {
    test('should return decoded List if status code is 200', () {
      // arrange
      final response = http.Response('[{"id": 1}, {"id": 2}]', 200);
      // act
      final result = dataSource.handleListResponse(response);
      // assert
      expect(result, [
        {'id': 1},
        {'id': 2},
      ]);
    });

    test(
      'should return empty List if status code is 200 and body is empty',
      () {
        // arrange
        final response = http.Response('', 200);
        // act
        final result = dataSource.handleListResponse(response);
        // assert
        expect(result, []);
      },
    );

    test('should throw UnexpectedException with correct errorCode '
        'if status code is not 200', () {
      // arrange
      final response = http.Response('', 404);
      // act
      final call = dataSource.handleListResponse;
      // assert
      expect(
        () => call(response),
        throwsA(predicate<UnexpectedException>((e) => e.errorCode == 404)),
      );
    });
  });
}
