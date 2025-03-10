import 'package:core/core.dart';

import 'home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20.0,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/nasa.jpg'),
            ),
            Text('Imagem de astronomia do dia.',
                style: TextStyle(fontSize: 20)),
            FilledButton(
              onPressed: () {
                Get.toNamed(AppRoute.media.initial);
              },
              child: Text('Acessar Mídias'),
            ),
          ],
        ),
      ),
    );
  }
}
