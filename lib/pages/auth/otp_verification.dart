import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loakulukota_app/general_components/button_global.dart';
import 'package:loakulukota_app/general_components/otp_form.dart';
import 'package:loakulukota_app/pages/home/main_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../constant.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: constPrimaryColor,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: constPrimaryColor,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: const Padding(
          padding: EdgeInsets.only(top: 28.0),
          child: BackButton(),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Text(
            'Verifikasi Nomor Perangkat',
            style: kTextStyle.copyWith(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
            const EdgeInsets.only(left: 20.0, bottom: 30.0, top: 10.0),
            child: Text(
              'Verifikasi hanya dilakukan sekali saja',
              style:
              GoogleFonts.notoSans(color: Colors.white, fontSize: 14.0),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: context.width(),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: const Border(
                        left: BorderSide(
                          color: kAlertColor,
                          width: 3.0,
                        )
                      ),
                      color: kAlertColor.withOpacity(0.1),
                    ),
                    child: Text(
                      'OTP Input',
                      style: kTextStyle.copyWith(
                          color: kTitleColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const OtpForm(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: 150,
                    padding: const EdgeInsets.all(10.0),
                    decoration: constButtonDecoration.copyWith(color: kTitleColor.withOpacity(0.1)),
                    child: Text(
                      'Kirim Ulang OTP',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSans(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500
                      ),
                      // style: kTextStyle.copyWith(
                      //     color: kTitleColor,
                      //     fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text:
                          'You can request otp again after ',
                          style: kTextStyle.copyWith(
                            color: kAlertColor,
                          ),
                        ),
                        TextSpan(
                          text:
                          '1:12',
                          style: kTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: kAlertColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ButtonGlobal(
                    buttontext: 'Verifikasi',
                    buttonDecoration: constButtonDecoration.copyWith(color: constPrimaryColor),
                    onPressed: () {
                      const MainScreen().launch(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
