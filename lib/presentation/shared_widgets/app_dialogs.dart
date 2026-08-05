import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AppDialogs{

  static void loadingDialog({
    required BuildContext context,
    required String loadingMessage,
    bool dismissable = true,
  }){
    showDialog(
        context: context,
        barrierDismissible: dismissable,
        builder: (context) {

      if(Platform.isAndroid)
        {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 8,),
                Text(loadingMessage),
              ],
            ),
          );
        }
      else
        {
          return CupertinoAlertDialog(
            content: Row(
              children: [
                CupertinoActivityIndicator(
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(width: 8,),
                Text(loadingMessage),
              ],
            ),
          );
        }

    },
    );
  }

  static void actionDialog({
    required BuildContext context,
    bool dismissable = true,
    String? title,
    String? content,
    String? posActionTitle,
    Function? posAction,
    String? negActionTitle,
    Function? negAction,
}){
    showDialog(
        context: context,
        barrierDismissible: dismissable,
        builder: (context) {

          if(Platform.isAndroid)
          {
            return AlertDialog(
              title: title == null?null:Text(title),
              content: content== null? null : Text(content),
              actions: [
                if(posActionTitle != null)
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                        if(posAction!=null)
                        {
                          posAction();
                        }
                      },
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        decoration: TextDecoration.none,
                        color: AppColors.black,
                        fontSize: 16,
                      )
                    ),
                      child: Text(posActionTitle)
                  ),

                if(negActionTitle != null)
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                        if(negAction!=null)
                        {
                          negAction();
                        }
                      },
                      style: TextButton.styleFrom(
                          textStyle: TextStyle(
                            decoration: TextDecoration.none,
                            color: AppColors.black,
                            fontSize: 16,
                          )
                      ),
                      child: Text(negActionTitle)
                  ),
              ],
            );
          }
          else
          {
            return CupertinoAlertDialog(
              title: title == null?null:Text(title),
              content: content== null? null : Text(content),
              actions: [
                if(posActionTitle != null)
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                        if(posAction!=null)
                        {
                          posAction();
                        }
                      },
                      style: TextButton.styleFrom(
                          textStyle: TextStyle(
                            decoration: TextDecoration.none,
                            color: AppColors.black,
                            fontSize: 16,
                          )
                      ),
                      child: Text(posActionTitle)
                  ),

                if(negActionTitle != null)
                  TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                        if(negAction!=null)
                        {
                          negAction();
                        }
                      },
                      style: TextButton.styleFrom(
                          textStyle: TextStyle(
                            decoration: TextDecoration.none,
                            color: AppColors.black,
                            fontSize: 16,
                          )
                      ),
                      child: Text(negActionTitle)
                  ),
              ],
            );
          }

        },
    );
  }


}