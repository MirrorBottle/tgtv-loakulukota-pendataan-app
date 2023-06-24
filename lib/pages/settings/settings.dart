import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../constant.dart';
import 'package:loakulukota_app/pages/auth/sign_in.dart';
import 'package:awesome_dialog/awesome_dialog.dart' as awesome_dialog;
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  void logout() {
    // set up the buttons
    awesome_dialog
      .AwesomeDialog(
        context: context,
        dialogType: awesome_dialog.DialogType.WARNING,
        animType: awesome_dialog.AnimType.BOTTOMSLIDE,
        title: 'Apakah anda yakin ingin keluar?',
        desc: 'Anda harus login sekali lagi jika iya',
        btnOkText: "Ya",
        btnOkOnPress: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLogin', false);
          prefs.remove('auth');
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const SignIn()), (Route route) => false);
        },
        btnCancelText: "Tidak",
        btnCancelOnPress: () {}
      )
      .show();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: constPrimaryColor,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: constPrimaryColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 40.0, bottom: 25),
          child: Text(
            'Pengaturan',
            style: kTextStyle.copyWith(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Container(
              width: context.width(),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0)),
                color: Color(0xFFF6F6F6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      // border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
                    ),
                    child: ListTile(
                      onTap: () => Navigator.pushNamed(context, 'settings-profil'),
                      leading: const Icon(Icons.account_circle),
                      title: Text('Profil',style: kTextStyle,),
                      subtitle:  Text('Detail data registrasi anda',style: kTextStyle.copyWith(color: kGreyTextColor),),
                      trailing: const Icon(Icons.arrow_forward_ios,color: kGreyTextColor,),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      // border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
                    ),
                    child: ListTile(
                      onTap: () => Navigator.pushNamed(context, 'settings-change-password'),
                      leading: const Icon(Icons.lock),
                      title: Text('Ubah Password',style: kTextStyle,),
                      subtitle:  Text('Ubah password anda secara berkala',style: kTextStyle.copyWith(color: kGreyTextColor),),
                      trailing: const Icon(Icons.arrow_forward_ios,color: kGreyTextColor,),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      // border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
                    ),
                    child: ListTile(
                      onTap: () => showAboutDialog(
                        context: context,
                        applicationVersion: '1.1.0',
                        applicationLegalese: 'Aplikasi PT. Anandita',
                        applicationName: 'PT. Anandita App',
                        applicationIcon: const Image(
                          image: AssetImage('assets/images/logo_new.png'),
                          height: 50,
                        ),
                      ),
                      leading: const Icon(Icons.info),
                      title: Text('Tentang Aplikasi',style: kTextStyle.copyWith(),),
                      subtitle:  Text('Versi dan lisensi aplikasi',style: kTextStyle.copyWith(color: kGreyTextColor),),
                      trailing: const Icon(Icons.arrow_forward_ios,color: kGreyTextColor,),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      // border: Border.all(color: kGreyTextColor.withOpacity(0.5)),
                    ),
                    child: ListTile(
                      onTap: logout,
                      leading: const Icon(Icons.logout, color: Colors.red,),
                      title: Text('Keluar',style: kTextStyle.copyWith(color: Colors.red),),
                      trailing: const Icon(Icons.arrow_forward_ios,color: Colors.red,),
                    ),
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
