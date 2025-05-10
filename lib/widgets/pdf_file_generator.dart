import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:qr_flutter/qr_flutter.dart' as qr_flutter;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:typed_data'; // For Uint8List  
import 'dart:ui' as ui;

Future<void> generateTicketPdf({
  required String title,
  required String imageUrl,
  required DateTime selectedDate,
  required String selectedTime,
  required List<String> selectedSeats,
}) async {
  // Load play image
  Uint8List? imageBytes;
  try {
    final ByteData imageData = await rootBundle.load(imageUrl);
    imageBytes = imageData.buffer.asUint8List();
  } catch (_) {
    final ByteData defaultImageData = await rootBundle.load('assets/images/default_play_image.png');
    imageBytes = defaultImageData.buffer.asUint8List();
  }
  final playImage = pw.MemoryImage(imageBytes);

  // Generate QR code image
  final painter = qr_flutter.QrPainter(
    data: 'TICKET_ID_${DateTime.now().millisecondsSinceEpoch}',
    version: qr_flutter.QrVersions.auto,
    gapless: false,
  );
  final uiImage = await painter.toImage(512);
  final byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
  final qrCodeBytes = byteData?.buffer.asUint8List() ?? Uint8List(0);
  final qrCode = pw.MemoryImage(qrCodeBytes);

  // Create PDF
  final pdf = pw.Document();
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Container(
            padding: const pw.EdgeInsets.all(20),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey),
              borderRadius: pw.BorderRadius.circular(10),
            ),
            child: pw.Column(
              mainAxisSize: pw.MainAxisSize.min,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(title, style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 15),
                pw.Image(playImage, width: 150),
                pw.SizedBox(height: 15),
                pw.Divider(),
                pw.SizedBox(height: 10),
                pw.Text('Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}', style: pw.TextStyle(fontSize: 14)),
                pw.Text('Time: $selectedTime', style: pw.TextStyle(fontSize: 14)),
                pw.Text('Stage: Stage 1', style: pw.TextStyle(fontSize: 14)),
                pw.Text('Seats: ${selectedSeats.join(', ')}', style: pw.TextStyle(fontSize: 14)),
                pw.SizedBox(height: 20),
                pw.Divider(),
                pw.SizedBox(height: 10),
                pw.Image(qrCode, width: 120),
                pw.SizedBox(height: 10),
                pw.Text('Scan this QR code for entry', style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic)),
              ],
            ),
          ),
        );
      },
    ),
  );

  // Save and open file
  final bytes = await pdf.save();
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/ticket_${title.replaceAll(' ', '_')}_${selectedDate.millisecondsSinceEpoch}.pdf');
  await file.writeAsBytes(bytes);
  await OpenFile.open(file.path);
}