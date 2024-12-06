import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/presentation/widgets/widgets.dart';
import '../../../domain/entities/users/user.dart';

class UserProfileScreen extends StatelessWidget {
  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final scaffoldkey = GlobalKey<ScaffoldState>();


    return FadeIn(
      child: Scaffold(
        key: scaffoldkey,
        appBar: const CustomAppBar2(),
        //drawer: FadeInLeftBig(duration: const Duration(milliseconds: 400),child: CustomSideMenu(scaffoldkey: scaffoldkey),),
        bottomNavigationBar: const BottomAppBarCustom(),
        body: ContentUserProfile(),
      ),
    );
  }
}

class ContentUserProfile extends ConsumerStatefulWidget {
  const ContentUserProfile({super.key});

  @override
  ConsumerState<ContentUserProfile> createState() => _ContentUserProfileState();
}

class _ContentUserProfileState extends ConsumerState<ContentUserProfile> {

  User cliente = User('assets/GoDely-Logo.png', 'Alejandro Seijas', '0412-6120717', 'aesr00@gmail.com', '12345');



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child:
      Column(
        children:[Center(
          child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: const Color.fromARGB(136, 186, 186, 186)),
            shape: BoxShape.rectangle,
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal:10),
                child: CircleAvatar(
                  radius: 60,
                  child: //Image.network(
                  Image.asset(
                    cliente.image,
                    fit: BoxFit.cover,
                  ),
                )
              ),
              Expanded(child:Container()),
              Column(
                children: [
                  Text(cliente.fullname,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal:30),
                    child: Row(
                      children: [
                        Icon(Icons.email),
                        Container(padding: EdgeInsets.symmetric(horizontal:4),),
                        Text(cliente.email,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal:30),
                    child: Row(
                      children: [
                        Icon(Icons.phone),
                        Container(padding: EdgeInsets.symmetric(horizontal:4),),
                        Text(cliente.phone,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

    ),

          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: Icon(Icons.person),
              title:Text('Personal information',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              onTap: (){

              },
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: Icon(Icons.lock),
              title:Text('Security',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              onTap: (){

              },
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: Icon(Icons.credit_card),
              title:Text('Payment methods',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              onTap: (){

              },
            ),
          ),


          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: Icon(Icons.map_sharp),
              title:Text('Addresses',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              onTap: (){

              },
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: Icon(Icons.delete),
              title:Text('Delete Account',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              onTap: (){

              },
            ),
          ),

          /*Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children:[
                  ElevatedButton(
                      onPressed: () {
                        setState(() {

                        });

                      },
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(const Size(250, 40)),
                        backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
                        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                      ),
                      child: Text(
                        'Change password',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ],
              )
          ),*/
        ],),

    );
  }
}


