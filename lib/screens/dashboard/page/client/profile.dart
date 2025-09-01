import 'dart:math';

import 'package:exchange_book/screens/dashboard/page/client/cubit/profile/profile_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/profile/introduce_profile.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/profile/product_profile.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/profile/user_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:exchange_book/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfileCubit>().loadingData();
  }

  Widget getLayout(double width, ProfileState state) {
    if (width < 1000 && width >= 650) {
      return Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            UserProfileCard(
              userModel: state.user,
            ),
            const SizedBox(
              height: 30,
            ),
            IntroduceProfile(
              height: 400,
              weight: MediaQuery.of(context).size.width,
              margin: 0,
            ),
            const SizedBox(
              height: 30,
            ),
            ProductProfile(
              list: state.list,
            )
          ],
        ),
      );
    } else if (width < 650) {
      return Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            UserProfileCard(
              isMobile: true,
              userModel: state.user,
            ),
            const SizedBox(
              height: 10,
            ),
            IntroduceProfile(
              height: 400,
              weight: MediaQuery.of(context).size.width,
              margin: 0,
            ),
            const SizedBox(
              height: 10,
            ),
            ProductProfile(
              list: state.list,
            )
          ],
        ),
      );
    }
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
            margin: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: Column(
              children: [
                UserProfileCard(
                  userModel: state.user,
                ),
                const SizedBox(
                  height: 10,
                ),
                ProductProfile(
                  list: state.list,
                )
              ],
            ),
          )),
          IntroduceProfile(
            weight: max(300, MediaQuery.of(context).size.width * 0.22),
            margin: 10,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) => ListView(
        children: [
          getLayout(width, state),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Theme.of(context).colorScheme.mainCard,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1), // Màu bóng
                  blurRadius: 10, // Độ mờ của bóng
                  spreadRadius: 2, // Độ lan rộng của bóng
                  offset: const Offset(0, 4), // Vị trí bóng (x, y)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
