\# Netflix Content-Based Recommender System



This project is a content-based recommendation system built in Python using a \[Netflix titles dataset from Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows). The system analyzes the text data (title, genre, description) of over 8,800 movies and TV shows to recommend content with the most similar themes and plots.



\## Features



\* \*\*Content-Based Recommendations:\*\* Suggests titles based on similarities in their title, genre, and description.

\* \*\*Type Filtering:\*\* Allows users to filter recommendations to see only "Movies" or only "TV Shows."

\* \*\*Mixed Recommendations:\*\* A helper function provides a balanced list of both movies and TV shows.

\* \*\*Explainability:\*\* Includes a function to extract and display the top keywords (features) that link a query title to its recommendations, explaining \*why\* they are considered similar.

\* \*\*Data Visualization:\*\* Includes exploratory data analysis (EDA) of genre distributions, content types, and release trends, as well as a t-SNE plot to visualize the entire content catalog in 2D.



\## Methodology



The recommender system is built using a standard Natural Language Processing (NLP) and machine learning pipeline:



1\.  \*\*Data Loading \& Cleaning:\*\* The `Netflixdata.csv` is loaded into a pandas DataFrame.

2\.  \*\*Exploratory Data Analysis (EDA):\*\* The dataset is analyzed to find key insights:

&nbsp;   \* The catalog consists of \*\*~70% Movies and 30% TV Shows\*\*.

&nbsp;   \* The \*\*US and India\*\* are the top production countries.

&nbsp;   \* Content releases grew exponentially after 2010, peaking around 2018.

&nbsp;   \* The "Movies vs. TV Shows" time-series plot shows that while movie additions have slowed, TV show additions have accelerated, nearly closing the gap by 2020.

3\.  \*\*Feature Engineering:\*\* A unified "content" field is created for each title by concatenating its `title`, `listed\_in` (genres), and `description`. All text is lowercased, and missing values (`NaN`) are filled with empty strings (`''`) to ensure consistency and prevent errors.

4\.  \*\*Text Vectorization (TF-IDF):\*\*

&nbsp;   \* \*\*`TfidfVectorizer`\*\* (from scikit-learn) is used to convert this text corpus into a numerical matrix.

&nbsp;   \* \*\*Key parameters used:\*\*

&nbsp;       \* `max\_features=5000`: Limits the vocabulary to the top 5,000 most important terms.

&nbsp;       \* `ngram\_range=(1, 2)`: Captures both single words (unigrams) and two-word phrases (bigrams) like "private school," which provides more context.

&nbsp;       \* `stop\_words`: A custom list (including "tv", "show", "movie") is used to ensure the model focuses on \*\*content\*\* similarity, not \*format\* similarity.

&nbsp;   \* This process results in a TF-IDF matrix of shape \*\*(8807, 5000)\*\*, where each title is represented by a vector of 5000 features.

5\.  \*\*Similarity Calculation:\*\*

&nbsp;   \* \*\*`cosine\_similarity`\*\* is used to calculate the similarity (cosine of the angle) between the TF-IDF vectors.

&nbsp;   \* The `recommend()` function takes a user's title, finds its corresponding vector, and calculates its similarity against all other vectors (or a filtered subset based on `type\_filter`).

&nbsp;   \* It then returns the top `k` most similar titles.



\## Visualizations



\### Titles Added by Year (Movies vs. TV Shows)

\*(You can paste your `image\_fc7f9a.png` here when uploading to GitHub)\*



This plot shows the rapid growth of content, especially the surge in TV show production after 2015.



\### 2D Content Map (t-SNE)

\*(You can paste your `image\_f18e5b.jpg` here when uploading to GitHub)\*



This t-SNE plot visualizes a 2,000-title sample from the 5000-dimensional TF-IDF space. Each point is a title (blue=Movie, orange=TV Show). The plot shows that movies and TV shows have significant thematic overlap, but also form distinct clusters, validating the content-based features.



\## How to Use



The core of the project is the `recommend()` function. After running the notebook cells to load the data and define the functions:



```python

\# --- Example 1: Get 5 recommendations for "Peaky Blinders" (any type) ---

display(recommend("Peaky Blinders", k=5))



\# --- Example 2: Get 5 recommendations for "Blood \& Water" (Movies only) ---

display(recommend("Blood \& Water", k=5, type\_filter="Movie"))



\# --- Example 3: Get a mixed list of 10 recommendations for "Blood \& Water" ---

display(recommend\_mixed("Blood \& Water", total=10))



\# --- Example 4: See \*why\* "Blood \& Water" is recommended what it is ---

display(keywords\_for\_query\_and\_recs("Blood \& Water", k=5, n\_terms=10))



\## Key Libraries Used



\*\*Pandas:\*\* For data loading, manipulation, and analysis.



\*\*NumPy:\*\* For numerical operations and array handling.



\*\*Matplotlib \& Seaborn:\*\* For creating all static visualizations (histograms, bar charts, line plots, and the t-SNE scatter plot).



\*\*Plotly.express:\*\* Imported for creating interactive visualizations.



\*\*Scikit-learn (sklearn):\*\*



* TfidfVectorizer: The core tool for converting text (title, genre, description) into numerical TF-IDF vectors.



* cosine\_similarity: Used to calculate the similarity score between title vectors.



* TSNE: Used for dimensionality reduction to create the 2D content map.



* Collections (Counter): Used in the EDA to count the most frequent genres.



* re (Regular Expressions): Imported for text cleaning operations.



