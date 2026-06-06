const assert = require("node:assert/strict");
const { generateDraft, runQaChecks, detectPainContradiction } = require("../src/app.js");

const completeVisit = {
  visitType: "Skilled nursing visit",
  visitDate: "06/06/2026 10:00 AM",
  patientAlias: "AB",
  primaryProblem: "medication teaching",
  subjective: "Patient reports feeling better and denies shortness of breath.",
  objective: "Vitals within agency parameters. Lungs clear.",
  interventions: "Reviewed medication schedule and instructed caregiver on daily weights.",
  medications: "No medication concerns reported.",
  wounds: "",
  teaching: "Taught low sodium diet and daily weight log.",
  response: "Caregiver verbalized understanding and demonstrated use of log.",
  coordination: "No calls required today.",
  followUp: "Continue daily weight log and call agency for weight gain per parameters.",
  uncertainty: ""
};

function test(name, fn) {
  try {
    fn();
    console.log(`ok - ${name}`);
  } catch (error) {
    console.error(`not ok - ${name}`);
    throw error;
  }
}

test("generates editable draft sections from entered facts", () => {
  const draft = generateDraft(completeVisit);
  assert.match(draft.narrative, /Skilled nursing visit completed on 06\/06\/2026 10:00 AM for AB/);
  assert.match(draft.teaching, /low sodium diet/);
  assert.match(draft.followUp, /final Kinnser validation/);
});

test("flags missing required encounter fields", () => {
  const flags = runQaChecks({ ...completeVisit, visitDate: "", objective: "" });
  assert.deepEqual(flags.filter((flag) => /Missing/.test(flag)), [
    "Missing date/time.",
    "Missing vitals/objective findings."
  ]);
});

test("flags teaching without response", () => {
  const flags = runQaChecks({ ...completeVisit, response: "" });
  assert.ok(flags.includes("Teaching is documented without patient/caregiver response or teach-back."));
});

test("detects no-pain and high-pain contradiction", () => {
  const data = {
    subjective: "Patient denies pain.",
    objective: "Pain score 8/10 at wound site."
  };
  assert.equal(detectPainContradiction(data), true);
});

test("flags medication concern without coordination", () => {
  const flags = runQaChecks({
    ...completeVisit,
    medications: "New dizziness concern after medication change.",
    coordination: ""
  });
  assert.ok(flags.includes("Medication concern needs documented follow-up or care coordination."));
});
