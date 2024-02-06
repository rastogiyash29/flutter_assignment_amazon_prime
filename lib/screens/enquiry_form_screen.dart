import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assignment/widgets/gender_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class EnquiryForm extends StatefulWidget {
  const EnquiryForm({super.key});

  static const String routeName = '/enquiry_form';

  @override
  State<EnquiryForm> createState() => _EnquiryFormState();
}

class _EnquiryFormState extends State<EnquiryForm> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  List<Gender> genders = [];

  @override
  void initState() {
    super.initState();
    genders.add(new Gender("Male", Icons.male, false));
    genders.add(new Gender("Female", Icons.female, false));
    genders.add(new Gender("Others", Icons.transgender, false));
  }

  var validTextValidator=FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z][a-zA-Z\s]*$'));

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Enquiry Form'),
        elevation: 5.0,
        shadowColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.save,
              color: Colors.blue,
            ),
            onPressed: () async{
              try{
                if (_nameController.text.isEmpty) {
                  throw Exception('Name cannot be empty');
                }
                if (_emailController.text.isEmpty || !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(_emailController.text)) {
                  throw Exception('Please enter a valid email');
                }
                if (_phoneController.text.isEmpty || _phoneController.text.length != 10) {
                  throw Exception('Please enter a valid phone number');
                }
                if (_cityController.text.isEmpty) {
                  throw Exception('City cannot be empty');
                }
                if (_stateController.text.isEmpty) {
                  throw Exception('State cannot be empty');
                }
                if (_countryController.text.isEmpty) {
                  throw Exception('Country cannot be empty');
                }
                bool genderSelected=false;
                for(var g in genders)if(g.isSelected)genderSelected=true;
                if(!genderSelected)throw Exception('Select Gender');
                Navigator.pop(context);
              }catch(e){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString().split(":")[1])));
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        physics: BouncingScrollPhysics(),
         children: <Widget>[
           getInputTile(
               hintLabel: 'Name',
               editFormats: <TextInputFormatter>[
                 validTextValidator,
               ],
               keyboardType: TextInputType.name,
               controller: _nameController,
               iconData: Icons.person),
           getInputTile(
               hintLabel: 'Email',
               editFormats: <TextInputFormatter>[],
               keyboardType: TextInputType.emailAddress,
               controller: _emailController,
               iconData: Icons.email),
           getInputTile(
               hintLabel: 'Phone',
               editFormats: <TextInputFormatter>[
                 FilteringTextInputFormatter.digitsOnly,
                 LengthLimitingTextInputFormatter(10)
               ],
               keyboardType: TextInputType.number,
               controller: _phoneController,
               iconData: Icons.phone),
           getInputTile(
               hintLabel: 'City',
               editFormats: <TextInputFormatter>[
                 validTextValidator,
               ],
               keyboardType: TextInputType.text,
               controller: _cityController,
               iconData: Icons.location_city),
           getInputTile(
               hintLabel: 'State',
               editFormats: <TextInputFormatter>[
                 validTextValidator,
               ],
               keyboardType: TextInputType.text,
               controller: _stateController,
               iconData: Icons.location_on),
           getInputTile(
               hintLabel: 'Country',
               editFormats: <TextInputFormatter>[
                 validTextValidator,
               ],
               keyboardType: TextInputType.text,
               controller: _countryController,
               iconData: Icons.find_replace_sharp),
           Divider(
             height: 1.0,
           ),
           SizedBox(
             width: double.maxFinite,
             child: GenderSelector(
               genders: genders,
             ),
           ),
           // Expanded(
           //     child: GenderSelector(
           //   genders: genders,
           // )),
         ],
      ),
    );
  }

  Widget getInputTile(
      {required String hintLabel,
      required List<TextInputFormatter> editFormats,
      required TextInputType keyboardType,
      required TextEditingController controller,
      required IconData iconData}) {
    return ListTile(
      leading: Icon(iconData),
      title: TextField(
        keyboardType: keyboardType,
        inputFormatters: editFormats,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintLabel,
        ),
      ),
    );
  }
}
