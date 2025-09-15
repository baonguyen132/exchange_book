import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/model/transaction_modal.dart';
import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/screens/dashboard/page/client/add_point.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage_point/header.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage_point/search_section.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage_point/transfer_button.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage_point/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/manage_point/manage_point_cubit.dart';

class ManagePoint extends StatefulWidget {
  final UserModel userModel;
  const ManagePoint({super.key, required this.userModel});

  @override
  State<ManagePoint> createState() => _ManagePointState();
}

class _ManagePointState extends State<ManagePoint> {
  late ManagePointCubit addPointCubit;

  @override
  void initState() {
    super.initState();
    addPointCubit = ManagePointCubit();
    addPointCubit.loading();
  }

  @override
  void dispose() {
    addPointCubit.close();
    super.dispose();
  }

  bool _isUserInFilteredList(List<int> listId, int userId) {
    return listId.contains(userId);
  }

  void _handleTransfer(List<int> listId, int totalPoint) {
    TransactionModel.transfer(
      listId: listId.join("_"),
      totalPoint: totalPoint,
      idUser: widget.userModel.id.toString(),
      successful: () {
        toast("Chuyển tiền thành công!");
      },
      fail: () {
        toast("Chuyển tiền thất bại. Vui lòng thử lại.");
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            "Không tìm thấy người dùng",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Hãy thử điều chỉnh tiêu chí tìm kiếm",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersList(List<dynamic> filteredList, int totalPoint) {
    if (filteredList.isEmpty) {
      return _buildEmptyState();
    }

    final pointPerUser = (totalPoint / filteredList.length).round();

    return Column(
      children: filteredList.map((userData) {
        return UserCard(
          userData: userData,
          point: pointPerUser,
        );
      }).toList(),
    );
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
        bloc: addPointCubit,
        builder: (context, state) {
          return addPointCubit.state.maybeWhen(
            orElse: () => _buildLoadingState(),
            loaded: (list, listId, totalPoint) {
              final filteredList = listId.isNotEmpty
                  ? list
                      .where((element) =>
                          _isUserInFilteredList(listId, element[0]))
                      .toList()
                  : list;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Header(userModel: widget.userModel),
                    SearchSection(
                      pointOnePerson:
                          (totalPoint / filteredList.length).round(),
                      exchangeListId: (address) =>
                          addPointCubit.exchangeListId(address),
                      exchangeListPoint: (value) =>
                          addPointCubit.exchangeListPoint(value),
                    ),
                    const SizedBox(height: 8),
                    TransferButton(
                      handleClick: () => _handleTransfer(listId, totalPoint),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildUsersList(filteredList, totalPoint),
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
