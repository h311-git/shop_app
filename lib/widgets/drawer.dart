import 'package:flutter/material.dart';
import '../pages/product_edit_page.dart';

class DrawerWidget extends StatelessWidget {
  Widget buildDrawerSection(
    IconData icon,
    String title,
    Function onTapFunction,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.yellow,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      trailing: Container(
        child: Icon(Icons.arrow_forward_ios),
        margin: EdgeInsets.only(right: 20),
      ),
      onTap: onTapFunction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      margin: EdgeInsets.only(top: 50),
      child: Drawer(
        child: Column(
          children: [
            Container(
                height: 250,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                alignment: Alignment.center,
                child: ListTile(
                  leading: Icon(
                    Icons.shopping_bag,
                    size: 50,
                  ),
                  title: FittedBox(
                    child: Text(
                      "Welcome To The Shop",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            buildDrawerSection(Icons.dashboard, "Dashboard", () {
              Navigator.of(context).pushReplacementNamed('/');
            }),
            Divider(
              thickness: 0.7,
            ),
            buildDrawerSection(Icons.edit, "Add Product", () {
              Navigator.of(context).pushReplacementNamed(ProductEdit.routeName);
            }),
          ],
        ),
      ),
    );
  }
}
