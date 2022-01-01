import 'package:android_dev_test/second_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool isPalindrome = false;
  final nameController = TextEditingController();
  final palindromeController = TextEditingController();

  @override
  void initState() {
    isPalindrome = false;
  }

  @override
  void dispose() {
    nameController.dispose();
    palindromeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // enableButton() {
    //   setState(() {
    //     isPalindrome = true;
    //   });
    // }
    //
    // disableButton() {
    //   setState(() {
    //     isPalindrome = false;
    //   });
    // }

    bool checkPalindrome(String inputString) {
      String textFilter = inputString.replaceAll(' ', '');
      for (int i = 0; i < textFilter.length ~/ 2; i++) {
        if (textFilter[i] != textFilter[textFilter.length - i - 1])
          return false;
      }
      return true;
    }

    return CupertinoPageScaffold(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/btn_add_photo.png", width: 116),
                SizedBox(height: 58.0),
                CupertinoTextField(
                  controller: nameController,
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  placeholder: "Name",
                  padding: EdgeInsets.only(
                    top: 7.94,
                    bottom: 7.94,
                    left: 20,
                    right: 16,
                  ),
                ),
                SizedBox(height: 22.0),
                CupertinoTextField(
                  controller: palindromeController,
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  placeholder: "Palindrome",
                  padding: EdgeInsets.only(
                    top: 7.94,
                    bottom: 7.94,
                    left: 20,
                    right: 16,
                  ),
                ),
                SizedBox(height: 45.0),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    child: Text("CHECK"),
                    onPressed: () {
                      setState(() {
                        isPalindrome =
                            checkPalindrome(palindromeController.text);
                      });
                      // print(checkPalindrome(palindromeController.text));
                      print(palindromeController.text);
                    },
                  ),
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    onPressed: isPalindrome
                        ? () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SecondScreen(
                                  username: nameController.text);
                            }));
                          }
                        : null,
                    child: Text("NEXT"),
                    disabledColor: CupertinoColors.systemGrey,
                  ),
                ),
                // ButtonCheckPalindrome(
                //   username: nameController.text,
                //   textPalindrome: palindromeController.text,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonCheckPalindrome extends StatefulWidget {
  final String username;
  final String textPalindrome;

  const ButtonCheckPalindrome(
      {Key? key, required this.username, required this.textPalindrome})
      : super(key: key);

  @override
  _ButtonCheckPalindromeState createState() => _ButtonCheckPalindromeState();
}

class _ButtonCheckPalindromeState extends State<ButtonCheckPalindrome> {
  bool isPalindrome = false;

  bool checkPalindrome(String inputString) {
    String textFilter = inputString.replaceAll(' ', '');
    for (int i = 0; i < textFilter.length ~/ 2; i++) {
      if (textFilter[i] != textFilter[textFilter.length - i - 1]) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: CupertinoButton.filled(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            child: Text("CHECK"),
            onPressed: () {
              // setState(() {
              //   isPalindrome = checkPalindrome(widget.textPalindrome);
              // });
              print(checkPalindrome(widget.textPalindrome));
              print(widget.textPalindrome);
            },
          ),
        ),
        SizedBox(height: 15.0),
        isPalindrome ? Text("benar") : Text("salah"),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton.filled(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            onPressed: isPalindrome
                ? () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SecondScreen(username: widget.username);
                    }));
                  }
                : null,
            child: Text("NEXT"),
            disabledColor: CupertinoColors.systemGrey,
          ),
        ),
      ],
    );
  }
}
