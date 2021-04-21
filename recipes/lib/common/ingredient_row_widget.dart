import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MeasuringUnit {
  String id;
  String name;

  MeasuringUnit(this.id, this.name);

  static List<MeasuringUnit> getItems() {
    return <MeasuringUnit>[
      MeasuringUnit("tea_spoon", "tea spoon(s)"),
      MeasuringUnit("yogurt_cup", "yogurt cup(s)"),
      MeasuringUnit("spoon", "spoon(s)"),
      MeasuringUnit("kg", "kg."),
      MeasuringUnit("gr", "gr."),
      MeasuringUnit("lb", "lb."),
      MeasuringUnit("unit", "unit(s)"),
    ];
  }
}

/// This is the stateful widget that the main application instantiates.
class IngredientRowWidget extends StatefulWidget {
  IngredientRowWidget({Key? key}) : super(key: key);

  final TextEditingController ingredientName = new TextEditingController();
  final TextEditingController ingredientQuantity = new TextEditingController();

  late MeasuringUnit selectedUnit;

  @override
  _IngredientRowWidgetState createState() => _IngredientRowWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _IngredientRowWidgetState extends State<IngredientRowWidget> {
  List<MeasuringUnit> _ingredientMeasuringUnits = MeasuringUnit.getItems();
  late List<DropdownMenuItem<MeasuringUnit>> _dropdownMeasuringUnitsItems;

  @override
  void initState() {
    super.initState();
    _dropdownMeasuringUnitsItems =
    buildDropdownMenuItems(_ingredientMeasuringUnits)!;
    widget.selectedUnit = _dropdownMeasuringUnitsItems[0].value!;
  }

  List<DropdownMenuItem<MeasuringUnit>>? buildDropdownMenuItems(
      List<MeasuringUnit> measuringUnits) {
    List<DropdownMenuItem<MeasuringUnit>> items = [];
    for (MeasuringUnit unit in measuringUnits) {
      items.add(
        DropdownMenuItem(
          value: unit,
          child: Text(unit.name),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CupertinoFormSection(children: [
            CupertinoTextFormFieldRow(
                placeholder: 'Ingredient Name',
                controller: widget.ingredientName),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new CupertinoTextFormFieldRow(
                          placeholder: 'Quantity',
                          controller: widget.ingredientQuantity,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ]),
                    ),
                  ),
                  new Expanded(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: DropdownButtonFormField<MeasuringUnit>(
                            value: widget.selectedUnit,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 20,
                            elevation: 16,
                            onChanged: (MeasuringUnit? newValue) {
                              setState(() {
                                widget.selectedUnit = newValue!;
                              });
                            },
                            items: _dropdownMeasuringUnitsItems)),
                  ),
                ])
          ]),
        ],
      ),
    );
  }
}
