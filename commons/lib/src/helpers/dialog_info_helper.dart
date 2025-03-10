import 'package:commons/commons.dart';

class DialogInfo {
  static void showDialogInfo({
    BuildContext? context,
    final VoidCallback? onClickButton,
    TypeDialogEnum type = TypeDialogEnum.info,
    String title = '',
    String message = '',
    String titleButton = 'Fechar',
    bool isPersistent = false,
  }) {
    IconData icon = Icons.info;
    Color color = Colors.blue;

    switch (type) {
      case TypeDialogEnum.error:
        icon = Icons.error_outline_rounded;
        color = Colors.red;
        break;
      case TypeDialogEnum.warning:
        icon = Icons.warning_amber_outlined;
        color = Colors.amber;
        break;
      case TypeDialogEnum.success:
        icon = Icons.check_circle_outline_outlined;
        color = Colors.green;
        break;
      case TypeDialogEnum.info:
        icon = Icons.info_outline_rounded;
        color = Colors.blue;
        break;
    }

    showBarModalBottomSheet(
      context: context ?? Get.context!,
      isDismissible: !isPersistent,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            spacing: 8.0,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 60.0, color: color),
              if (title != '')
                Text(
                  title,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              Text(
                message,
                style: TextStyle(fontSize: 14.0),
                textAlign: TextAlign.center,
              ),
              FilledButton(
                onPressed: onClickButton ??
                    () {
                      Navigator.of(context).pop();
                    },
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                ),
                child: Text(titleButton),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showGenericErrorDialog() {
    DialogInfo.showDialogInfo(
        type: TypeDialogEnum.error,
        title: 'Ops! Algo deu errado',
        message: 'Tente novamente em alguns instantes.',
        titleButton: 'Fechar',
        onClickButton: () {
          Navigator.of(Get.context!).pop();
          Get.back();
        },
        isPersistent: true);
  }
}
