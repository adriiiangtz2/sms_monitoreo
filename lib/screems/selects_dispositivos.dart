import 'package:flutter/material.dart';

class SelectsDispositivosCommandScreen extends StatefulWidget {
   
  const SelectsDispositivosCommandScreen({Key? key}) : super(key: key);
  

  @override
  State<SelectsDispositivosCommandScreen> createState() => _SelectsDispositivosCommandScreenState();
}

 const List<String> list2 = <String>['Suntech', 'Tracklight', 'Teltonika', 'Concox'];
class _SelectsDispositivosCommandScreenState extends State<SelectsDispositivosCommandScreen> {

  // String dropdownValue = list[0];
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;

  String dropdownValue = list2.first;

  @override
    Widget build(BuildContext context) {

  

    return  Scaffold(
        appBar: AppBar(
            title: const Text("Selects"),
        backgroundColor: const Color(0xFD3234A2),
          centerTitle: true,
        ),
        body:  Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: const ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue:  continued,
                onStepCancel: cancel,
                steps: <Step>[
                   Step(
                    title: const Text('Marcas'),
                    content: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            const Text("Seleccione una marca"),
                            const SizedBox(width: 10,),
                               DropdownButton<String>(
                           value: dropdownValue,
                           icon: const Icon(Icons.arrow_downward),
                          //  elevation: 16
                           style: const TextStyle(color: Color(0xFD3234A2)),
                           underline: Container(
                             height: 2,
                             color: const Color(0xFD3234A2),
                           ),
                           onChanged: (String? value) {
                             // This is called when the user selects an item.
                             setState(() {
                               dropdownValue = value!;
                             });
                           },
                           items: list2.map<DropdownMenuItem<String>>((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text(value),
                             );
                           }).toList(),
                         )



                          ],

                          
                        ),
                     

                      



                     
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0 ?
                    StepState.complete : StepState.disabled,
                  ),







                   Step(
                    title: const Text('Address'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Home Address'),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Postcode'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1 ?
                    StepState.complete : StepState.disabled,
                  ),
                   Step(
                    title: const Text('Mobile Number'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Mobile Number'),
                        ),
                      ],
                    ),
                    isActive:_currentStep >= 0,
                    state: _currentStep >= 2 ?
                    StepState.complete : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: switchStepsType,
          child: const Icon(Icons.list),
        ),

    );
  }
  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 2 ?
        setState(() => _currentStep += 1): null;
  }
  cancel(){
    _currentStep > 0 ?
        setState(() => _currentStep -= 1) : null;
  }
}
