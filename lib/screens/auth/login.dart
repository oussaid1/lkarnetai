import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/components.dart';
import 'package:flutter/material.dart';

import '../../blocs/loginbloc/login_bloc.dart';
import '../../models/login_credentials.dart';
import '../../utils.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passController = TextEditingController();

  var _isLoading = false;

  var _obscPass = true;

  @override
  Widget build(BuildContext context) {
    return GlassMaterial(
      circleWidgets: [
        Positioned(
          width: 100,
          height: 100,
          left: 10,
          top: 120,
          child: AppAssets.pinkCircleWidget,
        ),
        Positioned(
          width: 180,
          height: 180,
          right: 80,
          top: 200,
          child: AppAssets.purpleCircleWidget,
        ),
        Positioned(
          width: 140,
          height: 140,
          left: 30,
          bottom: 80,
          child: AppAssets.blueCircleWidget,
        ),
      ],
      alignment: Alignment.center,
      centerWidget: BluredContainer(
        width: 380,
        height: 420,
        child: BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            /// check the state and show snackbar using GlobalFunctions according to state
            if (state.status == LoginSattus.loading) {
              GlobalFunctions.showSnackBar(
                context,
                'جاري تسجيل الدخول',
              );
            }
            if (state.status == LoginSattus.error) {
              GlobalFunctions.showSnackBar(
                context,
                state.error,
              );
            }
            if (state.status == LoginSattus.success) {
              GlobalFunctions.showSnackBar(
                context,
                'تم تسجيل الدخول بنجاح',
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Text('Login', style: Theme.of(context).textTheme.displayLarge),
                    const SizedBox(height: 15),
                    _buildLoginForm(context),
                    buildLoginButton(context), //button: lo
                    //  buildsignInwithGoogle(context), //button: login
                    const SizedBox(height: 15),
                    buildDontHaveAccount(context)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _buildLoginForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (text) {
                if (text!.trim().isEmpty) {
                  setState(() {
                    _isLoading = false;
                  });
                  return "Please insert a valid email";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'Email',
                  //prefixIcon: Icon(Icons.email),
                  icon: Icon(Icons.email)),
            ), //text field: email
            TextFormField(
              controller: _passController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: (text) {
                if (text!.trim().isEmpty) {
                  setState(() {
                    _isLoading = false;
                  });
                  return "Please insert a valid password";
                }
                return null;
              },
              obscureText: _obscPass,
              decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscPass ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscPass = !_obscPass;
                      });
                    },
                  ),
                  icon: Icon(Icons.vpn_key)),
            ), //text field: password
          ],
        ),
      ),
    );
  }

  buildForms(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            width: double.infinity,
            child: Text('Login', style: Theme.of(context).textTheme.displayLarge),
          ), // title: login
          SizedBox(height: 20),
          Container(
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: (text) {
                if (text!.trim().isEmpty) {
                  setState(() {
                    _isLoading = false;
                  });
                  return "Please insert a valid email";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: 'Email',
                  //prefixIcon: Icon(Icons.email),
                  icon: Icon(Icons.email)),
            ),
          ), //text field: email
          Container(
            child: TextFormField(
              controller: _passController,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: (text) {
                if (text!.trim().isEmpty) {
                  setState(() {
                    _isLoading = false;
                  });
                  return "Please insert a valid password";
                }
                return null;
              },
              obscureText: _obscPass,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _obscPass ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _obscPass = !_obscPass;
                      });
                    },
                  ),
                  icon: Icon(Icons.vpn_key)),
            ),
          ), //text field: password
        ],
      ),
    );
  }

  buildLoginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: MaterialButton(
        minWidth: 300,
        color: MThemeData.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          'Login',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        onPressed: _isLoading
            ? null
            : () {
                if (_loginFormKey.currentState!.validate()) {
                  setState(() {
                    _isLoading = false;
                  });
                  BlocProvider.of<LoginBloc>(context).add(LoginRequestedEvent(
                      loginCredentials: LoginCredentials(
                          username: _emailController.text,
                          password: _passController.text)));
                }
              },
      ),
    );
  }

  buildDontHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: "Don't have an account? ",
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              TextSpan(
                text: "Sign up",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Theme.of(context).primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildsignInwithGoogle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      width: 300,
      height: 45,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(50)),
      child: InkWell(
        child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                  height: 35, width: 35, child: AppAssets.googleSvgIcon),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                "Sign in with google",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
        onTap: () {
          // _auth.googleSignIn().then((value) => Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => Root()),
          //     ));

          // _auth.signInWithGoogle().then((value) => _auth.createNewUser(UserModel.fromUserCredential(value, value.user!.displayName.toString()) ));
        },
      ),
    );
  }
}
