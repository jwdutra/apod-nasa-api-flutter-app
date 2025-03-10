import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:media/src/media/presentation/media/media_controller.dart';
import 'package:media/src/media/domain/repositories/media_repository.dart';
import 'package:media/src/media/domain/entities/space_media_entity.dart';

class MockMediaRepository extends Mock implements IMediaRepository {}

class FakeSpaceMediaEntity extends Fake implements SpaceMediaEntity {}

void main() {
  late MediaController controller;
  late MockMediaRepository mockMediaRepository;

  setUpAll(() {
    registerFallbackValue(FakeSpaceMediaEntity());
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    mockMediaRepository = MockMediaRepository();
    controller = MediaController(mediaRepository: mockMediaRepository);
  });

  final tSpaceMediaEntity = SpaceMediaEntity(
    title: 'Test Title',
    explanation: 'Test Description',
    mediaType: 'image',
    url: 'https://example.com/image.jpg',
    date: '2022-01-01',
  );

  test('should initialize media and isFavorite on onInit', () async {
    when(() => mockMediaRepository.getSpaceMedia())
        .thenAnswer((_) async => tSpaceMediaEntity);
    when(() => mockMediaRepository.isFavorite(any()))
        .thenAnswer((_) async => true);

    await controller.onInit();

    expect(controller.media.value, equals(tSpaceMediaEntity));
    expect(controller.isFavorite.value, equals(true));
    verify(() => mockMediaRepository.getSpaceMedia()).called(1);
    verify(() => mockMediaRepository.isFavorite(any())).called(1);
  });

  test('should set favorite media', () async {
    when(() => mockMediaRepository.setFavoriteSpaceMedia(any()))
        .thenAnswer((_) async => [tSpaceMediaEntity]);
    when(() => mockMediaRepository.removeFavoriteSpaceMedia(any()))
        .thenAnswer((_) async => []);
    when(() => mockMediaRepository.isFavorite(any()))
        .thenAnswer((_) async => false);

    await controller.setFavorite(tSpaceMediaEntity);

    expect(controller.isFavorite.value, equals(true));
    verify(() => mockMediaRepository.setFavoriteSpaceMedia(any())).called(1);

    await controller.setFavorite(tSpaceMediaEntity);

    expect(controller.isFavorite.value, equals(false));
    verify(() => mockMediaRepository.removeFavoriteSpaceMedia(any())).called(1);
  });
}
