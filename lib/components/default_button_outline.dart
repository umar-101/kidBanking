import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButtonOut extends StatelessWidget {
  const DefaultButtonOut({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: getProportionateScreenHeight(56),
        child: TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            primary: Colors.white,
            side: const BorderSide(
              color: kPrimaryColor,
              width: 1,
            ),
            backgroundColor: Colors.white,
          ),
          onPressed: press as void Function()?,
          child: Text(
            text!,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(18),
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
