# AttituTED Corpus

**A bilingual (English–German) corpus of TED Talks annotated for evaluative language (Appraisal / Attitude), built for the LREC 2026 paper *"EmotionalizTED Corpus"*.**

AttituTED-Corpus supports the study of how speakers express **attitude, opinion, and evaluation** (in the sense of Appraisal Theory) across ten academic/topical disciplines, and how that evaluative language behaves under **human translation** from English into German — as well as how it compares to **originally-German** TED Talks on the same topics.

---

## 📦 What's in the corpus

| Sub-corpus | Language | Description |
|---|---|---|
| **English TED Talks** | English (original) | Transcripts of English-language TED Talks, one folder per discipline |
| **German translations** | German (translated) | The official German translations of the *same* English talks above |
| **German TED Talks** | German (original) | An independent set of TED Talks originally delivered in German |

This three-way design (EN original → DE translation, plus DE original) makes the corpus suited for **translation/implicitation studies**, **cross-linguistic appraisal comparison**, and **discipline- and gender-based register analysis**.

### Disciplines covered

Each sub-corpus is split into the same 11 topical categories:

`Art` · `Business` · `Education` · `Entertainment` · `History` · `Medicine` · `Philosophy` · `Politics and Law` · `Psychology` · `Science` · `Technology`

### Corpus size (from `conllu_discipline_summary.csv`)

~190 talks per language (English originals / German translations), roughly evenly spread across disciplines (15–25 talks each), totaling **380 annotated documents** and hundreds of thousands of tokens. Per-file statistics for every single talk (tokens, sentences, adjective/token pairs, etc.) are available in [`conllu_text_summary.csv`](./conllu_text_summary.csv), and per-discipline aggregates in [`conllu_discipline_summary.csv`](./conllu_discipline_summary.csv).

---

## 📁 Repository structure

```
AttituTED-Corpus/
├── conllu_file/                       # Core linguistic corpus, CoNLL-U (UD) format
│   ├── English Ted Talk/
│   │   ├── en/                        # English originals, one folder per discipline
│   │   └── German Translations/       # German translations of the same talks
│   └── German Ted talk Transcripts/   # Independent, originally-German TED Talks
│
├── data/                              # Raw & classified transcripts
│   ├── German Ted Talk Transcripts/           # Plain-text .txt transcripts (by discipline)
│   ├── German Ted Talk Transcripts_classified_excels/
│   └── Appraisal classification/              # Per-discipline Appraisal-tagged spreadsheets
│
├── python scripts/                    # Corpus-building & analysis notebooks
│   ├── Process_conllu_files_LREC2026_EmotionalizTED_Corpus (3).ipynb   # Transcript → UD/CoNLL-U (Stanza)
│   ├── word_alignment_LREC2026_EmotionalizTED_Corpus.ipynb             # EN↔DE word alignment (SimAlign)
│   ├── Appraisal_recognition.ipynb                                     # Rule-based Attitude classification
│   ├── Analysis_EN_DE_LREC2026_EmotionalizTED_Corpus.ipynb             # EN vs. DE(translated) analysis
│   └── Analysis_DE_LREC2026_EmotionalizTED_Corpus.ipynb                # DE(original) analysis
│
├── NEW analysis/                      # Follow-up notebooks: implicitation study, adjective-level
│   │                                   # comparison (original vs. translated German), MCA plots
│   ├── German translations - data for implicitation study*.zip
│   ├── English adjectives/            # Per-adjective annotated spreadsheets
│   └── MCA/                           # Multiple Correspondence Analysis plots (SVG)
│
├── plots_analysis/                    # Generated figures & summary tables
│   ├── English Ted Talk/
│   │   ├── Appraisal Analysis/        # Attitude-type distributions, gender comparisons, word alignment
│   │   ├── General Plots/             # Token/sentence length distributions (box plots, histograms)
│   │   ├── plots_adjectives/          # Top adjectives per discipline / language
│   │   └── plots_content_words/       # Content-word / POS proportions
│   └── German Ted Talk/               # Equivalent plots for the original-German sub-corpus
│
├── main.ipynb                                     # Appraisal-adjective extraction pipeline
├── chronological_years_of_English_TED_talks.ipynb # Publication-year distribution of the English talks
├── German_original_TED_talks.xlsx                 # Metadata for the original German talks
├── conllu_discipline_summary.csv                  # Corpus statistics aggregated by discipline
└── conllu_text_summary.csv                        # Corpus statistics per individual file
```

> Some folders also contain `.zip` archives of the same content (e.g. `German Ted talk Transcripts.zip`, `English adjectives.zip`) — these are convenience bundles, typically produced when working in Google Colab, and mirror the extracted folders next to them.

---

## 🧪 Methodology

1. **Transcription & collection** — TED Talk transcripts (English, German translations, and independent German talks) are collected per discipline.
2. **Linguistic annotation** — transcripts are parsed into **CoNLL-U / Universal Dependencies** format using [Stanza](https://stanfordnlp.github.io/stanza/), giving tokenization, lemmatization, POS tags, and dependency relations for every sentence (`python scripts/Process_conllu_files_LREC2026_EmotionalizTED_Corpus (3).ipynb`).
3. **Cross-lingual word alignment** — English–German sentence pairs are aligned at the word level with [SimAlign](https://github.com/cisnlp/simalign), enabling adjective-by-adjective comparison between an English talk and its German translation (`python scripts/word_alignment_LREC2026_EmotionalizTED_Corpus.ipynb`).
4. **Appraisal / Attitude classification** — evaluative adjectives are extracted and classified into **Appraisal Theory** categories (Affect / Judgement / Appreciation, per Martin & White) using pattern-based heuristics over dependency structure (subject person, copular/"feel" verbs, appreciation pronouns, etc.), producing confidence-thresholded classifications with example sentences (`main.ipynb`, `Appraisal_recognition.ipynb`).
5. **Comparative analysis** — downstream notebooks compare:
   - English originals vs. their German translations vs. independently-authored German talks,
   - Attitude-type distribution by **discipline**,
   - Attitude-type distribution by **speaker gender**,
   - general register statistics (tokens/sentence, content-word/POS proportions), visualized via the plots and CSVs in `plots_analysis/`.

---

## 🚀 Getting started

The notebooks were built for Google Colab, but run anywhere with the right packages:

```bash
pip install stanza simalign pandas scipy tqdm
```

Typical workflow:
1. Point a `Process_conllu_files_*` notebook at the raw transcripts in `data/` to (re)generate the `conllu_file/` CoNLL-U corpus.
2. Run `word_alignment_LREC2026_EmotionalizTED_Corpus.ipynb` to produce English–German adjective alignments.
3. Run `main.ipynb` / `Appraisal_recognition.ipynb` to classify adjectives into Appraisal categories.
4. Use the `Analysis_*` and `NEW analysis/` notebooks to reproduce the discipline-, gender-, and translation-level comparisons and plots.

---

## 📊 Key outputs

- **`conllu_discipline_summary.csv` / `conllu_text_summary.csv`** — corpus-wide token/sentence statistics.
- **`plots_analysis/`** — ready-made figures (top adjectives, appraisal-type distributions, POS proportions, length distributions) for both the English/translated-German and original-German sub-corpora.
- **`NEW analysis/`** — the implicitation study comparing how attitude is made explicit or implicit across original vs. translated German, plus Multiple Correspondence Analysis (MCA) plots of translation strategies.

---
