// ignore_for_file: file_names, implementation_imports

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:hello/language/Generated/key-lang.dart';



class MyDrawer extends StatefulWidget {
  const MyDrawer({ Key? key }) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
          children:  [
             const HeadingImage(),
             Listtile(title: KeyLang.Setting.tr(),
             color: Colors.black ,
             icon: Icons.settings,
             function:()=> Navigator.pushNamed(context, '/Setting') ),
             Listtile(title: KeyLang.Feedback.tr(),
             color: Colors.red ,
             icon: Icons.feedback_rounded,
             function: ()=> Navigator.pushNamed(context, '/MyFeedback')),
             Listtile(title: KeyLang.About.tr(),
             color:Colors.lightBlue ,
             icon: Icons.info,
             function: () => Navigator.pushNamed(context, '/About')),
             Listtile(title: KeyLang.Admin.tr(),
             color:Colors.lightBlue ,
             icon: Icons.admin_panel_settings,
             function: () => Navigator.pushNamed(context, '/SignIn')),
         ],
        ),
    );
  }
}


// Heading image

class HeadingImage extends StatelessWidget {
  const HeadingImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.width - MediaQuery.of(context).padding.top;

    return Container(
      height:  heightScreen * 0.7,
     decoration: const  BoxDecoration(
       image:  DecorationImage(
         image: AssetImage("asset/image/SplashPage/splash.jpg"),
         fit: BoxFit.fill,
         scale: 2
         )
       ),
    );
  }
}

// Items in Drawer
class Listtile extends StatelessWidget {
  final Color? color ;
  final String title;
  final IconData? icon;
  final Function()? function;

  // ignore: use_key_in_widget_constructors
  const Listtile({
     required this.color,
     required this.title,
     required this.icon,
     required this.function
   });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:10 , right: 10 ,left: 10),
      child: ListTile(
        title: Text(title , style: const TextStyle(fontSize: 17),),
        leading: Icon(icon , size: 30, color: color ,),
        onTap: function,
      ),
    );
  }
}