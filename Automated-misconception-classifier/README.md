# Conceptual Workflow

This project tackles the challenge of automatically identifying specific mathematical misconceptions students have based on their free-text explanations for multiple-choice answers. The core problem is that real-world educational data often has a severe class imbalance: common misconceptions are frequent, while many specific ones are rare, making it hard for a standard machine learning model to learn the rare ones.



Here’s the thought process and how the implementation addresses it:



**Problem Definition:** We need to classify student explanations into categories, including identifying specific misconceptions. The target isn't just one label, but multiple pieces of information (answer correctness, category, misconception type).



**Initial Idea - Simplify the Target:** Instead of predicting three separate things, combine them into a single composite label (e.g., False_Misconception:Additive). This turns it into a standard multi-class classification problem.



**Data Quality Issue:** Real student text is messy. It contains typos, grammatical errors, and sometimes character encoding problems ("mojibake"). Standard NLP models struggle with inconsistent input.



**Solution - LLM for Cleaning:** Use a Large Language Model (LLM), specifically Qwen, which is good at understanding and manipulating text, to revise the student explanations. The key here is careful prompting: instruct the LLM to fix only objective errors (encoding, spelling, basic grammar) and strictly forbid it from changing the student's core meaning, phrasing, or logical flow. This standardizes the text without altering the underlying reasoning (or lack thereof).



**Data Quantity Issue (Imbalance):** Many misconception categories have very few examples. A model trained on this data will be biased towards the majority classes and perform poorly on rare misconceptions.



**Solution - LLM for Augmentation:** Use the same LLM (Qwen) to generate synthetic data for the minority classes. Again, prompting is key: provide the LLM with details of an existing example (question, student's answer, correctness, category, misconception) and ask it to generate a new, unique explanation that fits the same pattern. This creates more training examples for rare categories, helping to balance the dataset.



**Modeling Choice:** We need a model good at understanding text nuances for classification. A pre-trained transformer model like ELECTRA is suitable. It's already been trained on vast amounts of text and can be adapted (fine-tuned) for this specific task.



**Training:** Fine-tune the ELECTRA model on the combined dataset (original cleaned data + synthetic augmented data) to predict the composite labels. Use standard deep learning techniques like batching, gradient accumulation (to simulate larger batches), and evaluation metrics (accuracy, F1-score). Use early stopping to prevent overfitting.



**Evaluation:**



- Evaluate the fine-tuned model on a held-out validation set consisting only of original, unaugmented data. This gives a realistic measure of performance on real-world examples.



- Analyze performance not just on the composite label, but also by parsing the predicted composite label back into its components (Answer Correctness, Category, Misconception) to see how well the model performs on each aspect individually.



- Perform weight analysis comparing the original ELECTRA weights to the fine-tuned weights to understand which parts of the model changed most during training.

This multi-stage approach uses the strengths of LLMs for data preparation (cleaning messy text and balancing classes) and the strengths of a fine-tuned transformer (ELECTRA) for the final nuanced classification task.
