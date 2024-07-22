enum ImageName{
  placeholder_image
}

extension ImagePathExtension on ImageName{
  String path(){
    return "images/image/$name.png";
  }
}