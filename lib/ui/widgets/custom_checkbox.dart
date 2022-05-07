import 'package:flutter/material.dart';
import 'package:kindergarten/ui/widgets/custom_text.dart';

class RemamberMe extends StatefulWidget {
  final Function(bool? value) onChange;

  const RemamberMe({Key? key, required this.onChange}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RemamberMeState();
}

class _RemamberMeState extends State<RemamberMe> {
  bool _remamberMe = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Checkbox(
            onChanged: (bool? value) {
              setState(() {
                if (value != null) {
                  _remamberMe = value;
                }
              });
            },
            value: _remamberMe,
            checkColor: Colors.greenAccent,
            activeColor: Colors.white,
          ),
        ),
        const CustomText(
          text: 'Remamber Me',
          color: Colors.white,
          fontSize: 14,
        )
      ],
    );
  }
}
