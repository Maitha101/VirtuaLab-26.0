import 'package:flutter/material.dart';
import 'package:virtulab/administrator/admin_edit_accounts.dart';
import 'package:virtulab/widgets/custom_text.dart';

class AdminAccounts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdminAccounts();
  }
}

class _AdminAccounts extends State<AdminAccounts> {
  List courseName = [
    "Data Mining",
    "Data Structure",
    "Python",
    "Java",
    "C++",
  ];

  List instructorName = [
    "Mr Ahmed",
    "Mr Mohamed",
    "Mr Amr",
    "Mr Mahmoud",
    "Mr Abdallah"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Manage Accounts'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 30),
              child: CustomText(text: "Search :",fontSize: 22,fontWeight: FontWeight.bold,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                decoration:InputDecoration(
                    hintText: "type here !",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              child: Container(
                color: Colors.grey,
                height: 2,width: double.infinity,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30,bottom: 8),
              child: CustomText(
                text: "Courses :",
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .54,
              child: ListView.builder(
                  itemCount: courseName.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>AdminEditAccounts(
                                courseName: courseName[index],
                                instructorName: instructorName[index],
                              )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20,top: 5,bottom: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(text: courseName[index],fontSize: 21,fontWeight: FontWeight.w600,),
                                    CustomText(text: instructorName[index],),
                                    CustomText(text: "No.Student : 32",color: Colors.grey,)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                              )

                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        )
    );
  }
}
