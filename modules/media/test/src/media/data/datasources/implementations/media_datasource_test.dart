import 'package:media/src/media/data/datasources/implementations/media_datasource.dart';
import 'package:media/src/media/data/models/media/space_media_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';

class MockHttp extends Mock implements Http {}

class FakeHttpRequest extends Fake implements HttpRequest {}

void main() {
  late MediaDataSource dataSource;
  late MockHttp mockHttp;

  setUpAll(() {
    registerFallbackValue(FakeHttpRequest());
  });

  setUp(() {
    mockHttp = MockHttp();
    dataSource = MediaDataSource(http: mockHttp);
  });

  group('getSpaceMedia', () {
    final tDate = '2022-01-01';
    final tSpaceMediaModel = SpaceMediaModel(
      title: 'Test Title',
      explanation: 'Test Description',
      mediaType: 'image',
      url: 'https://example.com/image.jpg',
    );

    test('should return SpaceMediaModel when the call to http is successful',
        () async {
      // arrange
      when(() => mockHttp.get(any())).thenAnswer((_) async => HttpResponse(
            data: tSpaceMediaModel.toJson(),
            statusCode: 200,
          ));
      // act
      final result = await dataSource.getSpaceMedia(date: tDate);
      // assert
      expect(result, equals(tSpaceMediaModel));
    });

    test(
        'should throw HttpException when the call to http throws HttpException',
        () async {
      // arrange
      when(() => mockHttp.get(any()))
          .thenThrow(HttpException('Failed to load data'));
      // act
      final call = dataSource.getSpaceMedia(date: tDate);
      // assert
      expect(() => call, throwsA(isA<HttpException>()));
    });

    test('should throw Exception when the call to http throws Exception',
        () async {
      // arrange
      when(() => mockHttp.get(any())).thenThrow(Exception('Unexpected error'));
      // act
      final call = dataSource.getSpaceMedia(date: tDate);
      // assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });

  group('getListSpaceMedia', () {
    final tStartDate = '2022-01-01';
    final tEndDate = '2022-01-10';
    final tSpaceMediaModelList = [
      SpaceMediaModel(
        title: 'Test Title 1',
        explanation: 'Test Description 1',
        mediaType: 'image',
        url: 'https://example.com/image1.jpg',
      ),
      SpaceMediaModel(
        title: 'Test Title 2',
        explanation: 'Test Description 2',
        mediaType: 'image',
        url: 'https://example.com/image2.jpg',
      ),
    ];

    test(
        'should return list of SpaceMediaModel when the call to http is successful',
        () async {
      // arrange
      when(() => mockHttp.get(any())).thenAnswer((_) async => HttpResponse(
            data: tSpaceMediaModelList.map((e) => e.toJson()).toList(),
            statusCode: 200,
          ));
      // act
      final result = await dataSource.getListSpaceMedia(
          startDate: tStartDate, endDate: tEndDate);
      // assert
      expect(result, equals(tSpaceMediaModelList));
    });

    test(
        'should throw HttpException when the call to http throws HttpException',
        () async {
      // arrange
      when(() => mockHttp.get(any())).thenThrow(HttpException('Http Error'));
      // act
      final call = dataSource.getListSpaceMedia(
          startDate: tStartDate, endDate: tEndDate);
      // assert
      expect(() => call, throwsA(isA<HttpException>()));
    });

    test('should throw Exception when the call to http throws Exception',
        () async {
      // arrange
      when(() => mockHttp.get(any())).thenThrow(Exception('Generic Error'));
      // act
      final call = dataSource.getListSpaceMedia(
          startDate: tStartDate, endDate: tEndDate);
      // assert
      expect(() => call, throwsA(isA<Exception>()));
    });
  });
}
