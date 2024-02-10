String? validateEmail(String? value) {
  // String pattern =
  //     r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
  //     r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
  //     r"{0,253}[a-zA-Z0-9])?)*$";

  String pattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}
bool validateEmailBool(String? value) {
  // String pattern =
  //     r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
  //     r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
  //     r"{0,253}[a-zA-Z0-9])?)*$";

  String pattern = r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return false;
  } else {
    return true;
  }
}


String? validatePhone(String? value) {


  if (value == null || value.isEmpty || value.length < 10) {
    return 'Please enter a valid phone no';
  } else {
    return null;
  }
}
bool validatePhoneBool(String? value) {
  if (value == null || value.isEmpty) {
    return false;
  } else {
    return true;
  }
}

String? validateName(String? value) {

  if (value == null || value.isEmpty) {
    return 'Enter name';
  } else {
    return null;
  }
}
bool validateNameBool(String? value) {

  if (value == null || value.isEmpty) {
    return false;
  } else {
    return true;
  }
}


String? validateDropDown(String? value){
  if(value == null || value.isEmpty){
    return 'Select any one value';
  }else{
    return null;
  }
}

bool validateDropDownBool(String? value){
  if(value == null || value.isEmpty){
    return false;
  }else{
    return true;
  }
}