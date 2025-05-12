# RTL-training-dataset
This repository contains a large-scale dataset of Verilog hardware description language (HDL) code, which can be used for instruction-tuned AI models to enhance Verilog code generation and synthesis tasks. The dataset includes tens of thousands of Verilog files, covering various digital circuit designs.
This repository hosts two RTL datasets curated for training large language models to synthesize Verilog modules from partial specifications.


📁 Dataset Structure
├── cpuv     # Original dataset (CPUV)
├── cpursv   # Rewritten dataset (CPURSV)
└── README.md


📦 Dataset Descriptions
🔹 CPUV (Original)
Source: Collected from open-source CPU-related RTL designs.
Contents: ~20,000 Verilog modules after syntax verification with Yosys.
Purpose: Serves as the baseline dataset for training.


🔹 CPURSV (Rewritten)
Description: For each module in CPUV, several semantically equivalent RTL variants are generated using a rule-based rewriting engine.
Size: ~4.5× larger than CPUV (~20,000 modules).
Purpose: To study the effect of RTL-level augmentation on model training performance.


🧪 Usage
Each .v file corresponds to a valid Verilog module. Files in cpursv are grouped by rewrite family and retain 1-to-1 semantic equivalence with cpuv.


📊 Applications
These datasets were used in experiments demonstrating that:
Rewritten RTL significantly improves training convergence (lower loss).
Models trained on CPURSV outperform those trained on CPUV on the RTLLM_v2.0 benchmark, both in syntax and functionality pass rates.
