import 'package:amuzic/fonts/fonts.dart';
import 'package:amuzic/main.dart';
import 'package:amuzic/screens/home_screen.dart';
import 'package:amuzic/theme/app_theme.dart';
import 'package:amuzic/widgets/top_container.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:slide_to_act/slide_to_act.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({required this.allSongs, Key? key}) : super(key: key);
  List<Audio> allSongs;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool isSwiped = true;
final _textController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    //
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Center(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                children: [
                  TopContainer(width, height, 'assets/images/red_lady.png'),
                  isSwiped
                      ? SlideInRight(
                          key: const Key('1'),
                          duration: const Duration(milliseconds: 200),
                          child: Column(
                            children: [
                              SizedBox(height: 0.065 * height),
                              SizedBox(
                                child: MyFont.montBold36(
                                    'Listen To\nMusic You\nActually Like'),
                                width: 0.77 * width,
                              ),
                              SizedBox(height: 0.005 * height),
                              SizedBox(
                                child: MyFont.montSemiBold13(
                                    'An interactive music app designed\nto really provide a fully-formed\nexperience to better your mood\nalso with meditating\nsounds to train\nyour Mind'),
                                width: 0.77 * width,
                              ),
                            ],
                          ),
                        )
                      : SlideInRight(
                          key: const Key('2'),
                          duration: const Duration(milliseconds: 200),
                          child: Column(
                            children: [
                              SizedBox(height: 0.1 * height),
                              SizedBox(
                                child: MyFont.montBold36('Enter Your\nName'),
                                width: 0.77 * width,
                              ),
                              SizedBox(height: 0.005 * height),
                              SizedBox(
                                width: 0.77 * width,
                                child: TextFormField(
                                  validator: ((value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Name';
                                    }
                                    return null;
                                  }),
                                  controller: _textController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 0, style: BorderStyle.none),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    filled: true,
                                    fillColor:
                                        const Color.fromRGBO(217, 217, 217, 1),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 0.77 * width,
                                child: MyFont.montSemiBold10grey(
                                    '\n* Let us customize your App with your Name'),
                              )
                            ],
                          ),
                        ),
                  isSwiped
                      ? SizedBox(height: 0.065 * height)
                      : SizedBox(height: 0.12 * height),
                  isSwiped
                      ? SlideInUp(
                          duration: const Duration(milliseconds: 200),
                          child: SizedBox(
                            width: 0.81 * width,
                            child: SlideAction(
                              animationDuration:
                                  const Duration(milliseconds: 0),
                              outerColor: Colors.transparent,
                              elevation: 0,
                              innerColor: MyTheme.blueDark,
                              sliderButtonIcon: const Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white,
                                size: 35,
                              ),
                              submittedIcon: const SizedBox(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyFont.montRegular10('Get Started'),
                                  Icon(
                                    Icons.chevron_right,
                                    color: MyTheme.blueDark,
                                  ),
                                ],
                              ),
                              onSubmit: () {
                                setState(() {
                                  isSwiped = false;
                                });
                              },
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: (() async {
                            navigateToHomeScreen(context, _textController.text);

                            await preferences.setBool('isLogin', true);
                            await preferences.setString(
                                'user_name', _textController.text);
                          }),
                          child: SlideInUp(
                            duration: const Duration(milliseconds: 200),
                            child: Ink(
                              child: Container(
                                width: 0.3 * width,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: MyTheme.blueDark,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          blurRadius: 4,
                                          offset: Offset(0, 4))
                                    ]),
                                child: const Icon(
                                  Icons.check,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }

  navigateToHomeScreen(context, text) async {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => HomeScreen(
                userName: text,
                allSongs: widget.allSongs,
              )));
    }
  }
}
