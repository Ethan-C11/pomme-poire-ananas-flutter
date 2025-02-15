import 'package:flutter/material.dart';
import 'package:pomme_poire_ananas/liste_fruits_index.dart';

class listeFruits extends StatefulWidget {
  const listeFruits({super.key, required this.title});

  final String title;

  @override
  State<listeFruits> createState() => _listeFruitsState();
}

class _listeFruitsState extends State<listeFruits> {
  int _counter = 0;
  List<int> _fruits = [];
  late String _title;

  @override
  void initState() {
    _title = widget.title;
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _fruits.add(_counter);
      _title = listeFruitsIndex.choixImageOuTitre(_counter, false);
    });
  }

  void _deleteElementFromFruits(int number){
    setState(() {
      _fruits.removeAt(_fruits.indexOf(number));
    });
  }

  @override
  Widget build(BuildContext context) {
    void onButtonClicked(int number) async {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(listeFruitsIndex.choixImageOuTitre(number, false), style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
              content: Image(
                  image: AssetImage(
                      "images/${listeFruitsIndex.choixImageOuTitre(number, true)}"),
                  height: 350,
                  width: 350),
              actions: [
                TextButton(
                    onPressed: () {
                      _deleteElementFromFruits(number);
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.delete, color: Color.fromARGB(255, 255, 255, 255))),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.check, color: Color.fromARGB(255, 255, 255, 255)))
              ],
              backgroundColor: listeFruitsIndex.itemColorPicker(number),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Text(_title, textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _fruits.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image(
                  image: AssetImage(
                      "images/${listeFruitsIndex.choixImageOuTitre(_fruits[index], true)}")),
              title: Text(_fruits[index].toString()),
              textColor: const Color.fromARGB(255, 255, 255, 255),
              tileColor: listeFruitsIndex.itemColorPicker(_fruits[index], 150),
              contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              onTap: () => onButtonClicked(_fruits[index]),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: listeFruitsIndex.buttonColorPicker(_counter),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
