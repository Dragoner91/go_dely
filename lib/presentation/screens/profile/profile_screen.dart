import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_dely/domain/users/user.dart';
import 'package:go_dely/presentation/widgets/widgets.dart';
class ProfileScreen extends StatelessWidget {
  final scaffoldkey = GlobalKey<ScaffoldState>();

  ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final scaffoldkey = GlobalKey<ScaffoldState>();
    return FadeIn(
      child: Scaffold(
        key: scaffoldkey,
        appBar: const CustomAppBar(),
        //drawer: FadeInLeftBig(duration: const Duration(milliseconds: 400),child: CustomSideMenu(scaffoldkey: scaffoldkey),),
        bottomNavigationBar: const BottomAppBarCustom(),
        body: const ContentUserProfile(),
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
  User cliente = User(ci: "1231231", image: 'assets/GoDely-Logo.png', fullname: 'Alejandro Seijas', phone: '0412-6120717', email: 'aesr00@gmail.com', password: '12345');
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal:10),
                child: CircleAvatar(
                  radius: 60,
                  child: //Image.network(
                  Image.asset(
                    cliente.image!,
                    fit: BoxFit.cover,
                  ),
                )
              ),
              Expanded(child:Container()),
              Column(
                children: [
                  Text(cliente.fullname,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal:30),
                    child: Row(
                      children: [
                        const Icon(Icons.email),
                        Container(padding: const EdgeInsets.symmetric(horizontal:4),),
                        Text(cliente.email,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal:30),
                    child: Row(
                      children: [
                        const Icon(Icons.phone),
                        Container(padding: const EdgeInsets.symmetric(horizontal:4),),
                        Text(cliente.phone,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
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
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.person),
              title:const Text('Personal information',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              onTap: (){
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.lock),
              title:const Text('Security',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              onTap: (){
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.credit_card),
              title:const Text('Payment methods',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              onTap: (){
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.map_sharp),
              title:const Text('Addresses',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              onTap: (){
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: const Icon(Icons.delete),
              title:const Text('Delete Account',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
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
