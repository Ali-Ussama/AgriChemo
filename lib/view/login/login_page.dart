
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/providers/authenticate/authentication_provider.dart';
import 'package:tarek_agro/utils/colors_utils.dart';
import 'package:tarek_agro/view/customWidgets/custom_dialogs.dart';
import 'package:tarek_agro/view/home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AppLocalization locale = AppLocalization.of(context);
    var loginProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.height * .1),
                        left: 48,
                        right: 48,
                        bottom: (MediaQuery.of(context).size.height * .1)),
                    height: (MediaQuery.of(context).size.height * .25),
                    child: Image.asset('images/logo.png'),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 24, right: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: usernameController,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                                labelText:
                                    locale.translate("username") ?? "username",
                                labelStyle: const TextStyle(color: Colors.grey),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: BorderStyle.solid))),
                            onChanged: (username) {
                              loginProvider.setUsername(username);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            obscureText: loginProvider.isPasswordHidden,
                            controller: passwordController,
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            validator: (String? value) {
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText:
                                  locale.translate("password") ?? "password",
                              labelStyle: const TextStyle(color: Colors.grey),
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                    style: BorderStyle.solid),
                              ),
                              suffixIcon: InkWell(
                                onTap: loginProvider.togglePassword,
                                child: Icon(
                                  loginProvider.isPasswordHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            onChanged: (password) {
                              loginProvider.setPassword(password);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 24, right: 24.0, bottom: 24, top: 24),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            child: Center(
                              child: Text(locale.translate("login") ?? "Login"),
                            ),
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.only(top: 16, bottom: 16),
                                primary: loginProvider.isValidInputs()
                                    ? ColorsUtils.secondary
                                    : ColorsUtils.secondaryAlpha,
                                onPrimary: Colors.white,
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            onPressed: loginProvider.isValidInputs()
                                ? () {
                                    login(loginProvider, locale, context);
                                  }
                                : null,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void login(AuthenticationProvider loginProvider, AppLocalization locale,
      BuildContext context) {
    showLoadingDialog(context);
    loginProvider.login()?.then((userCredential) {
      Navigator.pop(context);
      if (userCredential?.user?.uid != null) {
        navigateToHome(context);
      } else {
        showAlertDialog(context,
            title: locale.translate("unAuthorizedError"),
            message: locale.translate("unAuthorizedUserMessage"));
      }
    });
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }
}
