import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/cupertino.dart';


Map<String, dynamic> iconToIconDetailsMap={};
Map<String, dynamic> iconToFileMap={};
Map<String, dynamic> filesMap={};

Map<String, Icon> getIcon={
  'flag.png' : Icon(Icons.flag),
  'diamond.png' : Icon(Icons.do_disturb_alt_rounded),
  'marker.png' : Icon(Icons.mark_email_read),
  'lock.png' : Icon(Icons.lock),
  'light.png' : Icon(Icons.light),
  'rocket.png' : Icon(Icons.router),
};
bool viewValue=true;

class IconDetails {
  int? id;
  String? titleSymbol;
  int? fileId;
  String? fileName;
  int? actualCount;

  IconDetails(this.id, this.titleSymbol, this.fileId, this.fileName,
      this.actualCount);
  IconDetails.fromJson(Map<String, dynamic> json)
  {
    id=json['id'];//int.tryParse('${json['id']}');
    titleSymbol=json['title_symbol'];
    fileId=json['file_id'];
    fileName=json['file_name'];
    actualCount=json['actual_count'];
  }
}


dataController() async
{
  iconToIconDetailsMap={};
  iconToFileMap={};
  filesMap={};
  final jsonData=await rootBundle.loadString('assets/data.json');
  final jsonMap=json.decode(jsonData);
  final jsonList=jsonMap['data'];
  for(var jsonElement in jsonList) {
    IconDetails icon=IconDetails.fromJson(jsonElement);
    iconToIconDetailsMap[icon.titleSymbol!]=icon;

    if(iconToFileMap.containsKey(icon.titleSymbol!))
    {
      var map=iconToFileMap[icon.titleSymbol!];
      int countTotal=map['count'];
      countTotal+=icon.actualCount!;
      if(map.containsKey(icon.fileName))
        {
          int count=map[icon.fileName];
          count+=icon.actualCount!;
          map[icon.fileName]=count;
        }
      else
        {
          map[icon.fileName] = icon.actualCount;
          int countTotal=map['count'];
        }
      map['count']=countTotal;
      iconToFileMap[icon.titleSymbol!]=map;
    }
    else
    {
      iconToFileMap[icon.titleSymbol!]={
        icon.fileName : icon.actualCount,
        'count' : icon.actualCount
      };
    }
    if(!filesMap.containsKey(icon.fileName))
      {
        filesMap[icon.fileName!]=true;
      }
  }
}

