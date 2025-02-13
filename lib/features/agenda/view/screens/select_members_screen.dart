import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/agenda/view/screens/add_agenda_screen.dart';
import 'package:flutter/material.dart';
class SelectMembersScreen extends StatefulWidget {
  @override
  _SelectMembersScreenState createState() => _SelectMembersScreenState();
}

class _SelectMembersScreenState extends State<SelectMembersScreen> {
  final List<String> members = [
     'Alice',
    'Bob',
   'Charlie',
   'David',
   'Emma',
    'Frank',
  ];

  final List<String> selectedMembers = [];

  void toggleSelection(String member) {
    setState(() {
      if (selectedMembers.contains(member)) {
        selectedMembers.remove(member);
      } else {
        selectedMembers.add(member);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
       leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: MyColors.whiteColor,
            size: 22,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: const Text(
            'Select Members',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: MyColors.whiteColor),
          ),
        ),
        backgroundColor: MyColors.primayColor,
        centerTitle: true,
      ),
      backgroundColor: MyColors.ternaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
             
              SizedBox(height: 10,),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(height: 0,),
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    final isSelected = selectedMembers.contains(member);
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: MyColors.secondaryColor,
                        child: Text(member[0], style: TextStyle(fontSize: 20, color: MyColors.whiteColor),),
                      ),
                      title: Text(member),
                      trailing: isSelected
                          ? Icon(Icons.check_circle, color: MyColors.primayColor)
                          : Icon(Icons.circle_outlined, color: Colors.grey),
                      onTap: () => toggleSelection(member),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 40,
            child: CustomBigButton(action: (){
              Navigator.pop(context, selectedMembers);
            }, text: 'Add Selected Members'),
          ),
        ],
      ),
    );
  }
}