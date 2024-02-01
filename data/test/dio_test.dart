// import 'package:data/data/user/provider/user_repository_factory_provider.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:riverpod/riverpod.dart';
//
// void main() {
//   group("Dio 테스트", () {
//     test('직접 데이터 가져오기', () async {
//       final dio = Dio(
//         BaseOptions(
//           baseUrl: 'https://jsonplaceholder.typicode.com',
//         ),
//       );
//
//       final response = await dio.get(
//         '/users',
//       );
//
//       expect(response.statusCode, 200);
//     });
//     test('프로바이더로 데이터 가져오기', () async {
//       final container = ProviderContainer();
//       final dio = Dio(
//         BaseOptions(
//           baseUrl: 'https://jsonplaceholder.typicode.com',
//         ),
//       );
//
//       // final userProvider = container.read(userRepositoryFactoryProvider(dio));
//
//       final res = await userProvider.getUsers();
//
//       expect(res.length, 10);
//     });
//   });
// }
