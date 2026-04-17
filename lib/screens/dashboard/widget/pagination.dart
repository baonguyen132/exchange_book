import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  final Function () next ;
  final Function () back ;
  final int indexCurrent ;
  const Pagination({super.key, required this.next, required this.back, required this.indexCurrent});

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) => Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: widget.back,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              height: constraints.maxHeight,
              width: constraints.maxHeight,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade500,
                    Colors.blue.shade700,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.chevron_left_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12,),
        Container(
          height: constraints.maxHeight,
          width: constraints.maxHeight ,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade50,
                Colors.blue.shade100,
              ],
            ),
            border: Border.all(
              width: 2,
              color: Colors.blue.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            widget.indexCurrent.toString(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
        ),
        const SizedBox(width: 12,),
        GestureDetector(
          onTap: widget.next,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              height: constraints.maxHeight,
              width: constraints.maxHeight,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade500,
                    Colors.blue.shade700,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    ),);
  }
}