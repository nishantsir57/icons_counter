import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'icons.dart';

class ViewPage extends StatefulWidget
{
  ViewPageState createState()=>ViewPageState();
}
class ViewPageState extends State<ViewPage>
{
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Icons Counter App'),
      leading: IconButton(
        icon: viewValue?Icon(Icons.grid_3x3_outlined):Icon(Icons.view_list),
        onPressed: ()=>setState(() {
          viewValue=!viewValue;
        }),
      ),
    ),
    body: viewValue?listView():gridView(),
  );

  Widget listView() {
    return FutureBuilder(
      future: dataController(),
        builder: (ctx, snapshot) => ListView(
            children: [
              getTopRow(),
              for(String iconName in iconToFileMap.keys)
                getDetailedRow(iconToIconDetailsMap[iconName]),
            ]
        )
    );
  }
  Widget gridView() => FutureBuilder(
    future: dataController(),
    builder: (ctx, snapshot) => ListView(
      children: [
        for(int i=0;i<iconToFileMap.keys.length;i+=3)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(int j=i;j<i+3 && j<iconToFileMap.keys.length;j++)
                Expanded(
                  flex: iconToFileMap.values.elementAt(j)['count'],
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(2),
                      child: ListTile(
                        tileColor: Colors.blueAccent,
                        title: getIcon[iconToIconDetailsMap.values.elementAt(j).titleSymbol],
                      ),
                    ))
              ],
            )
      ],
    )
  );


  Widget getTopRow() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          color: Colors.black26,
          padding: EdgeInsets.all(2),
          child: ListTile(
            tileColor: Colors.blueAccent,
            title: Center(child: Text('Symbol')),
          ),
        ),
      ),
      for(String fileName in filesMap.keys)
        Expanded(
          child: Container(
            color: Colors.black26,
            padding: EdgeInsets.all(2),
            child: ListTile(
              key: Key(fileName),
              tileColor: Colors.blueAccent,
              title: Center(child: Text('$fileName')),
            ),
          ),
        ),
      Expanded(
          child: Container(
            padding: EdgeInsets.all(2),
            color: Colors.black26,
            child: ListTile(
              tileColor: Colors.blueAccent,
              title: Center(child: Text('Count of All Files')),
            ),
          )
      ),
    ],
  );
  Widget getDetailedRow(IconDetails icon){
    int count=0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Center(child: getIcon[icon.titleSymbol] )),
        for(String key in filesMap.keys)
          if(iconToFileMap[icon.titleSymbol].containsKey(key))
            Expanded(
              child: Center(child: Text(iconToFileMap[icon.titleSymbol][key].toString())),
            )
          else
            Expanded(
                child: Center(child: Text('0'))
            ),
        Expanded(child: Center(child: Text(iconToFileMap[icon.titleSymbol]['count'].toString()))),
      ],
    );
  }
}