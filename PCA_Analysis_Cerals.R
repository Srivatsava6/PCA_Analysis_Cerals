# Final Exam V2 - Data Mining for Business
# 2024-2025
# L. Trinchera

# The Cereals dataset reports 15 characteristics, including 13 numerical variables, on 77
# breakfast cereals. The description of the variables is provided below:
# • name: Name of cereal.
# • manuf: Manufacturer of cereal (A=American Home Food Products; G=General Mills; K=Kelloggs; N=Nabisco; P=Post; Q=Quaker Oats; R=Ralston Purina)
# • type: C=cold or H=hot.
# • calories: calories per serving.
# • protein: grams of protein.
# • fat: grams of fat.
# • sodium: milligrams of sodium.
# • fiber: grams of dietary fiber.
# • carbo: grams of complex carbohydrates.
# • sugars: grams of sugars.
# • potass: milligrams of potassium.
# • vitamins: vitamins and minerals - 0, 25, or 100, indicating the typical percentage of FDA recommended.
# • shelf: display shelf (1, 2, or 3, counting from the floor).
# • weight: weight in ounces of one serving.
# • cups: number of cups in one se

# by using ONLY the quantitative variables in the analysis:
library(readr)
library(FactoMineR)
library(factoextra)
library(corrplot)
# 1. Import the data.

cereals= read.csv("cereals.csv", sep=";")
#remove columns that are not quantitative
cereals = cereals[,c(4:14)]

# 2. Describe the variables using univariate statistics.  


apply(cereals, 2, mean)
apply(cereals, 2, median)
apply(cereals, 2, sd) 
apply(cereals, 2, min) 
apply(cereals, 2, max)

# 3. Compute the correlation matrix among all the variables and plot it.

corrplot(cor(cereals), method = 'number')
corrplot(cor(cereals), method = 'number',type="upper")  

# 4. Run a PCA with the PCA function in FactoMineR on scaled data.
res.pca=PCA(cereals[,2:9], scale.unit=TRUE, ncp=10, graph=T)


# 5. How many dimensions would you retain?  Justify your reply.

res.pca$eig
fviz_screeplot(res.pca, addlabels = TRUE, ylim = c(0, 50))

# The first three dimensions explain 71% of the variance, so I would retain three dimensions.
# also the eigen values are higher than 1 for the first 3 dimensions, so I would retain three dimensions.
#After dim 3, the variance explained by each additional component drops off significantly

# 6. Produce a plot to display the relationships between the variables using Dimension 1 and 3 and interpret the results.

plot(res.pca,choix="var",axes=c(1,3),cex=.75) 

#dim1 accounts 32.51% of variance in the data. It is best represented by potassium,protein, fiber and negatively correlated to carbohydrate. 
#dim3 accounts 13.68% of variance in the data. It is positively correlated to sodium, vitamins and sugar. Also these three variables are also correlated to each other. All the three variables are decently represented based on the length
#fat is not well represented may be represented well in other dimensions

# 7. Show the individuals who are worstly rappresented on Dimension 1, 2 and 3 and comment the results.
# Sum of cos2 values across first 3 dimensions

# Compute cumulative cos2 across Dim 1, 2, 3
res.pca$ind$cos2_123 <- apply(res.pca$ind$cos2[, 1:3], 1, sum)

# Prepare a dataframe with coordinates and names
ind_coords <- as.data.frame(res.pca$ind$coord)
ind_coords$name <- read.csv("cereals.csv", sep = ";")$name
ind_coords$cos2_total <- res.pca$ind$cos2_123

# Filter individuals with low cumulative representation (< 0.4)
low_cos2 <- ind_coords %>% filter(cos2_total < 0.4)

# 3D Plot of poorly represented individuals
plot_ly(data = low_cos2,
        x = ~Dim.1,
        y = ~Dim.2,
        z = ~Dim.3,
        type = 'scatter3d',
        mode = 'markers+text',
        text = ~name,
        marker = list(size = 4,
                      color = ~cos2_total,
                      colorscale = 'Reds',
                      showscale = TRUE),
        hoverinfo = 'text+color')

# Extract cos2 values for individuals (cereals)
ind_cos2 <- res.pca$ind$cos2

# Identify the 5 worst represented individuals for each dimension
worst_dim1 <- sort(ind_cos2[, 1])[1:10]
worst_dim2 <- sort(ind_cos2[, 2])[1:10]
worst_dim3 <- sort(ind_cos2[, 3])[1:10]

round(worst_dim1, 5)
round(worst_dim2, 5)
round(worst_dim3, 5)

# Extract cereal names from the original dataset
cereal_names <- read.csv("cereals.csv", sep = ";")$name

# Get row indices for worst represented individuals
worst_dim1_indices <- as.numeric(names(worst_dim1))
worst_dim2_indices <- as.numeric(names(worst_dim2))
worst_dim3_indices <- as.numeric(names(worst_dim3))

# Print the names of the worst represented cereals
cat("Worst represented cereals on Dimension 1:\n")
print(cereal_names[worst_dim1_indices])

cat("\nWorst represented cereals on Dimension 2:\n")
print(cereal_names[worst_dim2_indices])

cat("\nWorst represented cereals on Dimension 3:\n")
print(cereal_names[worst_dim3_indices])

data.frame(
  Cereal_Dim1 = cereal_names[worst_dim1_indices],
  Cos2_Dim1 = round(worst_dim1, 5),
  Cereal_Dim2 = cereal_names[worst_dim2_indices],
  Cos2_Dim2 = round(worst_dim2, 5),
  Cereal_Dim3 = cereal_names[worst_dim3_indices],
  Cos2_Dim3 = round(worst_dim3, 5)
)



# 8. Plot the Variables on the first two dimensions of the PCA, and color them by their Contribution. Comment the results.


fviz_pca_var(res.pca, col.var="contrib",  
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),  
             repel = TRUE 
)
#based on dimension 1, products with potassium, protein and fiber are the most important variables contributing to the dimension1
#based on dimension 2, products with fat, sodium and sugar are the most important variables contributing to the dimension 2 and sugar and fat are negatively contibuting to dimension are negatively correlated



# 9. Plot the Variables on Dimensions 1 and 3, color by Contribution, and comment

fviz_pca_var(res.pca, 
             col.var = "contrib",
             axes = c(1, 3),
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE
)

# Interpretation:
# On Dimension 1, the most contributing variables are potassium, protein, and fiber. 
# These variables are positively correlated and represent nutrient-dense cereals.

# On Dimension 3, the most contributing variables are sodium, vitamins, and sugars.
# These three variables are positively correlated with each other, forming a different nutritional profile from Dimension 1.

# Calories show a shorter arrow length on this plot, meaning they are not well represented on Dimension 3.
# Hence, we cannot conclude anything definitive about calorie levels from this dimension alone.

