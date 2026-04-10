# Automated Misconception Classifier
## Fine-tuned ELECTRA with LLM-driven Synthetic Data Generation

![Python](https://img.shields.io/badge/Python-3.10-blue)
![HuggingFace](https://img.shields.io/badge/HuggingFace-ELECTRA-yellow)
![LLM](https://img.shields.io/badge/LLM-Qwen2.5-green)
![Accuracy](https://img.shields.io/badge/Accuracy-99%25-brightgreen)
![F1](https://img.shields.io/badge/Macro_F1-0.944-brightgreen)

---

## The Problem

Automatically classify student mathematical misconceptions from
free-text explanations. Real educational datasets suffer from
**extreme class imbalance** - the rarest misconception category
appeared only once for every 14,800 majority-class samples.

---

## Pipeline Architecture

```
Raw Student Text
    |
    v  [Qwen LLM] Fix encoding errors and standardize notation
    |
    v  [Qwen LLM] Generate 113,000+ synthetic minority samples
    |
    v  Composite Label Creation
       (Answer Correctness + Category + Misconception = 1 label)
    |
    v  ELECTRA Fine-tuning
       (gradient accumulation + early stopping)
    |
    v  Validation on 36,696 original non-synthetic samples
```

## Results
| Metric | Score |
|--------|-------|
| Composite Label Accuracy | **99.00%** |
| Weighted F1-Score | **0.9900** |
| Macro F1-Score | **0.9441** |
| Total Validation Samples | 36,696 (original only) |
| Classes Predicted | 65 composite labels |

Validation used **only original data** - synthetic samples were
strictly kept in training. This ensures realistic performance
measurement on real student responses.

## Component-Wise Accuracy

| Component | Accuracy |
|-----------|----------|
| Answer Correctness (True/False) | 99.48% |
| Category (Correct/Neither/Misconception) | 99.27% |
| Misconception Name (34 types + NA) | 99.41% |

- 42 out of 65 labels achieved 100% accuracy
- Macro F1 of 0.9441 confirms strong performance on rare
  minority classes, not just majority

---

## Tech Stack

| Tool | Purpose |
|------|---------|
| google/electra-base-discriminator | Classification model |
| Qwen/Qwen2.5-0.5B-Instruct | Text cleaning + augmentation |
| HuggingFace Transformers | Fine-tuning framework |
| scikit-learn | Evaluation metrics |
| Python 3.10 | Core language |
| Google Colab | Training environment |

---
## Dataset

Source: Kaggle Competition -
MAP: Charting Student Math Misunderstandings

- Training samples: 36,696 original + 113,000+ synthetic
- Misconception categories: 34 unique types
- Composite labels: 65 total

---
## Key Technical Decisions

**Why Composite Labels?**
Predicting a single combined label such as
False_Misconception:Additive instead of three separate outputs
simplified the architecture while preserving full label
granularity.

**Why LLM for Augmentation vs SMOTE?**
Text data cannot be interpolated numerically. Qwen generates
semantically valid new student explanations that preserve the
student's reasoning patterns rather than creating artificial
vector interpolations.
**Why ELECTRA over BERT?**
ELECTRA's replaced token detection pre-training makes it more
sample-efficient and better at detecting subtle linguistic
differences in student reasoning.

---

## View Full Notebook

Open in Google Colab (all outputs visible):
https://colab.research.google.com/github/SuruCodes68/data-science-and-analytics-projects/blob/main/Automated-misconception-classifier/LLM_Augmented_Misconception_Classifier.ipynb

---

## Author

Suranjana Aryal
LinkedIn: https://www.linkedin.com/in/suranjana-aryal
GitHub: https://github.com/SuruCodes68