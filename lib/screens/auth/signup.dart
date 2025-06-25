import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lkarnet/blocs/signupbloc/signup_bloc.dart';
import 'package:lkarnet/services/auth_service.dart';
import 'package:lkarnet/settings/theme.dart';
import 'package:lkarnet/components.dart';
import 'package:flutter/material.dart';

import '../../blocs/authbloc/auth_bloc.dart';
import '../../models/login_credentials.dart';
import 'login.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(
        BlocProvider.of<AuthBloc>(context),
        GetIt.I.get<AuthService>(),
      ),
      child: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _registerFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  var _isLoading = false;
  var _obscPass = true;
  var _obscConfirmPass = true;

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
      centerWidget: GlassContainer(
          child: SizedBox(
              width: 380,
              height: 420,
              child: BlocListener<SignUpBloc, SignUpState>(
                listener: (context, state) {},
                child: BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    return _getWidgetRegistrationCard(context);
                  },
                ),
              ))),
    );
  }

  Widget _getWidgetRegistrationCard(BuildContext context) {
    //final _confirmPass = ref.watch(regConfPasswordProvider.state).state.trim();
    // final _db = ref.watch(databaseProvider);
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _registerFormKey,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    'Register',
                    style: GoogleFonts.sansita(
                      fontSize: 24,
                    ),
                  ),
                ), // title: login
                Container(
                  child: TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    validator: (text) {
                      if (text!.trim().isEmpty) {
                        setState(() {
                          _isLoading = false;
                        });
                        return "Please insert a unique username";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Username',
                        //prefixIcon: Icon(Icons.email),
                        icon: Icon(Icons.perm_identity)),
                  ),
                ), //text field : user name
                Container(
                  child: TextFormField(
                    controller: _emailController,
                    onChanged: (text) {
                      setState(() {
                        _isLoading = false;
                      });
                    },
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
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(_obscPass
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _obscPass = !_obscPass;
                            });
                          },
                        ),
                        icon: Icon(Icons.vpn_key)),
                  ),
                ), //text field: password
                Container(
                  child: TextFormField(
                      controller: _confirmPassController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      validator: (text) {
                        if (text!.trim().isEmpty) {
                          return "Please insert a valid password";
                        } else if (text.trim() != text.trim()) {
                          return "The Passwords dont match !";
                        }
                        return null;
                      },
                      obscureText: _obscConfirmPass,
                      decoration: InputDecoration(
                          labelText: "Confirm Password",
                          suffixIcon: IconButton(
                            icon: Icon(_obscConfirmPass
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscConfirmPass = !_obscConfirmPass;
                              });
                            },
                          ),
                          icon: Icon(Icons.vpn_key))),
                ),
                Container(
                  margin: EdgeInsets.only(top: 32.0),
                  width: 400,
                  height: 45,
                  child: ElevatedButton(
                    style: MThemeData.raisedButtonStyleSave,
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: _isLoading
                        ? null
                        : () {
                            if (_registerFormKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });
                              BlocProvider.of<SignUpBloc>(context).add(
                                SignUpRequestedEvent(
                                  signUpCredentials: SignUpCredentials(
                                    username: _usernameController.text.trim(),
                                    email: _emailController.text.trim(),
                                    password: _passController.text.trim(),
                                  ),
                                ),
                              );
                            }
                          },
                  ),
                ), //button: login
                Container(
                    margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already Registered? ',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        InkWell(
                          splashColor:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            ' Sign in',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
