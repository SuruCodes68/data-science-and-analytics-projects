# AeroPath: Predictive Modeling for NASA Drone Navigation


## Project Overview

This project develops an end-to-end predictive risk model to ensure safe drone navigation in complex urban environments. Drones rely on map data that is often outdated or inaccurate. A map might report a height of 20ft, while the real height (due to new construction) is 40ft, posing a critical collision risk.

This model moves beyond simple prediction to build a "risk-aware" pathfinding algorithm that navigates a grid based on probabilistic uncertainty, finding the demonstrably safest route.


## The Problem: Map Height vs. Real Height

The core challenge is the discrepancy between a map's reported height and an obstacle's true height. My task was to:

   1. Model this discrepancy using a provided dataset.

   2. Quantify the uncertainty inherent in the map's data.

   3. Build a pathfinding algorithm that uses this uncertainty to find the safest possible path from a start point (A) to an end point (B).


## The Dataset

The analysis was performed on the map_info.csv dataset, a 100x1 grid where each of the 100 rows represents a single 1x1 map square.

The key features include:

     • map_height: The height recorded in the current map.

     • real_height: The actual measured "ground truth" height. (My continuous target variable).

     • obstacle: A binary (1/0) flag. (My categorical target variable).

     • map_last_update: How many days ago the map was last updated.

     • map_source: The provider of the map data (e.g., Google, Army).

     • reported.obstacles: Number of times other drones have reported an obstacle.

A key business rule is the definition of an obstacle: obstacle = 1 if real_height > 20, otherwise obstacle = 0.


## Project Workflow & Modeling Strategy

My workflow was designed to build up from simple analysis to a final, complex application, demonstrating a complete data science lifecycle.



**1. Exploratory Data Analysis (EDA)**

I first analyzed the 100-square grid to understand the problem. Key findings included:

    • **Data is Stale:** 76% of the map grid was dangerously "Stale" (not updated in 21+ days).

    • **Source Matters:** The google map source was wildly inconsistent and unreliable, while the army source was the most consistent, as shown by the boxplot of height errors.

    • **Risk is Everywhere:** I combined height_error and update_status to create a "Drone Safety Risk Map," which confirmed that "Safe to Fly" zones were exceptionally rare.



**2. Model Scaffolding (Linear & Logistic Regression)**

Before building the final model, I used two "scout" models to diagnose the data, validate assumptions, and prove the concept.

    • **Linear Regression:** This model's primary goal was diagnostics.

         - It confirmed map_height and map_source were significant predictors of real_height.

         - Crucially, its Residuals output showed large errors, which led me to use Cook's Distance to identify and remove influential outliers. This data cleaning benefited all subsequent models.


    • **Logistic Regression:** This model explored a different question: "Can we predict the binary presence (1/0) of an obstacle?"

        - It confirmed map_height was the most significant predictor.

        - The model passed its goodness-of-fit test (the binnedplot), proving it was a reliable classifier.



**3. The Core Model: Bayesian Regression**

     This is the final and most powerful model, as it is the only one that can properly handle uncertainty.

        - **Why Bayesian?** A Linear Model gives a single-number guess (e.g., "the height is 30.5 ft"). A Bayesian model gives a full probability distribution.

        - **The Result:** The model converged successfully (Rhat = 1.00) after running 2,700 simulation samples across 3 chains. This distribution of 2,700 possibilities for each square gave 95% Credible                     Intervals for all predictors and allowed me to move beyond simple prediction to true risk assessment.



**4. The Application: Risk-Aware Pathfinding**

     This is the final step, where I translated the 2,700 Bayesian samples into a real-world tool:

  **1. Calculate Safety Probability:** I used the Bayesian model's distribution (posterior_linpred) to calculate a safe_prob for every square—the exact probability (out of 2,700 samples) that its real_height was        safely under 20ft.

  **2. Build a Weighted Graph:** I built a grid where the "cost" to move to any square was inversely proportional to its safety.

     • cost = 1 + (1 - safe_prob)

     • A very safe square (e.g., 95% safe) has a tiny cost: 1 + (1 - 0.95) = 1.05

     • A very unsafe square (e.g., 10% safe) has a high cost: 1 + (1 - 0.10) = 1.90

  **3. Find the Safest Path:** Finally, I used igraph's shortest_paths function to find the "cheapest" path from the start node (2_8) to the end node (7_3).

     The resulting path (2_8 -> 2_7 -> ... -> 7_3) is not the shortest, but it is the safest, as it intelligently navigates around the squares our model identified as having the highest risk and uncertainty.

