import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../core/access.dart';
import '../generated/protocol.dart';

/// Patient-initiated care-team linking (A10 `care`, F7).
class CareEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  static final _random = Random.secure();

  /// No 0/O, 1/I/L: codes are read aloud and typed by older adults.
  static const _alphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';

  /// The patient creates an invite code for a caregiver or clinician.
  Future<CareLink> createInvite(Session session, CareRole role) async {
    final patient = await requireLink(session);
    final code = List.generate(
      8,
      (_) => _alphabet[_random.nextInt(_alphabet.length)],
    ).join();
    await audit(session, 'write', 'care.invite', patient.id!);
    return CareLink.db.insertRow(
      session,
      CareLink(patientId: patient.id!, role: role, inviteCode: code),
    );
  }

  /// The invited person accepts with the code. Clinical invites require an
  /// admin-created account with the matching role.
  Future<CareLink> acceptInvite(Session session, String code) async {
    final normalized = code.trim().toUpperCase().replaceAll(' ', '');
    final link = await CareLink.db.findFirstRow(
      session,
      where: (t) =>
          t.inviteCode.equals(normalized) & t.status.equals(LinkStatus.pending),
    );
    if (link == null) {
      throw AccessDeniedException(message: 'That code is not valid.');
    }
    final uid = callerId(session);
    final roles = await callerRoles(session);
    if (link.role == CareRole.caregiver) {
      await grantRole(session, uid, Roles.caregiver);
    } else if (!roles.contains(link.role.name)) {
      throw AccessDeniedException(
        message: 'This code is for a ${link.role.name} account.',
      );
    }
    await audit(session, 'write', 'care.accept', link.id!);
    return CareLink.db.updateRow(
      session,
      link.copyWith(userId: uid, status: LinkStatus.active),
    );
  }

  /// The patient removes a link.
  Future<CareLink> revoke(Session session, int linkId) async {
    final patient = await requireLink(session);
    final link = await CareLink.db.findById(session, linkId);
    if (link == null || link.patientId != patient.id) {
      throw AccessDeniedException(message: 'Not your link.');
    }
    await audit(session, 'write', 'care.revoke', linkId);
    return CareLink.db.updateRow(
      session,
      link.copyWith(status: LinkStatus.revoked),
    );
  }

  /// For a patient: their care team. For anyone else: their own links.
  Future<List<CareLink>> links(Session session) async {
    final uid = callerId(session);
    final own = await Patient.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(uid),
    );
    return CareLink.db.find(
      session,
      where: (t) =>
          (own != null ? t.patientId.equals(own.id!) : t.userId.equals(uid)) &
          t.status.notEquals(LinkStatus.revoked),
      orderBy: (t) => t.createdAt,
    );
  }
}
