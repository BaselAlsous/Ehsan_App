// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hello/language/Config/config-lang.dart';
import 'package:hello/language/Generated/key-lang.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Setting> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    var heightScreen = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top);
    var widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Text(
          KeyLang.Setting.tr(),
          style: GoogleFonts.notoSans(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        toolbarHeight: heightScreen * 0.2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            titlePadding: const EdgeInsets.all(20),
            title:KeyLang.section1.tr(),
            titleTextStyle: const TextStyle(color: Colors.teal),
            tiles: [
              SettingsTile(
                title: KeyLang.Language.tr(),
                leading: const Icon(Icons.language),
                onPressed: (BuildContext context) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title:  Text(KeyLang.ChooseLanguage.tr()),
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap:(){ EasyLocalization.of(context)?.setLocale(ConfigLanguage.EN_LOCALE);} ,
                                  child: Container(
                                    height: heightScreen * 0.25,
                                    width: widthScreen * 0.25,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'asset/image/lang/English.png'),
                                      ),
                                    ),
                                    child:  Text(KeyLang.English.tr()),
                                  ),
                                ),
                                InkWell(
                                  onTap:(){ EasyLocalization.of(context)?.setLocale(ConfigLanguage.AR_LOCALE);} ,
                                  child: Container(
                                    height: heightScreen * 0.25,
                                    width: widthScreen * 0.25,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'asset/image/lang/Arabic.png'),
                                      ),
                                    ),
                                    child:  Text(KeyLang.Arabic.tr()),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              OutlineButton(
                                  color: Colors.teal,
                                  child:  Text(KeyLang.Cansel.tr()),
                                  textColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ));
                },
              ),
              SettingsTile.switchTile(
                title: KeyLang.UseSystemTheme.tr(),
                leading: const Icon(Icons.phone_android),
                switchValue: isSwitched,
                switchActiveColor: Colors.teal,
                onToggle: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
