import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:innovins_tech/const/app_colors.dart';
import 'package:innovins_tech/const/app_lists.dart';
import 'package:innovins_tech/const/assets.dart';
import 'package:innovins_tech/const/name_const.dart';
import 'package:innovins_tech/const/spacing.dart';
import 'package:innovins_tech/controller/home_controller.dart';
import 'package:innovins_tech/models/data_wrapper.dart';
import 'package:innovins_tech/services/hive_service.dart';
import 'package:innovins_tech/views/product_detail_screen/product_detail_screen.dart';
import 'package:innovins_tech/views/shared_widget/toast.dart';
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            openBottomSheet(context);
          },
        ),
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
                      Consumer<HomeController>(
                          builder: (context, controller, _) {
                        return controller.isProductLoading == true
                            ? CircularProgressIndicator()
                            : Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(
                                        controller.products!.length, (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          DataWrapper data = DataWrapper(
                                              controller.products![index],
                                              AppLists.imageList[index]);
                                          context.goNamed(
                                              ProductDetailScreen.id,
                                              extra: data);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 30),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    right: 15.w),
                                                child: Image.asset(
                                                  AppLists.imageList[index],
                                                  fit: BoxFit.fitWidth,
                                                  height: fixheight * 0.15,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${controller.products![index].name}",
                                                    style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: fixheight * 0.01,
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text:
                                                          "${controller.products![index].discountedPrice}",
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: " € / piece",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                                fontSize:
                                                                    16.sp)),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: fixheight * 0.038,
                                                  ),
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          var token =
                                                              await HiveService()
                                                                  .getData(
                                                                      NameConst
                                                                          .key);
                                                          await controller
                                                              .deleteProduct(
                                                                  token: token,
                                                                  id: controller
                                                                      .products![
                                                                          index]
                                                                      .id);
                                                          if (controller
                                                                  .products!
                                                                  .length >
                                                              1) {
                                                            controller
                                                                .fetchAllProducts(
                                                                    token);
                                                          } else {
                                                            flutterToast(
                                                                context,
                                                                "Minimum One Product will be remain");
                                                          }
                                                        },
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      5),
                                                              color: AppColors
                                                                  .whiteColor,
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .greyColor
                                                                      .withOpacity(
                                                                          0.5))),
                                                          width:
                                                              fixwidth * 0.18,
                                                          height:
                                                              fixheight * 0.04,
                                                          child: Icon(
                                                            Icons
                                                                .delete_rounded,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                      Spacing.widthBox(10),
                                                      GestureDetector(
                                                        onTap: () {
                                                          updateProductSheet(
                                                              context,
                                                              controller
                                                                      .products![
                                                                  index]);
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: AppColors
                                                                .greenColor,
                                                          ),
                                                          width:
                                                              fixwidth * 0.18,
                                                          height:
                                                              fixheight * 0.04,
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: Colors.white,
                                                          ),
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
                              );
                      })
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

  void openBottomSheet(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController moq = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController dPrice = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  label: Text("Product Name"),
                ),
              ),
              Spacing.heightBox(10),
              TextFormField(
                controller: moq,
                decoration: InputDecoration(label: Text("MOQ")),
              ),
              Spacing.heightBox(10),
              TextFormField(
                controller: price,
                decoration: InputDecoration(label: Text("Price")),
              ),
              Spacing.heightBox(10),
              TextFormField(
                controller: dPrice,
                decoration: InputDecoration(label: Text("Discounted Price")),
              ),
              Spacing.heightBox(20),
              FilledButton(
                onPressed: () async {
                  var token = await HiveService().getData(NameConst.key);
                  var data = {
                    "user_login_token": token,
                    "name": name.text,
                    "moq": moq.text,
                    "price": price.text,
                    "discounted_price": dPrice.text
                  };

                  var controller =
                      Provider.of<HomeController>(context, listen: false);
                  await controller.addProduct(data, token);
                  Navigator.pop(context);
                  await controller.fetchAllProducts(token);
                },
                child: Text("Add Product"),
              ),
              Spacing.heightBox(20),
            ],
          ),
        );
      },
    );
  }

  void updateProductSheet(BuildContext context, productInfo) {
    TextEditingController name = TextEditingController();
    TextEditingController moq = TextEditingController();
    TextEditingController price = TextEditingController();
    TextEditingController dprice = TextEditingController();

    name.text = productInfo.name;
    moq.text = productInfo.moq;
    price.text = productInfo.price;
    dprice.text = productInfo.discountedPrice;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  label: Text("Product Name"),
                ),
              ),
              Spacing.heightBox(10),
              TextFormField(
                controller: moq,
                decoration: InputDecoration(
                  label: Text("MOQ"),
                ),
              ),
              Spacing.heightBox(10),
              TextFormField(
                controller: price,
                decoration: InputDecoration(
                  label: Text("Price"),
                ),
              ),
              Spacing.heightBox(10),
              TextFormField(
                controller: dprice,
                decoration: InputDecoration(
                  label: Text("Discounted Price"),
                ),
              ),
              Spacing.heightBox(20),
              FilledButton(
                onPressed: () async {
                  var controller =
                      Provider.of<HomeController>(context, listen: false);
                  var token = await HiveService().getData(NameConst.key);
                  var data = {
                    "user_login_token": token,
                    "name": name.text,
                    "moq": moq.text,
                    "price": price.text,
                    "discounted_price": dprice.text,
                    "id": productInfo.id
                  };
                  await controller.editProduct(data, token);
                  await controller.fetchAllProducts(token);
                  Navigator.pop(context);
                },
                child: Text("Update Product"),
              ),
            ],
          ),
        );
      },
    );
  }
}
