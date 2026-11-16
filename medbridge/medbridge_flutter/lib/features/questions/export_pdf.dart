import 'package:medbridge_client/medbridge_client.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// One-page PDF for the PCP visit (F6): plan + discrepancies + questions.
Future<void> sharePcpPdf({
  required String name,
  required PlanView? plan,
  required List<ScanHistoryEntry> history,
  required List<Question> questions,
}) async {
  final doc = pw.Document(title: 'MedBridge summary');
  final flagged = history.where((e) => e.recon.sev == 'red' || e.recon.sev == 'amber').toList();
  doc.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.letter,
      build: (_) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('MedBridge — medicines after discharge', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
          pw.Text('Patient: $name   Plan status: ${plan?.plan.status.name ?? 'none'}   (synthetic data)'),
          pw.SizedBox(height: 10),
          pw.Text('Discharge plan', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          if (plan != null)
            pw.TableHelper.fromTextArray(
              headers: ['Action', 'Medicine', 'Directions'],
              data: [for (final i in plan.items) [i.action, i.name, i.sigRaw]],
              cellStyle: const pw.TextStyle(fontSize: 9),
            ),
          pw.SizedBox(height: 10),
          pw.Text('Bottle discrepancies', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          for (final e in flagged) pw.Bullet(text: '${e.scan.name}: ${e.recon.status} (${e.recon.reason}, ${e.recon.sev})'),
          pw.SizedBox(height: 10),
          pw.Text('Questions', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          for (final q in questions) pw.Bullet(text: q.answer == null ? q.text : '${q.text}\n  Answer: ${q.answer}'),
        ],
      ),
    ),
  );
  await Printing.sharePdf(bytes: await doc.save(), filename: 'medbridge-summary.pdf');
}
