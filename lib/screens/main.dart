import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eatit/model/restaurant_model.dart';
import 'package:flutter_eatit/screens/restaurant_home.dart';
import 'package:flutter_eatit/state/main_state.dart';
import 'package:flutter_eatit/strings/main_strings.dart';
import '../view_model/main_view/main_view_model_imp.dart';
import 'package:flutter_eatit/widgets/common/common_widgets.dart';
import 'package:flutter_eatit/widgets/main/main_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  runApp(MyApp(app: app));
}

class MyApp extends StatelessWidget {
  final FirebaseApp app;

  MyApp({required this.app});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(app: app),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final FirebaseApp app;
  final viewModel = MainViewModelImp();
  final mainStateController = Get.put(MainStateController());

  MyHomePage({required this.app});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurantText,
          style: GoogleFonts.jetBrainsMono(
              fontWeight: FontWeight.w900, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 10,
      ),
      body: FutureBuilder(
        future: viewModel.displayRestaurantList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var lst = snapshot.data as List<RestaurantModel>;
            return Container(
              margin: const EdgeInsets.only(top: 10),
              child: LiveList(
                showItemDuration: Duration(milliseconds: 350),
                showItemInterval: Duration(milliseconds: 150),
                reAnimateOnVisibility: true,
                scrollDirection: Axis.vertical,
                itemCount: lst.length,
                itemBuilder: animationItemBuilder((index) => InkWell(
                      onTap: () {
                        mainStateController.selectedRestaurant.value =
                            lst[index];
                        Get.to(() => RestaurantHome());
                      },
                      child: Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 2.5 * 1.1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RestaurantImageWidget(
                                imageUrl: lst[index].imageUrl),
                            RestaurantInfoWidget(
                                name: lst[index].name,
                                address: lst[index].address)
                          ],
                        ),
                      ),
                    )),
              ),
            );
          }
        },
      ),
    );
  }
}
