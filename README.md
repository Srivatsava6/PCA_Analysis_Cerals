# PCA Analysis on Breakfast Cereals Dataset

## Final Exam V2 - Data Mining for Business  
**Academic Year**: 2024–2025  
**Professor**: L. Trinchera

---

## 📂 Dataset Description

The dataset contains **77 breakfast cereals** with 15 variables, including 13 quantitative characteristics. Each row represents a cereal brand with nutritional details. The key variables include:

- **calories**: Calories per serving
- **protein**, **fat**, **fiber**, **carbo**, **sugars**
- **sodium**, **potass**: mg of sodium/potassium
- **vitamins**: 0, 25, or 100 (% of daily value)
- **weight**, **cups**: per serving
- Non-numeric variables like `name`, `manuf`, and `type` were excluded from the PCA.

---

## 📊 Analysis Steps

### 1. Data Import and Cleaning
- Imported the dataset using `read.csv`.
- Selected only the **quantitative variables** (columns 4 to 14) for PCA.

### 2. Univariate Statistics
- Computed **mean, median, standard deviation, min, and max** for each variable.

### 3. Correlation Matrix
- Calculated and visualized **correlation coefficients** between variables using `corrplot`.

### 4. Principal Component Analysis (PCA)
- PCA was performed on the **standardized** dataset using `FactoMineR::PCA`.
- Retained **components 1 to 3**, which explain ~71% of total variance.

### 5. Scree Plot & Eigenvalues
- The **scree plot** helped determine that the first 3 dimensions are sufficient (eigenvalues > 1, clear variance drop after Dim 3).

### 6. Variable Relationships (Dimensions 1 & 3)
- **Dim 1**: Positively influenced by *potassium, protein, fiber* and negatively by *carbohydrates*.
- **Dim 3**: Positively influenced by *sodium, vitamins, and sugars*.

### 7. Representation Quality (cos2)
- Identified cereals **poorly represented** on Dimensions 1, 2, and 3 using cosine squared values.
- Displayed worst-represented cereals using a **3D plot** (with `plotly`) and listed their names.
- A summary table shows the worst 10 cereals per dimension with cos2 scores.

### 8. Variable Contributions (Dimensions 1 & 2)
- Visualized variable contributions using color gradients:
  - *Potassium, protein, fiber* = strong contributors to Dim 1
  - *Fat, sodium, sugar* = strong contributors to Dim 2 (fat & sugar negatively correlated)

### 9. Variable Contributions (Dimensions 1 & 3)
- On Dim 3, *sodium, vitamins, and sugars* are most influential.
- *Calories* have low representation in Dim 3, indicating minimal influence.

---

## 📌 Interpretation Summary

- PCA reveals **nutritional clusters** among cereals.
- Dimensions highlight **healthier vs sugary/salty profiles**.
- Some cereals are **not well represented** in low dimensions and need deeper analysis or higher components.

---

## 📦 Tools Used

- **R** with libraries: `FactoMineR`, `factoextra`, `corrplot`, `plotly`, `dplyr`
- **Data Visualization**: Scree plots, correlation plots, 2D and 3D PCA projections.

---

## 🧠 Learning Outcome

This analysis demonstrates the ability to:
- Preprocess data for dimensionality reduction
- Apply PCA effectively on real-world datasets
- Interpret multivariate patterns using component loadings and cos2 quality
- Communicate data-driven insights visually and analytically

---

