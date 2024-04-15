import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin FormatData {

  String _formatarDataIso(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final formatted = formatter.format(dateTime);

    return formatted;
  }
    String _formatarDataBr(DateTime dateTime) {
    final formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
    final formatted = formatter.format(dateTime);

    return formatted;
  }


  String formatDataComHoraBr({required DateTime dateTime, required TimeOfDay timeOfDay}) {

    final data = DateTime(dateTime.year, dateTime.month, dateTime.day,timeOfDay.hour, timeOfDay.minute);
    return _formatarDataBr(data);

  }

   String formatDataComHoraIso({required DateTime dateTime, required TimeOfDay timeOfDay}) {

    final data = DateTime(dateTime.year, dateTime.month, dateTime.day,timeOfDay.hour, timeOfDay.minute);
    return _formatarDataIso(data);
    
  }

  String formatarDataStringParaBr(String data){
    final dataConvertido = DateFormat('yyyy-MM-dd HH:mm:ss').parse(data);
    return _formatarDataBr(dataConvertido);
  }
}
