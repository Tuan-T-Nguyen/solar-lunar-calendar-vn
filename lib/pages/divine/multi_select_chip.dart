import 'package:flutter/material.dart';

class MultiSelectChip extends StatefulWidget {
  final List<String> choiceList;

  const MultiSelectChip({Key key, this.choiceList}) : super(key: key);
  
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> _selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.choiceList.forEach((item) {
      choices.add(Container(
        padding: EdgeInsets.all(2.0),
        child: ChoiceChip(label: Text(item), selected: _selectedChoices.contains(item), onSelected: (selected) {
          setState(() {
            _selectedChoices.contains(item) ? _selectedChoices.remove(item) : _selectedChoices.add(item);
          });
        },),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap( children: _buildChoiceList());
  }
}
