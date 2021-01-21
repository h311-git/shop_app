import 'package:flutter/material.dart';
import '../widgets/login.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: deviceSize.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                    "assets/images/shop_image.png",
                  )),
                  shape: BoxShape.rectangle,
                  color: Colors.pink,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(100))),
            ),
            Login(deviceSize: deviceSize.height - deviceSize.height * 0.3),
          ],
        ),
      ),
    );
  }
}
