import 'dart:math';
import 'package:string_validator/string_validator.dart';

// void main() {
//   print(convertText('This is the new text. Hallo 12.'));
//
// }

String convertText(String userText)  {
  String convertedText = '';
  Random random = Random();
  int lengthOfText = userText.length;

  for(int i = 0; i<lengthOfText; i++) {

    int rand = random.nextInt(2);
    String character = userText[i];

    if(isAlpha(character)) {
      if (character == 'l' || character == 'L') {
        convertedText += 'L';
      }
      else if (character == 'i' || character == 'I') {
        convertedText += 'i';
      }
      else {
        if (rand == 0) {
          convertedText += character.toLowerCase();
        }
        else {
          convertedText += character.toUpperCase();
        }
      }
    }
    else  {
      convertedText += character;
    }
  }
  return convertedText;
}