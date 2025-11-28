import 'package:flutter/material.dart';

class ReadingList extends StatefulWidget {
  const ReadingList({super.key});

  @override
  State<ReadingList> createState() => _ReadingListState();
}

class _ReadingListState extends State<ReadingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4.0,
        shadowColor: Colors.black,
        title: Text(
          'Reading List',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_backspace)),
      ),
      body: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 57,),
          Center(child: Image.asset('assets/images/emptylogo.png'),),
          SizedBox(height: 48,),
          Text('Your List is empty',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color(0xff595959)),),
          SizedBox(height: 16,),
          Text('You can add articles to your list by clicking the bookmark icon',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
        ],
      ),
    );
  }
}
