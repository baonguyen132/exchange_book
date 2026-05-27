import 'package:exchange_book/screens/dashboard/page/manager/cubit/manage/manage_user_cubit.dart';
import 'package:exchange_book/screens/dashboard/widget/pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exchange_book/theme/theme.dart';

class ManageUser extends StatefulWidget {
  const ManageUser({super.key});

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ManageUserCubit>().loading();
  }

  DataColumn cellTitleTable(String title) {
    return DataColumn(
      label: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.3,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  DataCell cellData(String data) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return DataCell(
      Text(
        data,
        style: TextStyle(
          fontSize: 14,
          color: theme.colorScheme.maintext,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  DataRow rowData(List<dynamic> data, int index) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final evenColor = isDark
        ? Colors.white.withOpacity(0.02)
        : Colors.black.withOpacity(0.015);

    return DataRow(
      color: WidgetStateProperty.resolveWith<Color?>(
        (states) => index.isEven ? evenColor : Colors.transparent,
      ),
      cells: [
        cellData(data[0].toString()),
        cellData(data[1]),
        cellData(data[2]),
        data[4] == 5 ? cellData("Admin") : cellData("Client"),
        cellData(data[5].toString()),
        DataCell(
          Container(
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(isDark ? 0.12 : 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(Icons.verified_user, color: Colors.green.shade400, size: 20),
              onPressed: () {
                // xử lý cấp quyền
              },
            ),
          ),
        ),
        DataCell(
          Container(
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(isDark ? 0.12 : 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.red.shade400, size: 20),
              onPressed: () {
                // xử lý xóa
              },
            ),
          ),
        ),
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E2C) : Colors.white;

    return BlocBuilder<ManageUserCubit , ManageUserState>(builder: (context, state) {
      return context.read<ManageUserCubit>().state.maybeWhen(
        orElse: () => Center(
          child: CircularProgressIndicator(color: theme.primaryColor),
        ),
        loaded: (page, list) => LayoutBuilder(
            builder: (context, constraints) => Column(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.04),
                    ),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                        ),
                        child: DataTable(
                          headingRowColor: WidgetStateProperty.resolveWith(
                            (states) => theme.primaryColor,
                          ),
                          columnSpacing: 24,
                          dataRowMinHeight: 56,
                          dataRowMaxHeight: 64,
                          headingRowHeight: 56,
                          horizontalMargin: 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          columns: [
                            cellTitleTable("ID"),
                            cellTitleTable("Name"),
                            cellTitleTable("Email"),
                            cellTitleTable("Position"),
                            cellTitleTable("CID"),
                            cellTitleTable("Grant"),
                            cellTitleTable("Delete"),
                          ],
                          rows: List.generate(list.length, (index) {
                            return rowData(list[index], index) ;
                          }),
                        ),
                      ),
                    ),
                  ),
                )),
                const SizedBox(height: 8),
                SizedBox(
                  height: 50,
                  width: constraints.maxWidth,
                  child: Pagination(
                    back: () {if(page != 1) {context.read<ManageUserCubit>().change("-", page);}},
                    next: () {if(list.isNotEmpty){context.read<ManageUserCubit>().change("+", page);}},
                    indexCurrent: page,
                  ),
                )
              ],
            ),
          ),
      );
    });

  }
}
