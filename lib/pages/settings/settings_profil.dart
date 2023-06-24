import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:loakulukota_app/constant.dart';
import 'dart:convert';

class SettingsProfilScreen extends StatefulWidget {
  const SettingsProfilScreen({Key? key}) : super(key: key);

  @override
  _SettingsProfilScreenState createState() => _SettingsProfilScreenState();
}

class _SettingsProfilScreenState extends State<SettingsProfilScreen> {
  
  Map<String,dynamic> _auth = {};
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _encodedAuth = prefs.getString('auth') ?? "{}";
    setState(() {
      _auth = json.decode(_encodedAuth);
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
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
            padding: const EdgeInsets.only(left: 20.0, top: 50.0, bottom: 25),
            child: Text(
              'Profil',
              style: kTextStyle.copyWith(color: Colors.white, fontSize: 20.0),
            ),
          ),
          leading: const Padding(
            padding: EdgeInsets.only(top: 28.0),
            child: BackButton(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Container(
                constraints: BoxConstraints(
                  minHeight: context.height() - 80
                ),
                width: context.width(),
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: context.width(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            "Detail Pribadi",
                            textAlign: TextAlign.left,
                            style: constListTitleStyle,
                          ),
                          const SizedBox(height: 10),
                          ListTile(
                            leading: const Text("Nama"),
                            trailing: Text(_auth['name'] ?? '-'),
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                          ),
                          ListTile(
                            leading: const Text("Username"),
                            trailing: Text(_auth['username'] ?? '-'),
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                          ),
                          ListTile(
                            leading: const Text("Hak akses"),
                            trailing: Text(_auth['role'] ?? '-'),
                            contentPadding: const EdgeInsets.all(0),
                            dense: true,
                          ),
                        ],
                      )
                    ),
                    
                  ],
                ),
              ),
            ],
          )
        ),
      )
    );
  }
}
