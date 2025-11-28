import 'package:flutter/material.dart';

class TransactionEditPage extends StatefulWidget {
  const TransactionEditPage({super.key});

  @override
  State<TransactionEditPage> createState() => _TransactionEditPageState();
}

class _TransactionEditPageState extends State<TransactionEditPage> {
  String transactionType = 'buy';
  final TextEditingController sharesController = TextEditingController(text: '200');
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = DateTime.now().toString().split(' ')[0];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Your AAPL Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header section
            Container(
              padding: const EdgeInsets.all(8),
              height: size.height * .1,
              width: size.width,
              decoration: BoxDecoration(
                color: const Color(0xffDFF2E3),
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AAPL',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Apple',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        '\$203.27',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Row(
                        children: const [
                          Text(
                            'Close: ',
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: Colors.grey),
                          ),
                          Row(
                            children: const [
                              Text(
                                'Pre: ',
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: Colors.grey),
                              ),
                              Icon(Icons.arrow_drop_up,color: Colors.green,),
                              Row(
                                children: [
                                  Text(
                                    '27.27%  (',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(
                                      width: 18,
                                      child: Icon(Icons.arrow_drop_up,color: Colors.green,)),
                                  Text(
                                    '27.27%)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),

                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Text(
                            'Pre: ',
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14,color: Colors.grey),
                          ),
                          Icon(Icons.arrow_drop_up,color: Colors.green,),
                          Row(
                            children: [
                              Text(
                                '27.27%  (',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(
                                width: 18,
                                  child: Icon(Icons.arrow_drop_up,color: Colors.green,)),
                              Text(
                                '27.27%)',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.green,
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Green divider
            const Divider(
              color: Colors.green,
              thickness: 1,
              height: 30,
            ),
             Container(
               padding: const EdgeInsets.all(8),
               height: size.height * .5,
               width: size.width,
               decoration: BoxDecoration(
                 color: const Color(0xffDFF2E3),
                 borderRadius: BorderRadius.circular(4),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.grey.withOpacity(0.2),
                     spreadRadius: 1,
                     blurRadius: 1,
                     offset: const Offset(0, 1),
                   ),
                 ],
               ),
               child: Column(
                 children: [
                   Text(
                    'Select your option',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                   ),
                   SizedBox(height: 10),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 1.5, // Increase this value to make the radio button larger
                        child: Radio(
                          value: 'buy',
                          activeColor: Colors.green,
                          groupValue: transactionType,
                          onChanged: (value) {
                            setState(() {
                              transactionType = value!;
                            });
                          },
                        ),
                      ),
                      const Text('Buy'),
                      const SizedBox(width: 20),
                      Transform.scale(
                        scale: 1.5,
                        child: Radio(
                          activeColor: Colors.green,
                          value: 'sell',
                          groupValue: transactionType,
                          onChanged: (value) {
                            setState(() {
                              transactionType = value!;
                            });
                          },
                        ),
                      ),
                      const Text('Sell'),
                    ],
                               ),
                   Row(
                     children: [
                       Text('Number of Shares:', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16),),
                       Spacer(),
                       Container(
                         height: size.height * .03,
                         width: size.width * .15,
                         child: TextFormField(
                           textAlign: TextAlign.center,
                           // controller: _emailController,
                           decoration: InputDecoration(
                             contentPadding: const EdgeInsets.only(bottom: 2),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(6),
                               borderSide: const BorderSide(
                                 color: Color(0xff737373),
                                 width: 1,
                               ),
                             ),
                           ),
                         ),
                       ),
                       IconButton(onPressed: (){}, icon: Icon(Icons.mode_edit_outline_outlined, color: Colors.green,),),
                     ],
                   ),
                   Divider(thickness: 1,color: Color(0xffDFF2E3),),
                   Row(
                     children: [
                       Text('Price:', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16),),
                       Spacer(),
                       Container(
                         height: size.height * .03,
                         width: size.width * .15,
                         child: TextFormField(
                           textAlign: TextAlign.center,
                           // controller: _emailController,
                           decoration: InputDecoration(
                             contentPadding: const EdgeInsets.only(bottom: 2),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(6),
                               borderSide: const BorderSide(
                                 color: Color(0xff737373),
                                 width: 1,
                               ),
                             ),
                           ),
                         ),
                       ),
                       IconButton(onPressed: (){}, icon: Icon(Icons.mode_edit_outline_outlined, color: Colors.green,),),
                     ],
                   ),
                   Divider(thickness: 1,color: Color(0xffDFF2E3),),
                   Row(
                     children: [
                       Text('Transaction Date:', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16),),
                       Spacer(),
                      Text('Mar 09, 2025'),
                       IconButton(onPressed: (){}, icon: Icon(Icons.calendar_month, color: Colors.green,),),
                     ],
                   ),
                   Divider(thickness: 1,color: Color(0xffDFF2E3),),
                   Column(
                     children: [
                       Container(
                         width: size.width * .8,
                         child: ElevatedButton(
                           style: ElevatedButton.styleFrom(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(8),
                             ),
                             backgroundColor: Colors.green,
                             padding: const EdgeInsets.symmetric(vertical: 15),
                           ),
                           onPressed: () {
                             // Save changes
                           },
                           child: const Text('Save Changes',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                         ),
                       ),
                       const SizedBox(height: 10),
                       Container(
                         width: size.width * .8,
                         child: OutlinedButton(
                           style: OutlinedButton.styleFrom(
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(8),
                             ),
                             side: const BorderSide(
                               color: Colors.red,
                               width: 2,
                             ),
                             padding: const EdgeInsets.symmetric(vertical: 15),
                           ),
                           onPressed: () {
                             // Delete transaction
                           },
                           child: const Text('Delete Transaction',style: TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold),),
                         ),
                       ),
                     ],
                   ),
                 ],
               ),
             ),


          ],
        ),
      ),
    );
  }
}
