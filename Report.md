**Netflix Recommender System – Stakeholder Report**



**Project Goal**

A content-based recommender system was developed for Netflix titles.

•	Input: a show or movie selected by the user.

•	Output: the system suggests 5 similar titles with clear explanations of why they were chosen.



**Step 1: Data Exploration**

The Netflix catalog was analyzed to identify patterns:

•	Growth trend: titles expanded rapidly after 2015.

•	Popular genres: Dramas, International Movies, Comedies.

•	Top countries: United States, India, United Kingdom.

Purpose: Build an understanding of catalog structure and diversity.



**Step 2: Data Cleaning**

•	Missing values handled (e.g., “Unknown” for missing countries).

•	Text normalized to lowercase for consistency.

&nbsp;Purpose: Ensure consistency and prevent mismatches during analysis.



**Step 3: Feature Engineering (TF-IDF)**

•	New text column created by merging three fields:

o	title (light signal from keywords in the title)

o	listed\_in (genres)

o	description (plot summary)

•	Applied TF-IDF (Term Frequency – Inverse Document Frequency).

•	Frequent/common words were down-weighted.

•	Informative words (e.g., “teen”, “mystery”, “abducted”) were emphasized.

Purpose: Capture what makes each title unique and prepare the data for similarity comparisons.



**Step 4: Measuring Similarity**

•	Used cosine similarity to compare titles.

•	Shows and movies with more overlapping keywords scored higher.

Purpose: Quantify closeness between content.



**Step 5: Recommendation Engine**

•	The function recommend(title) generates top-5 recommendations.

•	Example: Input → Blood \& Water.

•	Output → Riverdale and similar titles ranked by content similarity.

Purpose: Deliver relevant and engaging recommendations instantly.



**Step 6: Explainability**

•	Each recommendation is supported with shared keywords.

•	Example: Blood \& Water and Riverdale both emphasize “teen, mystery, school.”

Purpose: Transparent reasoning improves stakeholder and user trust.



**Visual Insights**

•	Timeline: Netflix catalog expansion accelerates post-2015.

•	Genres: Dramas and International titles dominate.

•	Countries: U.S. leads, but global representation is strong.

•	2D Map: Content clusters visually validate similarity modeling.



**Outcomes**

•	Recommender system suggests both TV shows and movies.

•	Explanations highlight why each suggestion is relevant.

•	Provides insight into Netflix catalog trends and composition.



**Next Steps**

1\.	Make recommendations more personal

•	Right now, the system recommends shows only based on text features (title, description, genre).

•	The next step is to also include each user’s viewing history.

•	Example: If two people both watched Blood \& Water, the system currently shows them the same suggestions. By looking at their personal history (comedies vs. thrillers), each user                 would get different, tailored results.



2\.	Support multiple languages

•	Netflix content spans the globe, but the current system mainly works with English descriptions.

•	By expanding to multiple languages (Spanish, Hindi, Korean, etc.), the system can recommend shows to viewers everywhere, not just English speakers.

•	This ensures recommendations feel relevant and inclusive for all audiences.



3\.	Test with real users

•	A recommender system is only successful if it improves engagement in practice.

•	The next step is to run small live tests (for example, A/B testing).

•	One group of users sees the current system.

•	Another group sees the new system.

•	By comparing results (like watch time, clicks, or satisfaction), Netflix can measure whether the new system really adds value.





