(function (root) {
  const FIELD_LABELS = {
    visitType: "visit type",
    visitDate: "date/time",
    patientAlias: "patient alias or initials",
    primaryProblem: "primary problem",
    subjective: "subjective report",
    objective: "vitals/objective findings",
    interventions: "skilled interventions",
    medications: "medication changes or concerns",
    wounds: "wounds/measurements/treatment",
    teaching: "teaching provided",
    response: "patient/caregiver response",
    coordination: "care coordination",
    followUp: "follow-up plan",
    uncertainty: "uncertainty or not assessed"
  };

  const REQUIRED_FIELDS = ["visitType", "visitDate", "patientAlias", "subjective", "objective", "interventions"];

  function normalize(value) {
    return String(value || "").trim().replace(/\s+/g, " ");
  }

  function hasText(value) {
    return normalize(value).length > 0;
  }

  function sentence(value, fallback) {
    const text = normalize(value);
    if (!text) return fallback;
    return /[.!?]$/.test(text) ? text : `${text}.`;
  }

  function formatListItem(value) {
    const text = normalize(value);
    return text ? `- ${text}` : "- Nurse to review and complete.";
  }

  function collectFormData(form) {
    return Object.keys(FIELD_LABELS).reduce((data, field) => {
      const control = form.elements[field];
      data[field] = control ? control.value : "";
      return data;
    }, {});
  }

  function detectPainContradiction(data) {
    const combined = `${data.subjective || ""} ${data.objective || ""}`.toLowerCase();
    const saysNoPain = /\b(no|denies)\s+pain\b/.test(combined);
    const hasPainScore = /\bpain\s*(level|score)?\s*[:=]?\s*([4-9]|10)\s*\/\s*10\b/.test(combined);
    return saysNoPain && hasPainScore;
  }

  function runQaChecks(data) {
    const flags = [];

    REQUIRED_FIELDS.forEach((field) => {
      if (!hasText(data[field])) {
        flags.push(`Missing ${FIELD_LABELS[field]}.`);
      }
    });

    if (hasText(data.wounds)) {
      ["location", "measurement", "treatment", "response"].forEach((term) => {
        if (!new RegExp(term, "i").test(data.wounds)) {
          flags.push(`Wound note should confirm ${term}.`);
        }
      });
    }

    if (hasText(data.medications) && !hasText(data.coordination) && /change|new|held|missed|concern|issue|interaction/i.test(data.medications)) {
      flags.push("Medication concern needs documented follow-up or care coordination.");
    }

    if (hasText(data.teaching) && !hasText(data.response)) {
      flags.push("Teaching is documented without patient/caregiver response or teach-back.");
    }

    if (hasText(data.interventions) && !/response|improved|verbalized|demonstrated|tolerated|notified|instructed/i.test(data.interventions + " " + data.response)) {
      flags.push("Intervention response should be documented before final use.");
    }

    if (detectPainContradiction(data)) {
      flags.push("Possible contradiction: both no pain and a moderate/high pain score are documented.");
    }

    if (/tolerated well/i.test(`${data.interventions || ""} ${data.response || ""}`) && !hasText(data.response)) {
      flags.push("Avoid unsupported 'tolerated well' language unless response details are provided.");
    }

    if (hasText(data.uncertainty)) {
      flags.push("Resolve stated uncertainty before copying into Kinnser.");
    }

    return flags.length ? flags : ["No missing required fields detected. Nurse must still verify all facts before manual entry."];
  }

  function generateDraft(data) {
    const patient = normalize(data.patientAlias) || "[patient alias]";
    const visitType = normalize(data.visitType) || "[visit type]";
    const visitDate = normalize(data.visitDate) || "[date/time]";
    const problem = normalize(data.primaryProblem) || "the documented skilled need";

    return {
      narrative: [
        `${visitType} completed on ${visitDate} for ${patient} related to ${problem}.`,
        sentence(data.subjective, "Subjective report requires nurse completion."),
        sentence(data.objective, "Objective findings and vitals require nurse completion."),
        sentence(data.interventions, "Skilled interventions require nurse completion."),
        data.wounds ? sentence(data.wounds, "") : "No wound details were entered for this draft."
      ].filter(Boolean).join("\n\n"),
      teaching: [
        sentence(data.teaching, "Teaching provided requires nurse completion."),
        sentence(data.response, "Patient/caregiver response or teach-back requires nurse completion.")
      ].join("\n\n"),
      medications: sentence(data.medications, "No medication concerns were entered. Nurse must verify medication reconciliation details."),
      coordination: sentence(data.coordination, "No care coordination was entered. Nurse to document calls, messages, orders, or notifications if performed."),
      followUp: [
        formatListItem(data.followUp),
        data.uncertainty ? `- Resolve uncertainty: ${normalize(data.uncertainty)}` : "- Verify vitals, medications, wounds, orders, and patient response before manual entry.",
        "- Nurse performs final Kinnser validation, signature, and submission manually."
      ].join("\n"),
      qaFlags: runQaChecks(data)
    };
  }

  function renderDraft(draft, doc) {
    doc.getElementById("draftNarrative").value = draft.narrative;
    doc.getElementById("draftTeaching").value = draft.teaching;
    doc.getElementById("draftMeds").value = draft.medications;
    doc.getElementById("draftCoordination").value = draft.coordination;
    doc.getElementById("draftFollowUp").value = draft.followUp;

    const qaList = doc.getElementById("qa-list");
    qaList.innerHTML = "";
    draft.qaFlags.forEach((flag) => {
      const item = doc.createElement("li");
      item.textContent = flag;
      qaList.appendChild(item);
    });
  }

  function approvedDraftText(doc) {
    return [
      "Draft visit narrative:",
      doc.getElementById("draftNarrative").value,
      "",
      "Teaching and response:",
      doc.getElementById("draftTeaching").value,
      "",
      "Medication concerns:",
      doc.getElementById("draftMeds").value,
      "",
      "Care coordination:",
      doc.getElementById("draftCoordination").value,
      "",
      "Follow-up checklist:",
      doc.getElementById("draftFollowUp").value
    ].join("\n");
  }

  function bindUi(doc) {
    const form = doc.getElementById("visit-form");
    if (!form) return;

    const approval = doc.getElementById("clinician-approved");
    const copyButton = doc.getElementById("copy-button");

    form.addEventListener("submit", (event) => {
      event.preventDefault();
      const draft = generateDraft(collectFormData(form));
      renderDraft(draft, doc);
      approval.checked = false;
      copyButton.disabled = true;
    });

    doc.getElementById("clear-button").addEventListener("click", () => {
      form.reset();
      ["draftNarrative", "draftTeaching", "draftMeds", "draftCoordination", "draftFollowUp"].forEach((id) => {
        doc.getElementById(id).value = "";
      });
      doc.getElementById("qa-list").innerHTML = "<li>Generate a draft to run completeness checks.</li>";
      approval.checked = false;
      copyButton.disabled = true;
    });

    approval.addEventListener("change", () => {
      copyButton.disabled = !approval.checked;
    });

    copyButton.addEventListener("click", async () => {
      if (!approval.checked) return;
      await navigator.clipboard.writeText(approvedDraftText(doc));
      copyButton.textContent = "Copied";
      setTimeout(() => {
        copyButton.textContent = "Copy approved draft";
      }, 1600);
    });
  }

  const api = { generateDraft, runQaChecks, detectPainContradiction, normalize };

  if (typeof module !== "undefined" && module.exports) {
    module.exports = api;
  } else {
    root.KinnserDrafting = api;
    bindUi(root.document);
  }
})(typeof window !== "undefined" ? window : globalThis);
