import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:innovins_tech/const/app_colors.dart';
import 'package:innovins_tech/const/app_lists.dart';
import 'package:innovins_tech/const/assets.dart';
import 'package:innovins_tech/const/spacing.dart';
import 'package:innovins_tech/controller/home_controller.dart';
import 'package:innovins_tech/views/product_detail_screen/product_detail_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static String id = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    var fixheight = MediaQuery.of(context).size.height;
    var fixwidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SizedBox(
          width: double.infinity,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // background image
              Positioned(
                right: -5.w,
                child: Image.asset(
                  Assets.bgImage,
                  scale: 1.8,
                ),
              ),
              Padding(
                padding: Spacing.screenPadding,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacing.heightBox(100),
                      Text(
                        "Vegetables",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24.sp),
                      ),
                      Spacing.heightBox(25),

                      // search field
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            size: 25.sp,
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(color: AppColors.greyColor),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 12.h),
                          fillColor: AppColors.whiteColor,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.greyColor),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.greenColor),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ),
                      Spacing.heightBox(16),
                      // suggestions
                      Consumer<HomeController>(
                          builder: (context, controller, _) {
                        return Wrap(
                          spacing: 8,
                          children: List.generate(
                              AppLists.categoriesList.length, (index) {
                            return ChoiceChip(
                              selectedColor:
                                  AppColors.greenColor.withOpacity(0.3),
                              shape: StadiumBorder(),
                              label: Text("${AppLists.categoriesList[index]}"),
                              selected: controller.selectedIndex == index,
                              onSelected: (bool selected) {
                                controller.UpdateSelectionIndex =
                                    selected ? index : controller.selectedIndex;
                              },
                            );
                          }),
                        );
                      }),
                      Spacing.heightBox(25),
                      // products
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () {
                                  context.goNamed(ProductDetailScreen.id);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 15.w),
                                        child: Image.asset(
                                          AppLists.imageList[0],
                                          fit: BoxFit.fitWidth,
                                          height: fixheight * 0.15,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Boston Letuce",
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: fixheight * 0.01,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: "1234",
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: " € / piece",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w200,
                                                        fontSize: 16.sp)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: fixheight * 0.038,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: AppColors.whiteColor,
                                                    border: Border.all(
                                                        color: AppColors
                                                            .greyColor
                                                            .withOpacity(0.5))),
                                                width: fixwidth * 0.18,
                                                height: fixheight * 0.04,
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Icon(
                                                    Icons.delete_rounded,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              Spacing.widthBox(10),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: AppColors.greenColor,
                                                ),
                                                width: fixwidth * 0.18,
                                                height: fixheight * 0.04,
                                                child: Icon(
                                                  Icons.shopping_cart_outlined,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
