import 'package:lkarnet/const/constents.dart';
import 'package:lkarnet/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:lkarnet/widgets/glasswidget.dart';

class SplashPage extends StatelessWidget {
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
      centerWidget: Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 320,
          height: 320,
          child: BluredContainer(
            start: 0.2,
            end: 0.15,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AppAssets.svgIcon,
                    const SizedBox(height: 30),
                    buildGo(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // Align(
      //   alignment: Alignment.bottomCenter,
      //   child: buildLogoSlogan(context),
      // ),
    );
  }

  Widget buildGo(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      icon: Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
      ),
    );
  }

  Container buildLogoSlogan(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: 120,
      height: 100,
      child: SelectableText(
        'dev.bourheem\n copyright\n 2021',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}

//  Container(
//           height: 100,
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             children: [
//               Text(
//                 'lkarnet',
//               ),
//               Text(
//                 '"Manage your budget & control your spendibgs"',
//                 style: Theme.of(context).textTheme.subtitle2,
//               ),
//             ],
//           ),
//         ),

//  Container(
//                 alignment: Alignment.topLeft,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                     colors: [
//                       Color(0xB60A3E82),
//                       Color(0xD8de08c9),
//                       Color(0xD8de08c9),
//                       Color(0xD8de08c9),
//                     ],
//                   ),
//                 ),
//               ),