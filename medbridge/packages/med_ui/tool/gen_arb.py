import json
# key: (en, es, placeholders). ES = draft pending medical-translator review (F9).
S = {
 "appName": ("MedBridge", "MedBridge"),
 "tagline": ("Discharge meds, made clear.", "Sus medicinas del alta, claras."),
 "tabToday": ("Today", "Hoy"), "tabScan": ("Scan", "Escanear"), "tabMyMeds": ("My meds", "Mis medicinas"), "tabQuestions": ("Questions", "Preguntas"),
 "statusKeep": ("Continue", "Continuar"), "statusChanged": ("Changed", "Cambió"), "statusStop": ("Stop", "Dejar"), "statusNew": ("New", "Nueva"),
 "statusHold": ("Hold", "Pausar"), "statusDuplicate": ("Duplicate", "Duplicada"), "statusUnknown": ("Unknown", "Desconocida"),
 "sevOk": ("All good", "Todo bien"), "sevInfo": ("For your information", "Para su información"), "sevAmber": ("Check this", "Revise esto"), "sevRed": ("Needs attention", "Requiere atención"),
 "msgLowConfidence": ("We couldn't read this clearly. Add it to your questions.", "No pudimos leer esto bien. Agréguelo a sus preguntas."),
 "msgPlanStop": ("Your care team stopped this medicine. Don't take it. Set it aside.", "Su equipo de salud suspendió esta medicina. No la tome. Apártela."),
 "msgPlanHold": ("Pause this medicine until {when}.", "Pause esta medicina hasta {when}.", ["when"]),
 "msgNewDirections": ("Same medicine, new directions: {sig}", "La misma medicina, nuevas instrucciones: {sig}", ["sig"]),
 "msgOldStrength": ("Your dose changed. Don't use this bottle until a pharmacist confirms.", "Su dosis cambió. No use este frasco hasta que un farmacéutico lo confirme."),
 "msgMatch": ("Keep taking this as before: {sig}", "Siga tomándola como antes: {sig}", ["sig"]),
 "msgMismatch": ("This bottle doesn't match your plan. Ask your pharmacist before taking.", "Este frasco no coincide con su plan. Pregunte a su farmacéutico antes de tomarla."),
 "msgNewMed": ("This is a new medicine: {sig}", "Esta es una medicina nueva: {sig}", ["sig"]),
 "msgNewMedMismatch": ("This doesn't match the new medicine on your plan. Ask your pharmacist.", "No coincide con la medicina nueva de su plan. Pregunte a su farmacéutico."),
 "msgDuplicate": ("This may do the same job as {planMed}. Don't take both. Ask your care team.", "Puede hacer lo mismo que {planMed}. No tome ambas. Pregunte a su equipo de salud.", ["planMed"]),
 "msgNotOnPlan": ("This isn't on your discharge plan. Ask before taking it.", "No está en su plan de alta. Pregunte antes de tomarla."),
 "msgComboPartial": ("This bottle has more than one medicine. Ask your pharmacist before taking.", "Este frasco tiene más de una medicina. Pregunte a su farmacéutico antes de tomarla."),
 "msgSigUnsupported": ("These directions are complex. Ask your pharmacist how to take it.", "Estas instrucciones son complejas. Pregunte a su farmacéutico cómo tomarla."),
 "askPharmacist": ("Ask your pharmacist", "Pregunte a su farmacéutico"),
 "fromYourPapers": ("From your discharge papers:", "De sus papeles del alta:"),
 "readAloud": ("Read aloud", "Leer en voz alta"), "addToQuestions": ("Add to my questions", "Agregar a mis preguntas"), "scanNext": ("Scan next", "Escanear otro"),
 "setAside": ("I've set this bottle aside", "Ya aparté este frasco"),
 "emptyToday": ("Let's set up your medicines. Scan your discharge papers to start.", "Preparemos sus medicinas. Escanee sus papeles del alta para empezar."),
 "scanPapers": ("Scan discharge papers", "Escanear papeles del alta"),
 "scanHint": ("Hold the bottle in the box. Turn it slowly.", "Sostenga el frasco dentro del recuadro. Gírelo despacio."),
 "lowConfidenceRead": ("We couldn't read this clearly. Try again, or type it in.", "No pudimos leer esto bien. Intente de nuevo o escríbalo."),
 "markedTaken": ("Marked as taken.", "Marcada como tomada."), "undo": ("Undo", "Deshacer"),
 "missedPrompt": ("You haven't marked your {time} medicines. Take them now, or skip?", "No ha marcado sus medicinas de las {time}. ¿Tomarlas ahora u omitirlas?", ["time"]),
 "offline": ("You're offline. Everything still works on this phone.", "Está sin conexión. Todo sigue funcionando en este teléfono."),
 "savedOnPhone": ("Saved on this phone", "Guardado en este teléfono"),
 "stopShort": ("Don't take this. Your care team stopped it.", "No tome esto. Su equipo de salud la suspendió."),
 "needsAttention": ("{count, plural, =1{1 medicine needs attention} other{{count} medicines need attention}}", "{count, plural, =1{1 medicina requiere atención} other{{count} medicinas requieren atención}}", ["count:int"]),
 "review": ("Review", "Revisar"),
 "nextDose": ("Next dose", "Próxima dosis"), "taken": ("Taken", "Tomada"), "skip": ("Skip", "Omitir"), "skipped": ("Skipped", "Omitida"),
 "takenOfTotal": ("{taken} of {total} taken today", "{taken} de {total} tomadas hoy", ["taken:int", "total:int"]),
 "slotMorning": ("Morning", "Mañana"), "slotNoon": ("Noon", "Mediodía"), "slotAfternoon": ("Afternoon", "Tarde"), "slotEvening": ("Evening", "Noche"), "slotBedtime": ("Bedtime", "Al acostarse"),
 "asNeededMax": ("As needed, no more than {n} a day", "Si es necesario, no más de {n} al día", ["n:int"]),
 "asNeeded": ("As needed", "Si es necesario"),
 "reviewPlan": ("Review your plan", "Revise su plan"), "looksRight": ("Looks right", "Está bien"), "checkThis": ("Check this", "Revise esto"),
 "linesWeCouldntRead": ("Lines we couldn't read", "Líneas que no pudimos leer"),
 "chipNew": ("New", "Nuevas"), "chipChanged": ("Changed", "Cambiadas"), "chipKeep": ("Keep taking", "Siga tomando"), "chipPaused": ("Paused", "En pausa"), "chipStopped": ("Stopped", "Suspendidas"),
 "isThisYourMedicine": ("Is this your medicine?", "¿Es esta su medicina?"), "yes": ("Yes", "Sí"), "notThisOne": ("Not this one", "No es esta"),
 "whichOne": ("Which medicine is this?", "¿Cuál medicina es esta?"), "neither": ("Neither", "Ninguna"),
 "typeItInstead": ("Type it instead", "Escribirlo"),
 "bottlesChecked": ("{checked} of {total} bottles checked", "{checked} de {total} frascos revisados", ["checked:int", "total:int"]),
 "scanned": ("Scanned ✓", "Escaneado ✓"), "notScannedYet": ("Not scanned yet", "Aún no escaneado"),
 "pickUpFromPharmacy": ("Pick up from pharmacy", "Recoger en la farmacia"),
 "addedForYou": ("Added for you", "Agregada para usted"), "addQuestion": ("Add a question", "Agregar una pregunta"),
 "shareWithDoctor": ("Share with my doctor", "Compartir con mi médico"), "answered": ("Answered", "Respondida"), "waitingForAnswer": ("Waiting for an answer", "Esperando respuesta"),
 "careTeam": ("Care team", "Equipo de salud"), "invite": ("Invite", "Invitar"), "remove": ("Remove", "Quitar"),
 "inviteCodeIs": ("Share this code: {code}", "Comparta este código: {code}", ["code"]),
 "enterInviteCode": ("Enter an invite code", "Escriba un código de invitación"),
 "viewingMeds": ("Viewing {name}'s medicines", "Viendo las medicinas de {name}", ["name"]),
 "settings": ("Settings", "Ajustes"), "textSize": ("Text size", "Tamaño del texto"), "language": ("Language", "Idioma"),
 "speechRate": ("Read-aloud speed", "Velocidad de lectura"), "theme": ("Theme", "Tema"), "themeLight": ("Light", "Claro"), "themeDark": ("Dark", "Oscuro"), "themeHighContrast": ("High contrast", "Alto contraste"),
 "signOut": ("Sign out", "Cerrar sesión"), "signIn": ("Sign in", "Iniciar sesión"),
 "stepOf": ("Step {step} of {total}", "Paso {step} de {total}", ["step:int", "total:int"]),
 "chooseLanguage": ("Choose your language", "Elija su idioma"),
 "whoAreYou": ("Who is using MedBridge?", "¿Quién usa MedBridge?"), "rolePatient": ("I'm the patient", "Soy el paciente"), "roleCaregiver": ("I help someone", "Ayudo a alguien"),
 "yourFirstName": ("Your first name", "Su nombre"),
 "textSizePreview": ("This is how text will look.", "Así se verá el texto."),
 "cameraPrimer": ("We use the camera only to read labels. Photos are never saved.", "Usamos la cámara solo para leer etiquetas. Nunca guardamos fotos."),
 "notificationPrimer": ("We'll remind you when it's time for your medicines. Reminders never show medicine names unless you choose.", "Le recordaremos cuando sea hora de sus medicinas. Los recordatorios no muestran nombres de medicinas a menos que usted lo elija."),
 "allergiesOptional": ("Any allergies? (optional)", "¿Alguna alergia? (opcional)"),
 "continueLabel": ("Continue", "Continuar"), "back": ("Back", "Atrás"), "done": ("Done", "Listo"), "save": ("Save", "Guardar"), "cancel": ("Cancel", "Cancelar"), "tryAgain": ("Try again", "Intentar de nuevo"),
 "addPage": ("Add page", "Agregar página"), "pages": ("{count, plural, =1{1 page} other{{count} pages}}", "{count, plural, =1{1 página} other{{count} páginas}}", ["count:int"]),
 "pasteOrType": ("Type or paste the text from your papers", "Escriba o pegue el texto de sus papeles"),
 "useSampleR": ("Use the sample papers (R. Doe)", "Usar los papeles de ejemplo (R. Doe)"),
 "pendingTranslatorReview": ("Spanish text is a draft pending medical-translator review.", "El texto en español es un borrador pendiente de revisión por un traductor médico."),
 "verified": ("Checked by a pharmacist", "Revisado por un farmacéutico"), "unverified": ("Not yet checked by a pharmacist", "Aún no revisado por un farmacéutico"),
 "errorGeneric": ("Something went wrong. Your plan still works on this phone.", "Algo salió mal. Su plan sigue funcionando en este teléfono."),
 "noInternet": ("No internet. Your plan still works on this phone.", "Sin internet. Su plan sigue funcionando en este teléfono."),
 "highRiskBadge": ("High-alert medicine", "Medicina de alto riesgo"), "interactionBanner": ("May interact with another medicine: {detail}", "Puede interactuar con otra medicina: {detail}", ["detail"]),
 "allergyBlock": ("Allergy alert. Don't take this until your care team says it's safe.", "Alerta de alergia. No la tome hasta que su equipo de salud diga que es seguro."),
 "lasaBadge": ("Name looks like another medicine", "El nombre se parece al de otra medicina"),
 "writeStopOnCap": ("Tip: write STOP on the cap.", "Consejo: escriba ALTO en la tapa."),
 "untilFollowUp": ("your follow-up visit", "su próxima cita"),
 "dashPatients": ("Patients", "Pacientes"), "dashFlags": ("Flagged scans", "Escaneos marcados"), "dashInbox": ("Questions", "Preguntas"), "dashVerify": ("Verify plan", "Verificar plan"), "dashSummary": ("Summary", "Resumen"),
 "redCount": ("{n} red", "{n} rojo", ["n:int"]), "amberCount": ("{n} amber", "{n} ámbar", ["n:int"]),
 "answer": ("Answer", "Responder"), "verify": ("Verify", "Verificar"), "resolve": ("Mark reviewed", "Marcar revisado"),
 "density": ("Compact rows", "Filas compactas"), "sessionExpired": ("Signed out after 15 minutes idle.", "Sesión cerrada tras 15 minutos de inactividad."),
}
def ph(names):
    out = {}
    for n in names:
        name, _, t = n.partition(":")
        out[name] = {"type": t or "String"}
    return out
for lang, idx in (("en", 0), ("es", 1)):
    arb = {"@@locale": lang}
    for k, v in S.items():
        arb[k] = v[idx]
        if lang == "en" and len(v) > 2:
            arb["@" + k] = {"placeholders": ph(v[2])}
    if lang == "es":
        arb["@@x-status"] = "draft pending medical-translator review"
    json.dump(arb, open(f"lib/l10n/app_{lang}.arb", "w"), ensure_ascii=False, indent=2)
print(len(S), "keys")
