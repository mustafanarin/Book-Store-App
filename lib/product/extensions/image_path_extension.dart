enum ImageName{
  app_logo
}

extension ImageNameExtension on ImageName{
  String path(){
    return "images/logo/$name.png";
  }
}