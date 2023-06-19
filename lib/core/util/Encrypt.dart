import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:crypto/crypto.dart';

class Encryption {
  static final Encryption instance = Encryption._();

  late IV _iv;
  late Encrypter _encrypter;

  Encryption._() {
    const mykey = 'ThisIsASecuredKey';
    const myiv = 'ThisIsASecuredBlock';
    final keyUtf8 = utf8.encode(mykey);
    final ivUtf8 = utf8.encode(myiv);
    final key = sha256.convert(keyUtf8).toString().substring(0, 32);
    final iv = sha256.convert(ivUtf8).toString().substring(0, 16);
    _iv = IV.fromUtf8(iv);

    _encrypter = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.cbc));
  }

  String encrypt(String value) {
    return _encrypter.encrypt(value, iv: _iv).base64;
  }

  String decrypt(String base64value) {
    final encrypted = Encrypted.fromBase64(base64value);
    return _encrypter.decrypt(encrypted, iv: _iv);
  }

  checkIsCorrect(String userpassword,String dbpassword){
   dbpassword=  decrypt(dbpassword);

  return dbpassword.compareTo(userpassword);

  }


}