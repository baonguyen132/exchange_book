import 'package:exchange_book/data/ConstraintData.dart';
import 'package:exchange_book/model/transaction_modal.dart';
import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/screens/dashboard/page/client/add_point.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/manage_point/table.dart';
import 'package:exchange_book/theme/theme.dart';
import 'package:exchange_book/util/widget_text_field_custom.dart';
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
  late TextEditingController searchController;
  late TextEditingController pointController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
    pointController = TextEditingController();
    context.read<ManagePointCubit>().loading();
  }

  bool show(List<int> listId, id) {
    if (listId.contains(id)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ManagePointCubit, ManagePointState>(
        builder: (context, state) {
          return context.read<ManagePointCubit>().state.maybeWhen(
                orElse: () => const Center(child: CircularProgressIndicator()),
                loaded: (list, listId, listPoint) => LayoutBuilder(
                  builder: (context, constraints) {
                    print("listId : $listId");
                    print("listPoint : $listPoint");
                    // Lọc danh sách theo listId nếu có, đồng thời hiển thị listPoint nếu có
                    final filteredList = listId.isNotEmpty
                        ? list
                            .where((element) => show(listId, element[0]))
                            .toList()
                        : list;

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          WidgetTextFieldCustom(
                            controller: searchController,
                            textInputType: TextInputType.text,
                            hint: "ID",
                            iconData: Icons.search,
                            onChange: (value) {
                              context
                                  .read<ManagePointCubit>()
                                  .exchangeListId(value);
                            },
                          ),
                          const SizedBox(height: 10),
                          WidgetTextFieldCustom(
                            controller: pointController,
                            textInputType: TextInputType.text,
                            hint: "Point",
                            iconData: Icons.control_point,
                            onChange: (value) {
                              context
                                  .read<ManagePointCubit>()
                                  .exchangeListPoint(value);
                            },
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              TransactionModel.transfer(listId: listId.join("_"), listPoint: listPoint.join("_"), idUser: widget.userModel.id.toString(),
                                  successful: () {
                                    toast("Chuyen diem thanh cong");
                                  },
                                  fail: () {

                                  },
                              );
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: const Text(
                                  "Gửi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.white
                                  ),
                                ),

                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Hiển thị listPoint nếu có
                          if (listPoint.isNotEmpty)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.yellow[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Danh sách Point: ${listPoint.join(', ')}",
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: constraints.maxWidth,
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                      (states) => Colors.blue,
                                    ),
                                    columnSpacing: 24,
                                    dataRowHeight: 60,
                                    headingRowHeight: 60,
                                    columns: const [
                                      DataColumn(label: Text("ID")),
                                      DataColumn(label: Text("Name")),
                                      DataColumn(label: Text("Email")),
                                      DataColumn(label: Text("Point")),
                                    ],
                                    rows: filteredList.asMap().entries.map(
                                      (entry) {
                                        final index = entry.key;
                                        final e = entry.value;
                                        int point = 0;
                                        if(listPoint.isNotEmpty && listPoint.length >= index + 1) {
                                          point = listPoint[index] ;
                                        }
                                        return rowData(
                                            e,
                                            Theme.of(context)
                                                .colorScheme
                                                .maintext,
                                            point
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPoint(
                  userModel: widget.userModel,
                ),
              ));
        },
        child: Icon(
          Icons.add,
          size: 25,
          color: Theme.of(context).colorScheme.maintext,
        ),
      ),
    );
  }
}
