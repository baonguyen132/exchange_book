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
import '../../widget/pagination.dart';
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

  Future<void> _pickImageWithLoading(ImageSource source) async {
    final cubit = context.read<ProductCubit>();
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) return;

    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 44,
                  height: 44,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Đang tìm kiếm sách...',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Vui lòng chờ trong giây lát',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      await cubit.scanPickedImage(File(pickedFile.path), widget.userdata.id!);
    } finally {
      if (mounted && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductCubit>().loadData(int.parse(widget.userdata.id!));
  }

  Widget getWidget(ProductState state) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (state.page == "list") {
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
            // Header card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isDark ? cs.surface : Colors.white,
                border: Border.all(color: cs.onSurface.withOpacity(0.06)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: cs.primary.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.storefront_rounded, color: cs.primary, size: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Danh sách sản phẩm',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.3,
                                  fontSize: 20)),
                          const SizedBox(height: 4),
                          Text('Tìm nhanh sách theo tên hoặc hình ảnh',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: cs.onSurface.withOpacity(0.55))),
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Search row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: cs.onSurface.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: cs.onSurface.withOpacity(0.06)),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 14),
                              Icon(Icons.search_rounded, color: cs.onSurface.withOpacity(0.4), size: 22),
                              const SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (v) =>
                                      setState(() => _searchQuery = v),
                                  textInputAction: TextInputAction.search,
                                  decoration: InputDecoration(
                                    hintText: 'Tìm kiếm theo tên sách...',
                                    hintStyle: TextStyle(color: cs.onSurface.withOpacity(0.4)),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              if (_searchQuery.isNotEmpty)
                                IconButton(
                                  icon: Icon(Icons.close_rounded, size: 18, color: cs.onSurface.withOpacity(0.5)),
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
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () => _pickImageWithLoading(ImageSource.gallery),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cs.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 0,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.photo_camera_outlined, color: Colors.white, size: 20),
                              SizedBox(width: 8),
                              Text('Ảnh', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Empty state
            if (products.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: cs.primary.withOpacity(0.06),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.search_off_rounded,
                          size: 44, color: cs.onSurface.withOpacity(0.3)),
                    ),
                    const SizedBox(height: 16),
                    Text('Không tìm thấy sản phẩm',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text('Hãy thử từ khoá khác hoặc tìm bằng hình ảnh',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: cs.onSurface.withOpacity(0.5))),
                    const SizedBox(height: 18),
                    ElevatedButton.icon(
                      onPressed: () => _pickImageWithLoading(ImageSource.gallery),
                      icon: const Icon(Icons.photo_camera_outlined),
                      label: const Text('Tìm bằng ảnh'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 0,
                      ),
                    )
                  ],
                ),
              )
            else
              // Products grid
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  spacing: 12,
                  runSpacing: 8,
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

              const SizedBox(height: 20),

              products.isNotEmpty || context.read<ProductCubit>().state.currentPage > 1 ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Pagination(
                            back: () {if(context.read<ProductCubit>().state.currentPage != 1) {context.read<ProductCubit>().change("-", int.parse(widget.userdata.id!));}},
                            next: () {if(context.read<ProductCubit>().state.listProduct.isNotEmpty){context.read<ProductCubit>().change("+", int.parse(widget.userdata.id!));}},
                            indexCurrent: context.read<ProductCubit>().state.currentPage
                        ),],
                      )
                  ),
                ],
              ):Container(),


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
    final cs = Theme.of(context).colorScheme;

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 40, height: 40, child: CircularProgressIndicator(strokeWidth: 3, color: cs.primary)),
                const SizedBox(height: 14),
                Text('Đang tải...', style: TextStyle(color: cs.onSurface.withOpacity(0.5), fontSize: 13)),
              ],
            ),
          );
        } else {
          return Scaffold(
              body: getWidget(state),
              floatingActionButton: FloatingActionButton(
                backgroundColor: cs.primary,
                tooltip: state.page == "list" ? 'Giỏ hàng' : 'Quay lại',
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Icon(
                    state.page == "list"
                        ? Icons.shopping_cart_rounded
                        : Icons.arrow_back_rounded,
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
