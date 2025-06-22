import 'package:flutter/material.dart';

class BackgroundForm extends StatefulWidget {

  final Widget? child ;
  final Function () handle ;
  const BackgroundForm({super.key, this.child, required this.handle});

  @override
  State<BackgroundForm> createState() => _BackgroundFormState();
}

class _BackgroundFormState extends State<BackgroundForm> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            child: GestureDetector(
              onTap: () {widget.handle();},
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(100))
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white,),
                ),
              ),
            ),
        ),
        if(widget.child != null)
          widget.child! ,
      ],
    );
  }
}
