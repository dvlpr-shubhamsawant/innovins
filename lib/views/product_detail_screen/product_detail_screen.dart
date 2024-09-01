import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:innovins_tech/const/app_colors.dart';
import 'package:innovins_tech/const/assets.dart';
import 'package:innovins_tech/const/spacing.dart';
import 'package:innovins_tech/models/data_wrapper.dart';
import 'package:innovins_tech/models/product_data_model.dart';
import 'package:innovins_tech/views/home.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({super.key, required this.data});
  static String id = "ProductDetailScreen";

  DataWrapper data;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    var fixheight = MediaQuery.of(context).size.height;
    var fixwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Stack(
              children: [
                PageView(
                  key: GlobalKey<NavigatorState>(),
                  onPageChanged: (value) {
                    setState(() {
                      selectedImage = value;
                    });
                  },
                  children: [
                    Image(
                      fit: BoxFit.cover,
                      image: AssetImage(widget.data.image),
                    ),
                    Image(
                      fit: BoxFit.cover,
                      image: AssetImage(widget.data.image),
                    ),
                    Image(
                      fit: BoxFit.cover,
                      image: AssetImage(widget.data.image),
                    ),
                  ],
                ),
                Positioned(
                  top: fixheight * 0.26,
                  left: fixwidth * 0.4,
                  child: SizedBox(
                    width: fixwidth * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(3, (index) {
                        return CircleAvatar(
                          backgroundColor: selectedImage == index
                              ? AppColors.redColor
                              : AppColors.greyColor,
                          radius: 6.r,
                        );
                      }),
                    ),
                  ),
                ),
                Positioned(
                  left: 20.w,
                  top: 40.h,
                  child: GestureDetector(
                    onTap: () {
                      context.goNamed(Home.id);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            height: MediaQuery.of(context).size.height * 0.8,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: fixheight * 0.03,
                ),
                Text(
                  "${widget.data.productDataModel.name}",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: fixheight * 0.02,
                ),
                RichText(
                  text: TextSpan(
                    text: "${widget.data.productDataModel.discountedPrice}",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: " € / piece",
                          style: TextStyle(
                              fontWeight: FontWeight.w200, fontSize: 16.sp)),
                    ],
                  ),
                ),
                SizedBox(
                  height: fixheight * 0.018,
                ),
                RichText(
                  text: TextSpan(
                    text: "~ ${widget.data.productDataModel.moq}",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.greenColor),
                    children: <TextSpan>[
                      TextSpan(
                          text: " gr / Piece",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.sp)),
                    ],
                  ),
                ),
                SizedBox(
                  height: fixheight * 0.03,
                ),
                Text(
                  "Spain",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 26.sp),
                ),
                SizedBox(
                  height: fixheight * 0.03,
                ),
                Text(
                  "Lettuce is an annual plant of the daisy family, Asteraceae. It is most often grown as a leaf vegetable, but sometimes for its stem and seeds. Lettuce is most often used for salads, although it is also seen in other kinds of food, such as soups, sandwiches and wraps; it can also be grilled.",
                  style: TextStyle(fontSize: 15.sp, color: AppColors.greyColor),
                ),
                SizedBox(
                  height: fixheight * 0.12,
                ),
                Row(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.whiteColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.grey,
                            ),
                          ],
                        )),
                    Spacing.widthBox(14),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.66,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppColors.greenColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                            Spacing.widthBox(10),
                            Text(
                              "ADD TO CART",
                              style: TextStyle(color: AppColors.whiteColor),
                            )
                          ],
                        )),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
