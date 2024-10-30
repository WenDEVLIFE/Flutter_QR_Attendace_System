import 'dart:io';
import 'package:attendance_qr_system/Component/FlutterToast.dart';
import 'package:attendance_qr_system/model/AttendanceModel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:csv/csv.dart'; // Import the csv package

class ExportExcel {
  void exportToCSV(List<AttendanceModel> filteredUsers, BuildContext context, String eventName) async {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(max: 100, msg: 'Exporting to CSV...');

    try {
      if (filteredUsers.isEmpty) {
        FlutterToast().showToast("No data to export", Colors.red);
        pd.close();
        return;
      }

      // Request storage permissions
      if (!await Permission.storage.request().isGranted) {
        FlutterToast().showToast("Storage permission denied", Colors.red);
        pd.close();
        return;
      }

      // Create CSV data
      List<List<dynamic>> rows = [
        ['ID', 'Attendance ID', 'Date', 'User ID', 'Status', 'Time In', 'Full Name', 'Grade', 'Section']
      ];

      for (var attendance in filteredUsers) {
        rows.add([
          attendance.id, attendance.attendanceID, attendance.date, attendance.userID, attendance.status, attendance.timeIn, attendance.fullname, attendance.grade, attendance.section
        ]);
      }

      String csvData = const ListToCsvConverter().convert(rows);

      // Set path to Downloads folder
      final directory = Directory('/storage/emulated/0/Download');
      String path = '${directory.path}/$eventName.csv';
      int counter = 1;

      // Check if file exists and create a unique name if needed
      while (await File(path).exists()) {
        path = '${directory.path}/$eventName($counter).csv';
        counter++;
      }

      var file = File(path);
      await file.writeAsString(csvData);
      FlutterToast().showToast("Exported to $path", Colors.green);

    } catch (e) {
      print("Error in exportToCSV method: $e");
      FlutterToast().showToast("Error: $e", Colors.red);
    } finally {
      pd.close();
    }
  }
}