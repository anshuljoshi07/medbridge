import 'package:serverpod/serverpod.dart';

import '../core/access.dart';
import '../generated/protocol.dart';

/// The Q&A list (A10 `questions`, F6).
class QuestionsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// All questions for the caller or a linked patient, open first.
  Future<List<Question>> list(Session session, {int? patientId}) async {
    final patient = await requireLink(
      session,
      patientId: patientId,
      roles: anyCareRole,
    );
    await audit(session, 'read', 'questions', patient.id!);
    return Question.db.find(
      session,
      where: (t) => t.patientId.equals(patient.id!),
      orderByList: (t) => [t.status.asc(), t.createdAt.desc()],
    );
  }

  /// Adds a free-text question (patient or caregiver).
  Future<Question> add(Session session, String text, {int? patientId}) async {
    final patient = await requireLink(
      session,
      patientId: patientId,
      roles: {CareRole.caregiver},
    );
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      throw AccessDeniedException(message: 'Write a question first.');
    }
    final uid = callerId(session);
    await audit(session, 'write', 'question', patient.id!);
    return Question.db.insertRow(
      session,
      Question(
        patientId: patient.id!,
        text: trimmed,
        source: patient.userId == uid ? 'patient' : 'caregiver',
        askedBy: uid,
      ),
    );
  }

  /// A clinician answers a question; it then shows up in the app.
  Future<Question> answer(Session session, int questionId, String text) async {
    await requireRole(session, Roles.clinicianRoles);
    final q = await Question.db.findById(session, questionId);
    if (q == null) throw AccessDeniedException(message: 'Not found.');
    await requireLink(
      session,
      patientId: q.patientId,
      roles: clinicalCareRoles,
    );
    await audit(session, 'write', 'question.answer', questionId);
    return Question.db.updateRow(
      session,
      q.copyWith(
        status: QuestionStatus.answered,
        answer: text.trim(),
        answeredBy: callerId(session),
        answeredAt: DateTime.now().toUtc(),
      ),
    );
  }
}
