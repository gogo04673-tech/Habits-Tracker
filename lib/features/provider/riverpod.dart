import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

//final providerName = Provider<String>((ref) => "Hello World, I am Mohamed");

//final countProvider = StateProvider<int>((ref) => 0);

// * future provider

// final welcomeProvider = FutureProvider((ref) async {
//   return await fetchName();
// });

// Future<List<dynamic>> fetchName() async {
//   final response = await http.get(
//     Uri.parse('https://jsonplaceholder.typicode.com/users/1'),
//   );

//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);

//     return data;
//   } else {
//     throw Exception("Failed to load data");
//   }
// }

// final apiService = Provider<ApiService>((ref) => ApiService());

// final postProvider = FutureProvider<Map>((ref) {
//   final api = ref.read(apiService);

//   return api.fetchPosts();
// });

// ! Notifier Provider is here

// class CountNotifier extends Notifier<int> {
//   @override
//   int build() {
//     return 0;
//   }

//   void increment() => state++;
//   void rest() => state = 0;
// }

// final countNotifierProvider = NotifierProvider<CountNotifier, int>(
//   () => CountNotifier(),
// );

class DrawerZoom extends Notifier<ZoomDrawerController> {
  @override
  build() {
    final ZoomDrawerController controller = ZoomDrawerController();
    return controller;
  }
}

final ZoomNotifier = NotifierProvider<DrawerZoom, ZoomDrawerController>(
  () => DrawerZoom(),
);

final bottomNavIndex = StateProvider<int>((ref) => 0);
// ? fetch todo API
Future<List<String>> fetchTodo() async {
  await Future.delayed(const Duration(seconds: 3));
  return ['Go to gym', 'Drink water', 'Buy food', 'not todo'];
}

// ! Async Notifier Provider
class TodoNotifier extends AsyncNotifier<List<String>> {
  @override
  FutureOr<List<String>> build() {
    return fetchTodo();
  }

  void addTodo(String task) {
    state = AsyncValue.data([...state.value ?? [], task]);
  }
}

final todoNotifierProvider = AsyncNotifierProvider<TodoNotifier, List<String>>(
  () => TodoNotifier(),
);
