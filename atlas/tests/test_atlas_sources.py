from __future__ import annotations

import importlib.util
import json
import re
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def load_script(name: str):
    path = ROOT / "scripts" / f"{name}.py"
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    assert spec.loader
    spec.loader.exec_module(module)
    return module


validator = load_script("validate_atlas")
packet_builder = load_script("build_run_packet")


class AtlasSourceTests(unittest.TestCase):
    def test_validation_passes(self):
        self.assertEqual([], validator.validate())

    def test_manifest_has_exactly_25_sources(self):
        manifest = json.loads((ROOT / "config/modules.json").read_text())
        self.assertEqual(25, manifest["source_count"])
        self.assertEqual(list(range(25)), [m["id"] for m in manifest["modules"]])

    def test_atlas_weights_sum_to_one(self):
        text = (ROOT / "config/scoring.yaml").read_text()
        block = text.split("atlas_weights:\n", 1)[1].split("\nrisk_penalties_max_points:", 1)[0]
        values = [float(x) for x in re.findall(r": (0\.\d+)\n", block)]
        self.assertAlmostEqual(1.0, sum(values), places=8)

    def test_stealth_weights_sum_to_one(self):
        text = (ROOT / "config/scoring.yaml").read_text()
        block = text.split("stealth_score_weights:\n", 1)[1].split("\nfiscal_transmission_weights:", 1)[0]
        values = [float(x) for x in re.findall(r": (0\.\d+)\n", block)]
        self.assertAlmostEqual(1.0, sum(values), places=8)

    def test_deep_packet_loads_all_sources(self):
        packet = packet_builder.build_packet("deep", "test", [])
        self.assertEqual(25, packet.count("## Source "))

    def test_daily_packet_routes_domains(self):
        packet = packet_builder.build_packet("daily", "test", ["power_grid_utility"])
        self.assertIn("## Source 10:", packet)
        self.assertNotIn("## Source 12:", packet)


if __name__ == "__main__":
    unittest.main()
