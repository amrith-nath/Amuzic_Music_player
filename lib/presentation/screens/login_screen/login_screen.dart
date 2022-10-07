import 'dart:developer';

import 'package:amuzic/application/login_screen_cubit/login_screen_cubit.dart';
import 'package:amuzic/core/fonts/fonts.dart';
import 'package:amuzic/main.dart';
import 'package:amuzic/presentation/screens/home_screen/home_screen.dart';
import 'package:amuzic/core/theme/app_theme.dart';
import 'package:amuzic/widgets/containers/top_container.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_to_act/slide_to_act.dart';

bool isSwiped = true;
final _textController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      log('thgis is a log from login screen');
    });

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
                  BlocBuilder<LoginScreenCubit, LoginScreenState>(
                    builder: (context, state) {
                      return Column(children: [
                        !state.isSwiped
                            ? loginTextBody(height, width)
                            : loginTextField(height, width),
                        !state.isSwiped
                            ? SizedBox(height: 0.065 * height)
                            : SizedBox(height: 0.12 * height),
                        !state.isSwiped
                            ? slideButton(width, context)
                            : InkWell(
                                onTap: (() async {
                                  await saveUserName(context);
                                }),
                                child: submitButton(width),
                              ),
                      ]);
                    },
                  )
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }

//!widgets and methods----------->

  SlideInRight loginTextField(double height, double width) {
    return SlideInRight(
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
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                    borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: const Color.fromRGBO(217, 217, 217, 1),
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
    );
  }

  SlideInRight loginTextBody(double height, double width) {
    return SlideInRight(
      key: const Key('1'),
      duration: const Duration(milliseconds: 200),
      child: Column(
        children: [
          SizedBox(height: 0.065 * height),
          SizedBox(
            child: MyFont.montBold36('Listen To\nMusic You\nActually Like'),
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
    );
  }

  SlideInUp slideButton(double width, BuildContext context) {
    return SlideInUp(
      duration: const Duration(milliseconds: 200),
      child: SizedBox(
        width: 0.81 * width,
        child: SlideAction(
          animationDuration: const Duration(milliseconds: 0),
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
            isSwiped = false;
            BlocProvider.of<LoginScreenCubit>(context).isSwiped();

            // setState(() {
            //   isSwiped = false;
            // });
          },
        ),
      ),
    );
  }

  SlideInUp submitButton(double width) {
    return SlideInUp(
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
    );
  }

  saveUserName(BuildContext context) async {
    navigateToHomeScreen(context, _textController.text);

    await preferences.setBool('isLogin', true);
    await preferences.setString('user_name', _textController.text);
  }

  navigateToHomeScreen(context, text) async {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => HomeScreen(
                userName: text,
              )));
    }
  }
}
