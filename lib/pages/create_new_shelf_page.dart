import 'package:flutter/material.dart';
import 'package:playbooks_flutter/data/bloc/create_new_shelf_bloc.dart';
import 'package:playbooks_flutter/data/bloc/shelf_bloc.dart';
import 'package:playbooks_flutter/data/vos/shelf_vo.dart';
import 'package:playbooks_flutter/resources/colors.dart';
import 'package:playbooks_flutter/resources/dimensions.dart';
import 'package:provider/provider.dart';

class CreateNewShelfPage extends StatefulWidget {
  const CreateNewShelfPage({super.key, this.shelfVO});

  final ShelfVO? shelfVO;

  @override
  State<CreateNewShelfPage> createState() => _CreateNewShelfPageState();
}

class _CreateNewShelfPageState extends State<CreateNewShelfPage> {
  final TextEditingController shelfNameController = TextEditingController();
  @override
  void initState() {
    if (widget.shelfVO != null) {
      shelfNameController.text = widget.shelfVO!.shelfName!;
    }
    super.initState();
  }

  @override
  void dispose() {
    shelfNameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.done,
            color: kPrimaryColor,
          ),
          onPressed: () {
            if (shelfNameController.text.isNotEmpty &&
                (widget.shelfVO == null)) {
              context
                  .read<CreateNewShelfBloc>()
                  .createNewShelf(shelfNameController.text.toString());
            } else if (widget.shelfVO != null) {
              // context.read<ShelfBloc>().editShelfName(
              //     widget.shelfVO!.copyWith(shelfName: shelfNameController.text));
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSP16x),
        child: Stack(
          children: [
            TextFormField(
              controller: shelfNameController,
              autofocus: true,
              decoration:
                  const InputDecoration(hintText: "Type in the Shelf Name"),
            )
          ],
        ),
      ),
    );
  }
}
