import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/bloc/shelf_bloc.dart';
import 'package:playbooks_flutter/data/vos/shelf_vo.dart';
import 'package:playbooks_flutter/pages/create_new_shelf_page.dart';
import 'package:playbooks_flutter/pages/shelf_details_page.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';
import 'package:provider/provider.dart';

import '../resources/colors.dart';

class YourShelfView extends StatelessWidget {
  const YourShelfView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Selector<ShelfBloc, List<ShelfVO>>(
            selector: (context, bloc) => bloc.shelfList,
            builder: (context, shelfList, _) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 0,
                  );
                },
                itemCount: shelfList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShelfDetailsView(
                              shelfVO: shelfList[index],
                            ),
                          ));
                    },
                    onLongPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateNewShelfPage(
                              shelfVO: shelfList[index],
                            ),
                          ));
                    },
                    leading: shelfList[index].bookList!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(
                              kSP10x,
                            ),
                            child: CachedNetworkImage(
                              height: 100,
                              fit: BoxFit.cover,
                              width: 50,
                              imageUrl:
                                  shelfList[index].bookList?.first.bookImage ??
                                      "",
                            ),
                          )
                        : Container(
                            height: 50,
                            width: 50,
                            color: kPrimaryColor,
                          ),
                    title: Text(
                      shelfList[index].shelfName ?? "",
                      style: const TextStyle(color: kWhiteTextColor),
                    ),
                    subtitle: Text(
                      "${shelfList[index].bookList!.length.toString()} books",
                      style: const TextStyle(color: kGreyTextColor),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward,
                      color: kPrimaryColor,
                    ),
                  );
                },
              );
            }),
        Positioned(
          bottom: kSP16x,
          right: kSP16x,
          child: FloatingActionButton.extended(
            backgroundColor: kSecondaryColor,
            label: const Text(
              "Create New",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            isExtended: true,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateNewShelfPage(),
                  ));
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
