enum JsonItems{ lottie_book_loading }

extension LottiePathExtension on JsonItems{

  String path(){
    return "images/json/$name.json";
  }

}