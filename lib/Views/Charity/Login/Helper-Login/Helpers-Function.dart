// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class HelpersFunction {

  static String sharedPreferenceUserLoggedInKey = "userILogin";
  static String sharedPreferenceUserId = "userName";

  //  saving data to shared preference

  static Future<bool?> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }



    static Future<bool?> saveUserIdInSharedPreference(String userName) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserId , userName);
  }

   // fetching data from shared preference

    static Future<bool?> getUserLoggedInSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getBool(sharedPreferenceUserLoggedInKey);
  }
 static Future<String?> getUserNameSharedPreference() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getString(sharedPreferenceUserId);
  }

}