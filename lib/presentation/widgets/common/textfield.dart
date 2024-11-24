import 'package:flutter/material.dart';

class Authtextfield extends StatefulWidget {
  final String campo;
  final Function(String,String) callback;
  const Authtextfield({required this.campo,required this.callback, super.key});

  @override
  State<Authtextfield> createState() => _AuthtextfieldState();
}

class _AuthtextfieldState extends State<Authtextfield> {
  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final _textController = TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Column(children: [
        Row(children: [
          Text(widget.campo,
             style: textStyles.bodyLarge,
            ),
            Expanded(child: Container())
        ],),

            TextField(
              controller: _textController,
              onChanged: (texto) {
              widget.callback(texto,widget.campo);},
              decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),

              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey)
              ),
              fillColor: Colors.grey,
            ),),
      ],),
    );
  }
}