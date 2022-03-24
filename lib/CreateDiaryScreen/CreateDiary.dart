import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mintag_application/Database/Database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/OverviewScreen/OverviewScreen.dart';
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';
import 'package:uuid/uuid.dart';

class CreateDiary extends StatefulWidget {
  const CreateDiary({ Key? key }) : super(key: key);

  @override
  State<CreateDiary> createState() => _CreateDiaryState();
}

class _CreateDiaryState extends State<CreateDiary> {

  final _storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {

    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _ageController = TextEditingController();

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
        const HeaderContainer(header: "Tagebuch erstellen", subHeader: "Bevor du loslegen kannst, musst du zuerst noch ein Tagebuch erstellen."),
        const SizedBox(height: 16,),
        TextInputContainer(title: "Wie heisst du?", textController: _nameController),
        //TextInputContainer(title: "Wie alt bist du?", textController: _ageController),
        Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ElevatedButton(
              onPressed: ()=> createDiary("Richard"), 
              child: const Text(
                "Erstellen", 
                style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold, 
                  fontSize: 16),), 
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff0C947B), 
                  shape: RoundedRectangleBorder( //to set border radius to button
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
            ),
          ),
      ],
      ),
    );
  }

  //creates a new diary persists it in firebase
  Future<void> createDiary(String name )async{
      //final user = FirebaseAuth.instance.currentUser!;
      var uuid = Uuid();
       String newDiaryId = uuid.v1();
      DiaryDTO diaryDTO = DiaryDTO(newDiaryId, name + "'s diary", entries: null);
      UserAccountDTO userAccountDTO = UserAccountDTO(diaryDTO, name);
      userAccountDTO.setId(persistUserAccout(userAccountDTO));

      await _storage.write(key: "db_id", value: userAccountDTO.databaseId);

      String? key = await _storage.read(key: "db_id");
      debugPrint("[----KEY---]" + key.toString());

      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const OverviewScreen()) );
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                TextField(controller: textController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}