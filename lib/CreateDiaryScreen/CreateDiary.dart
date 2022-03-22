import 'package:flutter/material.dart';
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';

class CreateDiary extends StatefulWidget {
  const CreateDiary({ Key? key }) : super(key: key);

  @override
  State<CreateDiary> createState() => _CreateDiaryState();
}

class _CreateDiaryState extends State<CreateDiary> {
  @override
  Widget build(BuildContext context) {

    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _ageController = TextEditingController();

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
        const HeaderContainer(header: "Tagebuch erstellen", subHeader: "Bevor du loslegen kannst, musst du zuerst noch ein Tagebuch erstellen."),
        TextInputContainer(title: "Wie heisst du?", textController: _nameController),
        TextInputContainer(title: "Wie alt bist du?", textController: _ageController),

      ],),
    );
  }
}


class TextInputContainer extends StatelessWidget {

  final String title;
  final TextEditingController textController;
  const TextInputContainer({
    required this.title,
    required this.textController,
     Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Material(
        shadowColor: Colors.black,
        elevation: 10,
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text(title),
              TextField(controller: textController),
            ],
          ),
        ),
      ),
    );
  }
}