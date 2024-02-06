import 'package:flutter/material.dart';

class GenderSelector extends StatefulWidget {
  final List<Gender> genders;

  const GenderSelector({super.key, required this.genders});

  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  late List<Gender> genders;

  @override
  void initState() {
    super.initState();
    genders=widget.genders;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
          child: Text('Gender:',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey.shade700),),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: genders.map((e) {
            return InkWell(
              splashColor: Colors.pinkAccent,
              onTap: () {
                setState(() {
                  genders.forEach((gender) => gender.isSelected = false);
                  genders[genders.indexOf(e)].isSelected = true;
                });
              },
              child: SizedBox(
                  child: CustomRadio(
                gender: genders[genders.indexOf(e)],
                width: w / 4,
              )),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CustomRadio extends StatelessWidget {
  Gender gender;
  double width;

  CustomRadio({required this.width, required this.gender});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: gender.isSelected ? Color(0xFF3B4257) : Colors.white,
        child: Container(
          height: width,
          width: width,
          alignment: Alignment.center,
          margin: new EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                gender.icon,
                color: gender.isSelected ? Colors.white : Colors.grey,
                size: 40,
              ),
              SizedBox(height: 10),
              Text(
                gender.name,
                style: TextStyle(
                    color: gender.isSelected ? Colors.white : Colors.grey),
              )
            ],
          ),
        ));
  }
}

class Gender {
  String name;
  IconData icon;
  bool isSelected;

  Gender(this.name, this.icon, this.isSelected);
}
