import 'package:core/core.dart';

class ExpandableText extends StatelessWidget {
  final String text;
  final int maxLength;
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);

  ExpandableText({super.key, required this.text, this.maxLength = 100});

  @override
  Widget build(BuildContext context) {
    String firstHalf;
    String secondHalf;

    if (text.length > maxLength) {
      firstHalf = text.substring(0, maxLength);
      secondHalf = text.substring(maxLength, text.length);
    } else {
      firstHalf = text;
      secondHalf = "";
    }

    return ValueListenableBuilder(
      valueListenable: _isExpanded,
      builder: (context, isExpanded, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              isExpanded ? text : firstHalf + (secondHalf.isEmpty ? "" : "..."),
              style: TextStyle(fontSize: 16.0),
            ),
            secondHalf.isEmpty
                ? Container()
                : InkWell(
                    child: Row(
                      children: <Widget>[
                        Text(
                          isExpanded ? "Veja menos" : "Veja mais",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    onTap: () {
                      _isExpanded.value = !isExpanded;
                    },
                  ),
          ],
        );
      },
    );
  }
}
