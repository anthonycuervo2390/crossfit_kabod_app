import 'package:crossfit_kabod_app/core/presentation/providers/providers.dart';
import 'package:crossfit_kabod_app/core/presentation/res/colors.dart';
import 'package:crossfit_kabod_app/core/presentation/res/routes.dart';
import 'package:crossfit_kabod_app/features/auth/data/model/user_repository.dart';
import 'package:crossfit_kabod_app/features/auth/presentation/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:crossfit_kabod_app/generated/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  TextEditingController _email;
  TextEditingController _password;
  FocusNode _passwordField;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = Tween<double>(begin: 0, end: -300).animate(controller)
      ..addListener(() {
        controller.forward();
        setState(() {});
      });

    _email = TextEditingController(text: "");
    _password = TextEditingController(text: "");
    _passwordField = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, watch, _) {
        final user = watch(userRepoProvider);
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/crossfit.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.transparent,
                Colors.transparent,
                Color(0xff161d27).withOpacity(0.9),
                Color(0xff161d27),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
            FadeInUp(
              duration: Duration(seconds: 3),
              from: 300,
              child: Hero(
                tag: 'logo',
                child: Container(
                  alignment: AlignmentDirectional.topCenter,
                  child: Image.asset(
                    'images/logo_kabod.png',
                    width: MediaQuery.of(context).size.width * 0.30,
                  ),
                ),
              ),
            ),
            Center(
              child: Form(
                key: _formKey,
                child: FadeInUpBig(
                  delay: Duration(seconds: 3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        S.of(context).loginPageTitleText,
                        style: TextStyle(
                            color: AppColors.labelColor,
                            fontSize: 38,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        S.of(context).welcomeSubtitleText,
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 16),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 40, right: 40),
                        child: LoginField(
                          key: Key('email-field'),
                          controller: _email,
                          validator: (value) => (value.isEmpty)
                              ? S.of(context).emailValidationError
                              : null,
                          isPassword: false,
                          hintText: S.of(context).emailFieldlabel,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(_passwordField);
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 50,
                        margin: EdgeInsets.only(left: 40, right: 40),
                        child: LoginField(
                          focusNode: _passwordField,
                          key: Key('password-field'),
                          controller: _password,
                          validator: (value) => (value.isEmpty)
                              ? S.of(context).passwordValidationError
                              : null,
                          isSecure: true,
                          hintText: S.of(context).passwordFieldLabel,
                          onEditingComplete: _login,
                        ),
                      ),
                      SizedBox(height: 12),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.resetPassword),
                        child: Text(
                          S.of(context).forgotPasswordButtonText,
                          style: TextStyle(
                              color: AppColors.labelColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      if (user.status == Status.Authenticating)
                        Center(child: CircularProgressIndicator()),
                      if (user.status != Status.Authenticating)
                        Container(
                          height: 50,
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: RaisedButton(
                            color: AppColors.buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            onPressed: _login,
                            child: Text(
                              S.of(context).loginButtonText,
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  _login() async {
    if (_formKey.currentState.validate()) {
      if (!await context
          .read(userRepoProvider)
          .signIn(_email.text, _password.text))
        Scaffold.of(context).showSnackBar(SnackBar(
          //TODO: change error message
          content: Text(context.read(userRepoProvider).error),
        ));
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
