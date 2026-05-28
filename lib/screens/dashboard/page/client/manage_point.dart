import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/model/transaction_modal.dart';
import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/screens/dashboard/page/client/add_point.dart';
import 'package:exchange_book/screens/dashboard/page/client/cubit/add_point/add_point_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage_point/header.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage_point/search_section.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage_point/transfer_button.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage_point/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/pagination.dart';
import 'cubit/manage_point/manage_point_cubit.dart';

class ManagePoint extends StatefulWidget {
  final UserModel userModel;
  const ManagePoint({super.key, required this.userModel});

  @override
  State<ManagePoint> createState() => _ManagePointState();
}

class _ManagePointState extends State<ManagePoint> {
  late ManagePointCubit managePointCubit;

  @override
  void initState() {
    super.initState();
    managePointCubit = ManagePointCubit();
    managePointCubit.loading(int.parse(widget.userModel.id.toString()));
  }

  @override
  void dispose() {
    managePointCubit.close();
    super.dispose();
  }


  void _handleTransfer(String address, int point) {
    TransactionModel.transfer(
      address: address,
      point: point,
      idUser: widget.userModel.id.toString(),
      successful: (message, point) async {
        UserModel.savePointData(int.parse(point));
        toast(message);
      },
      fail: () {
        toast("Chuyển tiền thất bại. Vui lòng thử lại.");
      },
    );
  }

  Widget _buildUsersList(List<dynamic> filteredList, int point) {
    return Column(children: filteredList.map((userData) {
      return UserCard(
        userData: userData,
        point: (point/filteredList.length).toInt(),
      );
    }).toList(),);
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocBuilder<ManagePointCubit, ManagePointState>(
        bloc: managePointCubit,
        builder: (context, state) {
          return managePointCubit.state.maybeWhen(
            orElse: () => _buildLoadingState(),
            loaded: (page, list, address, point) {

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Header(
                      userModel: widget.userModel,
                      back: () {
                        Navigator.pop(context , true);
                      },
                    ),
                    SearchSection(
                      pointOnePerson: (point/list.length).toInt(),
                      address: address,
                      exchangeAddress: (address) => managePointCubit.exchangeAddress(address),
                      exchangePoint: (value) =>  managePointCubit.exchangePoint(value),
                    ),
                    const SizedBox(height: 8),
                    TransferButton(
                      handleClick: () {
                        if(point > 0) {
                          _handleTransfer(address, point);
                          return ;
                        }
                        managePointCubit.searchUser(int.parse(widget.userModel.id!));

                      },
                      title: point > 0 ? "Chuyển tiền" : "Search" ,
                      icon: point > 0 ? Icons.send_rounded: Icons.search ,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          _buildUsersList(list, point),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 48,
                                child: Pagination(
                                  indexCurrent: page,
                                  back: () {if(page != 1) {managePointCubit.change("-", int.parse(widget.userModel.id.toString()));}},
                                  next: () {if(list.isNotEmpty){managePointCubit.change("+",int.parse(widget.userModel.id.toString()));}},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30,)
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPoint(userModel: widget.userModel),
            ),
          );
        },
        icon: const Icon(Icons.add_rounded, size: 24),
        label: const Text(
          "Nạp tiền",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
