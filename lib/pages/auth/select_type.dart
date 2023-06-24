import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/material.dart';
import 'package:loakulukota_app/pages/auth/sign_in.dart';

import '../../constant.dart';

class SelectType extends StatefulWidget {
  const SelectType({Key? key}) : super(key: key);

  @override
  _SelectTypeState createState() => _SelectTypeState();
}

class _SelectTypeState extends State<SelectType> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover,),
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(image: AssetImage("assets/images/logo.png")),
                    const SizedBox(height: 100.0,),
                    const Image(image: AssetImage("assets/images/people.png"),),
                    Text('Select Your Role',style: kTextStyle.copyWith(fontSize: 20.0,fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: kMainColor),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          onTap: (){
                            const SignIn().launch(context);
                          },
                          leading: const Image(image: AssetImage('assets/images/owner.png'),),
                          title: Text('Business Owner / Admin / HR', style: kTextStyle.copyWith(fontSize: 14.0),),
                          subtitle: Text('Register your company & start attendance ', style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 12.0),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: kGreyTextColor),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          onTap: (){
                            const SignIn().launch(context);
                          },
                          leading: const Image(image: AssetImage('assets/images/employee.png'),),
                          title: Text('Employee', style: kTextStyle.copyWith(fontSize: 14.0),),
                          subtitle: Text('Register and start marking your attendance', style: kTextStyle.copyWith(color: kGreyTextColor,fontSize: 12.0),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          )
      ),
    );
  }
}
