import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kMainColor = Color(0xff2dba4e);
const kGreyTextColor = Color(0xFF9090AD);
const kBorderColorTextField = Color(0xFFC2C2C2);
const kDarkWhite = Color(0xFFF1F7F7);
const kTitleColor = Color.fromARGB(255, 1, 80, 40);
const kAlertColor =  Color.fromARGB(255, 1, 80, 40);
const kBgColor =  Color(0xFFFAFAFA);
const kHalfDay = Color(0xFFE8B500);
const kGreenColor = Color(0xFF08BC85);

const constPrimaryColor = Color.fromARGB(255, 1, 80, 40);
const constSecondaryColor = Color.fromARGB(221, 206, 123, 145);
const constDangerColor = Color.fromARGB(255, 190, 25, 25);
const constSuccessColor = Color.fromARGB(255, 11, 125, 55);
const constWarningColor = Color.fromARGB(255, 237, 152, 40);

final kTextStyle = GoogleFonts.notoSans(
  color: kTitleColor,
);

final constTextStyle = GoogleFonts.notoSans(
  color: constPrimaryColor
);

final constHeadingStyle = GoogleFonts.notoSans(
  color: Colors.black,
  fontSize: 20,
  textStyle: const TextStyle(
    fontWeight: FontWeight.bold,
  )
);

final constSubStyle = GoogleFonts.notoSans(
  color: Colors.grey,
  fontSize: 15,
);

final constListTitleStyle = GoogleFonts.notoSans(
  color: Colors.black,
  fontSize: 16,
  textStyle: const TextStyle(
    fontWeight: FontWeight.w600,
  )
);

const constButtonDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(
    Radius.circular(6),
  ),
);

final constPrimaryButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(constPrimaryColor),
  padding: MaterialStateProperty.all(const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
);

final constDangerButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(constDangerColor),
  padding: MaterialStateProperty.all(const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
);

final constSuccessButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(constSuccessColor),
  padding: MaterialStateProperty.all(const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15)),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
);

final constInputLabelStyle = GoogleFonts.notoSans(
  fontSize: 17,
);


const kInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: kBorderColorTextField),
  filled: true,
  fillColor: Colors.white70,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(color: kMainColor.withOpacity(0.1)),
  );
}
final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);


    