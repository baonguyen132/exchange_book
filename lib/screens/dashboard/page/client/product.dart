import 'dart:io';
import 'dart:math';

import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/main.dart';
import 'package:exchange_book/screens/dashboard/page/client/cubit/product/product_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/product/best_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:exchange_book/model/book_modal.dart';
import 'package:exchange_book/model/detail_cart_modal.dart';
import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/screens/dashboard/page/client/card_detail.dart';

import 'package:exchange_book/theme/theme.dart';

import '../../../../model/cart_modal.dart';
import 'cart.dart';

class Product extends StatefulWidget {
  final UserModel userdata;
  const Product({super.key, required this.userdata});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  // 0 -> list
  // 1 -> detail
  // 2 -> cart

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductCubit>().loadData(widget.userdata.id.toString());
  }

  Widget getWidget(ProductState state) {
    if (state.page == "list") {
      // Redesigned header: title + search bar + image-search; list filtered locally
      final products = state.listProduct.where((p) {
        final title =
            (p.length > 1 ? p[1]?.toString() ?? '' : '').toLowerCase();
        final q = _searchQuery.trim().toLowerCase();
        return q.isEmpty || title.contains(q);
      }).toList();

      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card with improved search UX (flat, no shadow)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(
                  color: Theme.of(context).dividerColor.withOpacity(0.08),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Danh sách sản phẩm',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.maintext)),
                  const SizedBox(height: 6),
                  Text('Tìm nhanh sách theo tên, hoặc tìm bằng hình ảnh',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.black54)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3))
                            ],
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              const Icon(Icons.search_outlined,
                                  color: Colors.grey),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (v) =>
                                      setState(() => _searchQuery = v),
                                  textInputAction: TextInputAction.search,
                                  decoration: const InputDecoration(
                                    hintText: 'Tìm kiếm theo tên sách...',
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              if (_searchQuery.isNotEmpty)
                                IconButton(
                                  icon: const Icon(Icons.clear, size: 20),
                                  onPressed: () => setState(() {
                                    _searchQuery = '';
                                    _searchController.clear();
                                  }),
                                ),
                              const SizedBox(width: 6),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 46,
                        child: ElevatedButton.icon(
                          onPressed: () => context
                              .read<ProductCubit>()
                              .pickImage(
                                  ImageSource.gallery, widget.userdata.id!),
                          icon: const Icon(Icons.photo_camera_outlined , color: Colors.white,),
                          label: const Text('Ảnh' , style: TextStyle(color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Empty state when no products match
            if (products.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 48),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search_off,
                        size: 48, color: Colors.grey.shade400),
                    const SizedBox(height: 12),
                    Text('Không tìm thấy sản phẩm',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text('Hãy thử từ khoá khác hoặc tìm bằng hình ảnh',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black54)),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => context
                          .read<ProductCubit>()
                          .pickImage(ImageSource.gallery, widget.userdata.id!),
                      icon: const Icon(Icons.photo_camera_outlined),
                      label: const Text('Tìm bằng ảnh'),
                    )
                  ],
                ),
              )
            else
              // Products grid/wrap centered
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 12,
                  runSpacing: 12,
                  children: List.generate(products.length, (i) {
                    final item = products[i];
                    return BestItem(
                      item: item,

                      openItem: (item,) =>
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardDetail(
                                    item: item,
                                    list: state.listProduct,
                                ),
                              )
                          ),
                      order: (bookModal, nameBook) {
                        toast("Đã thêm vào giỏ hàng");
                        DetailCartModal.saveDetail(
                          bookModal.id.toString(),
                          bookModal.id_user.toString(),
                          DetailCartModal(
                              bookModal: bookModal,
                              quantity: 1,
                              nameBook: nameBook),
                        );
                      },
                    );
                  }),
                ),
              ),

            const SizedBox(height: 40),
          ],
        ),
      );
    }  else {
      return Cart(
        userModel: widget.userdata,
        handleInsert: (data, address, totalText, total, path) {
          CartModal.uploadCart(
            data,
            address,
            totalText,
            path,
            widget.userdata.id.toString(),
            () {
              toast("Đăng kí giỏ hàng thành công");
            },
            () {
              toast("Đăng kí giỏ hàng không thành công");
            },
          );
          widget.userdata.point = "${int.parse(widget.userdata.point) - total}";
          UserModel.saveUserData(widget.userdata);

          DetailCartModal.removeDetailCartData();
          context.read<ProductCubit>().back();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Scaffold(
              body: getWidget(state),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                tooltip: state.page == "list" ? 'Giỏ hàng' : 'Quay lại',
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Icon(
                    state.page == "list"
                        ? Icons.shopping_cart
                        : Icons.rotate_left,
                    size: 24,
                    color: Colors.white),
                onPressed: () {
                  context.read<ProductCubit>().handleFloatingButton();
                },
              ));
        }
      },
    );
  }
}
