import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms and Conditions',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),backgroundColor: Colors.white,elevation: 0,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Olive Stocks – Terms of Use',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Acceptance of Terms / قبول الشروط',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'By accessing or using Olive Stocks via our website or mobile application, you agree to be bound by these Terms of Use. If you do not agree, please do not use our services.\n\n من خلال الوصول إلى موقع Olive Stocks أو تطبيق الهاتف المحمول، فإنك توافق على الالتزام بهذه الشروط والأحكام. إذا كنت لا توافق، يُرجى عدم استخدام خدماتنا. ',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Eligibility / الأهلية',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'You must be at least 18 years old to use Olive Stocks. By using our platform, you confirm that you meet this requirement.\n\nيجب أن تكون تبلغ من العمر ١٨ عامًا على الأقل لاستخدام Olive Stocks. باستخدامك لمنصتنا، فأنت تقر بأنك تستوفي هذا الشرط.', style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Registration and Security / تسجيل الحساب والأمان',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'You are responsible for maintaining the confidentiality of your account login information and for all activities under your account. You agree to notify us immediately of any unauthorized use.\n\nأنت مسؤول عن الحفاظ على سرية معلومات تسجيل الدخول لحسابك وعن جميع الأنشطة التي تتم من خلاله. وتوافق على إخطارنا فورًا بأي استخدام غير مصرح به.', style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Subscription and Payments / الاشتراك والمدفوعات',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'You are responsible for maintaining the confidentiality of your account login information and for all activities under your account. You agree to notify us immediately of any unauthorized use.\n\nأنت مسؤول عن الحفاظ على سرية معلومات تسجيل الدخول لحسابك وعن جميع الأنشطة التي تتم من خلاله. وتوافق على إخطارنا فورًا بأي استخدام غير مصرح به.', style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Intellectual Property / الملكية الفكرية',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'All content on Olive Stocks, including logos, data, design, and software, is owned by Olive Stocks Ltd or its licensors. You may not copy, distribute, or modify any part without permission.\n\nجميع المحتويات على Olive Stocks، بما في ذلك الشعارات والبيانات والتصميمات والبرمجيات، مملوكة لشركة Olive Stocks Ltd أو الجهات المرخصة لها. لا يجوز لك نسخ أو توزيع أو تعديل أي جزء دون إذن.', style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Financial Information Disclaimer / إخلاء المسؤولية عن المعلومات المالية',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Olive Stocks provides financial data and insights for informational purposes only. It does not constitute financial advice or recommendations. You are solely responsible for any investment decisions.\n\nتوفر Olive Stocks بيانات ورؤى مالية لأغراض إعلامية فقط. ولا تُعد نصيحة مالية أو توصية. أنت وحدك المسؤول عن أي قرارات استثمارية تقوم بها.', style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Conduct / سلوك المستخدم',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'You agree not to misuse the platform, engage in fraudulent behavior, or post illegal content. We reserve the right to suspend or terminate your account for violations.\n\nتوافق على عدم إساءة استخدام المنصة أو الانخراط في سلوك احتيالي أو نشر محتوى غير قانوني. ونحتفظ بالحق في تعليق أو إنهاء حسابك في حال حدوث انتهاكات.', style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Limitation of Liability / تحديد المسؤولية',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Olive Stocks is not liable for any indirect, incidental, or consequential damages arising from the use of the platform.\n\nلا تتحمل Olive Stocks المسؤولية عن أي أضرار غير مباشرة أو عرضية أو تبعية ناتجة عن استخدام المنصة.', style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Governing Law / القانون الحاكم',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'These Terms are governed by the laws of England and Wales. Company No. 16477237, incorporated on 27 May 2025 in Cardiff.\n\nتخضع هذه الشروط لقوانين إنجلترا وويلز. رقم الشركة 16477237، تم تسجيلها بتاريخ 27 مايو 2025 في كارديف.', style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Changes to Terms / التعديلات على الشروط',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'We may update these Terms from time to time. Continued use of the platform means you accept the updated terms.\n\nيجوز لنا تحديث هذه الشروط من وقت لآخر. استمرارك في استخدام المنصة يعني قبولك للشروط المحدثة.', style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(thickness: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      'Stay Connected',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                      Text('Join our newsletter for the latest\nupdates and exclusive offers.')
                    ]
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      'Quick Links',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                      Text('Terms and conditions\nPrivacy Policy\nLegal Policy'),
                    ]
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                  children: [
                    Text(
                      'Contact us',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Center(child: Text('128 City Road, London, EC1V 2NX, United Kingdom\nSupport@olivestocks.com')),
                  ]
              ),
              SizedBox(height: 20),
              Center(child: Text('© 2025 Olive Stocks. All rights reserved.',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10),)),
            ],
          ),
        ),
      ),
    );
  }
}
