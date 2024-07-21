enum LottieItems{ book_loading }

extension LottiePathExtension on LottieItems{

  String _path(){
    return "lottie_book_loading";
  }

  String get lottiePath => "images/lottie/${_path()}.json";

}