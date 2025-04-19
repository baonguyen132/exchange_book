import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_admin/model/BookModal.dart';
import 'package:project_admin/screens/dashboard/page/card_detail.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/best_item.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/detail/widget_item_product.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/product_item.dart';
import 'package:project_admin/screens/dashboard/page/widget/product/detail/widget_button_card_detail_of_product.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List<dynamic>? list_product ;
  int state = 0 ;
  late List<dynamic> data ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData() ;
  }

  void loadData() async {
    List<dynamic> data = await BookModal.exportBook() ;
    setState(() {
      list_product = data ;
    });
  }

  Widget getWidget() {
    if(state == 0) {
      return ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 450,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                if(list_product != null)
                  for(int i = 0 ; i < min(list_product!.length, 10) ; i++)
                    ProductItem(
                      item: list_product![i],
                      openItem: (item) {
                        setState(() {
                          state = 1 ;
                          data = item ;
                        });
                      },
                    )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                if(list_product != null)
                  for(int i = 0 ; i < list_product!.length ; i++)
                    BestItem(
                      item: list_product![i],
                      openItem: (item) {
                        setState(() {
                          state = 1 ;
                          data = item ;
                        });
                      },)

              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
          )
        ],
      );
    }
    else if(state == 1) {
      return SingleChildScrollView(
        child: CardDetail(
          item: data,
          wigetHasListButton: WidgetButtonCardDetailOfProduct(change: () {

          },),
          titleRight: 'Danh sách sản phẩm',
          list: LayoutBuilder(builder: (context, constraints) => Column(
            children: [
              if(list_product != null)
                for(int i = 0 ; i < list_product!.length ; i++)
                  WidgetItemProduct(
                    width: constraints.maxWidth,
                    item: list_product?[i],
                    openItem: (item) {
                      setState(() {
                        data = item ;
                      });
                    },
                  )
            ],
          ),),

        ),
      ) ;
    }
    else {
      return Container();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getWidget(),
      floatingActionButton: state != 0 ? FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
        child: Icon(state == 0 ? Icons.add : Icons.rotate_left , size: 25,),
        onPressed: () {
          setState(() {
            if(state == 1 || state == 2) {
              state = 0 ;
            }
            else if(state == 0) {
              state = 1 ;
            }

          });
        },
      ) : null
    );
  }
}
