enum LogoName{
  app_logo
}

extension ImageNameExtension on LogoName{
  String path(){
    return "images/logo/$name.png";
  }
}