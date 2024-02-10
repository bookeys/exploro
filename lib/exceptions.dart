import 'package:flutter/cupertino.dart';

String exceptionToProperString(String exception){
  if(exception.toLowerCase().contains("failed host lookup")){
    return "Connect to a network";
  }
  else if(exception.toLowerCase().contains("time outed")){
    return "Check your connection and please try again.";
  }
  else{
    debugPrint(exception);
    return "Something went wrong.";
  }
}