class Validators{

  static const String _nameNotEmpty = 'Ad soyad boş bırakılamaz';
  static const String _nameIsLetter = 'Ad soyad sadece harflerden oluşmalıdır';

  static const String _emailNotEmpty = 'E-posta boş bırakılamaz';
  static const String _emailIsValid = 'Geçerli bir e-posta giriniz';

  static const String _passwordNotEmpty = 'Şifre boş bırakılamaz';
  static const String _passwordLeastSixCharecter = 'Şifre en az 6 karakter olmalıdır';

  // name 
  String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return _nameNotEmpty;
  }
  //Checks that it consists of letters only, regex
  final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
  if (!nameRegex.hasMatch(value)) {
    return _nameIsLetter;
  }
  return null;
}

   // email
  String? validateEmail(String? data) {
    if (data == null || data.isEmpty) {
      return _emailNotEmpty;
    }
    
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(data)) {
      return _emailIsValid;
    }
    return null;
  }
  // password
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return _passwordNotEmpty;
    }
    if (value.length < 6) {
      return _passwordLeastSixCharecter;
    }
    return null;
  }

}