# Netflix Content-Based Recommender System



This project is a content-based recommendation system built in Python using a [Netflix titles dataset from Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows).  

The system analyzes the text data (title, genre, description) of over 8,800 movies and TV shows to recommend content with the most similar themes and plots.



## Features



**Content-Based Recommendations:** Suggests titles based on similarities in their title, genre, and description.  



**Type Filtering:** Allows users to filter recommendations to see only "Movies" or only "TV Shows."  



**Mixed Recommendations:** A helper function provides a balanced list of both movies and TV shows.  



**Explainability:** Includes a function to extract and display the top keywords (features) that link a query title to its recommendations, explaining *why* they are considered similar.  



**Data Visualization:** Includes exploratory data analysis (EDA) of genre distributions, content types, and release trends, as well as a t-SNE plot to visualize the entire content catalog in 2D.



## Methodology



The recommender system is built using a standard Natural Language Processing (NLP) and machine learning pipeline:



1. **Data Loading & Cleaning:**  

- The `Netflixdata.csv` is loaded into a pandas DataFrame.



2. **Exploratory Data Analysis (EDA):**  

   The dataset is analyzed to find key insights:  

   - The catalog consists of approximately 70% Movies and 30% TV Shows.  

   - The United States and India are the top production countries.  

   - Content releases grew exponentially after 2010, peaking around 2018.  

   - The “Movies vs. TV Shows” time-series plot shows that while movie additions have slowed, TV show additions have accelerated, nearly closing the gap by 2020.



3. **Feature Engineering:**  

   A unified “content” field is created for each title by concatenating its title, `listed_in` (genres), and description.  

   All text is lowercased, and missing values (NaN) are filled with empty strings to ensure consistency and prevent errors.



4. **Text Vectorization (TF-IDF):**  

   - `TfidfVectorizer` (from scikit-learn) is used to convert this text corpus into a numerical matrix.  

   - **Key parameters used:**  

   - `max_features = 5000`: Limits the vocabulary to the top 5,000 most important terms.  

   - `ngram_range = (1, 2)`: Captures both single words (unigrams) and two-word phrases (bigrams), such as “private school,” which provides more context.  

   - `stop_words`: A custom list (including “tv”, “show”, “movie”) ensures the model focuses on **content similarity**, not format similarity.  

   - This process results in a TF-IDF matrix of shape **(8807, 5000)**,      where each title is represented by a vector of 5,000 features.



5. **Similarity Calculation:**  

   - `cosine_similarity` is used to calculate the similarity (cosine of the angle) between the TF-IDF vectors.  

   - The `recommend()` function takes a user’s title, finds its corresponding vector, and calculates its similarity against all other vectors (or a filtered subset based on `type_filter`).  

   - It then returns the top *k* most similar titles.



## Visualizations



**Titles Added by Year (Movies vs. TV Shows)**  

This plot shows the rapid growth of content, especially the surge in TV show production after 2015.



**2D Content Map (t-SNE)**  

This t-SNE plot visualizes a 2,000-title sample from the 5,000-dimensional TF-IDF space.  

Each point is a title (blue = Movie, orange = TV Show).  

The plot shows that movies and TV shows have significant thematic overlap but also form distinct clusters, validating the content-based features.



## How to Use



The core of the project is the `recommend()` function. After running the notebook cells to load the data and define the functions:



```python

# Example 1: Get 5 recommendations for "Peaky Blinders" (any type)

display(recommend("Peaky Blinders", k=5))



# Example 2: Get 5 recommendations for "Blood & Water" (Movies only)

display(recommend("Blood & Water", k=5, type_filter="Movie"))



# Example 3: Get a mixed list of 10 recommendations for "Blood & Water"

display(recommend_mixed("Blood & Water", total=10))



# Example 4: See why "Blood & Water" is recommended

display(keywords_for_query_and_recs("Blood & Water", k=5, n_terms=10))


```
