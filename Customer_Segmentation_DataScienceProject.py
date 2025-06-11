# %% [markdown]
# 
# 
# <h1 align="center">
#     NSDC Data Science Projects
# </h1>
#   
# <h2 align="center">
#     Project: Customer Segmentation Analysis
# </h2>
# 
# <h3 align="center">
#     Name: Mahesh Kumar Gurumoorthi
# </h3>
# 

# %% [markdown]
# ### **Please read before you begin your project**
# 
# **Instructions: Google Colab Notebooks:**
# 
# Google Colab is a free cloud service. It is a hosted Jupyter notebook service that requires no setup to use, while providing free access to computing resources. We will be using Google Colab for this project.
# 
# In order to work within the Google Colab Notebook, **please start by clicking on "File" and then "Save a copy in Drive."** This will save a copy of the notebook in your personal Google Drive.
# 
# Please rename the file to "Customer Segmentation - Your Full Name." Once this project is completed, you will be prompted to share your file with the National Student Data Corps (NSDC) Project Leaders.
# 
# You can now start working on the project. :)

# %% [markdown]
# 
# **Project Description:**
# 
# This project will introduce students to an array of skills as they strive to create an unsupervised machine learning model to divide customers into segments to optimize the significance of each customer. Customer segmentation is the process of grouping consumers according to characteristics that are shared by all of the customers in a cluster. We will also cover visualizations and how to deploy models in the real world.
# 

# %% [markdown]
# Google Colab QuickStart:
# - Google Colab is a Python Notebook environment built by Google that's free for all.
# - Colab Notebooks are made up of cells; cells can be either *text* or *code* cells. You can click the +code or +text button at the top of the Notebook to create a new cell.
# - Text cells use a format called [Markdown](https://www.markdownguide.org/getting-started/). Knowledge of Markdown is not required for this project. However, if you'd like to learn more, [check out this Cheatsheet!](https://www.markdownguide.org/cheat-sheet/)
# - Python code is executed in *code* cells. When you want to run your code, hover your cursor over the square brackets in the top left corner of your code cell. You'll notice a play button pop up! (▶) Click the play button to run the code in that cell. Code cells run one at a time.
# - The memory shared across your notebook is called the *Runtime*. You can think of a Runtime as a "code session" where everything you create and execute is temporarily stored.
# - Runtimes will persist for a short period of time, so you are safe if you need to refresh the page, but Google will shutdown a Runtime after enough time has passed. Everything that you have printed out will remain within your Notebook even if the runtime is disconnected.
# 
# If this is your first time using Google Colab, we highly recommend reviewing the [NSDC's *Using Google Colab Guide*](https://nebigdatahub.org/wp-content/uploads/2023/04/NSDC-Data-Science-Projects-Introduction-Using-Google-Colab.pdf) before continuing. For a more comprehensive guide, see [Colab's *Welcome To Colaboratory* walkthrough.](https://colab.research.google.com/github/prites18/NoteNote/blob/master/Welcome_To_Colaboratory.ipynb)

# %% [markdown]
# 
# ---
# ---

# %% [markdown]
# 
# 
# <h3 align = "center">
#     Milestone #1: Data Retrieval and Pre-Processing
# </h3>

# %% [markdown]
# GOAL: The main goal of this milestone is to set up your environment, install the required packages, learn how to access data and do some basic data preparation tasks.

# %% [markdown]
# **Step 1:** Setting up libraries and installing packages
# 
# To install a library:
# ```python
#  import <library> as <shortname>
# ```
# We use a *short name* since it is easier to refer to the package to access functions and also to refer to subpackages within the library.
# 

# %%
#TODO: Import libraries
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
from sklearn.cluster import KMeans

# %% [markdown]
# ---

# %% [markdown]
# **Step 2:** Let’s access our data. We will be using the Marketing Campaign dataset from Kaggle.
# 
# 
# [The Marketing Campaign  dataset is available at this link](https://www.kaggle.com/datasets/rodsaldanha/arketing-campaign). It is better to use the link provided directly within the read_csv function.
# 
# 
# 
# We will use pandas to read the data from the csv file using the `read_csv` function. This function returns a pandas dataframe. We will store this dataframe in a variable called `df`.

# %%
# TODO: Read the data using pandas read_csv function
df = pd.read_csv('/Users/maheshg/Dropbox/Sample Datasets Kaggle/Customer Segment Analysis/marketing_campaign.csv', delimiter=';')

# %%
df.info()

# %%
df.describe

# %%
df.head()

# %%
df.shape

# %%
df.size

# %%
df.describe

# %% [markdown]
# ---

# %% [markdown]
# **Step 3:** Let's prepare our data for analysis. Follow the steps below to review the first 5 rows of your dataset, display column names, and get other basic information about the dataset.

# %%
# TODO: Print the first 5 rows of the data using the head function of pandas.
df.head(n=5)

# %%
# TODO: Display all the column names.
df.columns

# %%
# TODO: Print the dimensions of the dataset using the shape function.
df.shape

# %%
# TODO: Use info function to get basic information about the dataset.
df.info

# %%
# TODO: Describe the data using describe function of pandas.
df.describe

# %%
# TODO: Check for missing values in the dataset.
df.isna()

# %%
# TODO: Drop the missing values.
df.dropna(how='all')

# %%
# TODO: Check for duplicates.
df.duplicated()

# %%
#TODO: Rename column names.
df.rename(columns={'Year_Birth':'Birth Year','Marital_Status':'Marital'})

# %% [markdown]
# 
# ---

# %% [markdown]
# ---
# ---

# %% [markdown]
# 
# 
# <h3 align = "center">
#     Milestone #2: Feature Engineering
# </h3>

# %% [markdown]
# GOAL: The main goal of this milestone is to do some feature engineering and perform exploratory data analysis (EDA).

# %% [markdown]
# **Step 1:** The goal of this step is to perform feature engineering as required and drop the features that are irrelevant. To better understand feature engineering, [review this resource.](https://builtin.com/articles/feature-engineering) Then, fill in the blanks below.

# %%
# TODO: Perform feature engineering as required.
# Create a new column named 'Age'.
df['Age'] = 2022 - df['Year_Birth']

# TODO: Create a new column for all the accepted campaigns.
df['Accepted_Campaigns'] = df['AcceptedCmp1'] + df['AcceptedCmp2'] + df['AcceptedCmp3'] + df['AcceptedCmp4'] + df['AcceptedCmp5']

# TODO: Create a new column for all the items.
df['Total_Items'] = df['MntWines'] + df['MntFruits'] + df['MntMeatProducts'] + df['MntFishProducts'] + df['MntSweetProducts'] + df['MntGoldProds']

# TODO: Create a new column for all the purchases.
df['Total_Purchases'] = df['NumDealsPurchases'] + df['NumWebPurchases'] + df['NumCatalogPurchases'] + df['NumStorePurchases']

# TODO: Display the dataframe with the updated columns.
df.head()

# %%
 # TODO: Drop irrelevant features.
df_new = df.drop(['Dt_Customer', 'Education', 'Marital_Status', 'Year_Birth', 'ID'], axis = 1)

# TODO: Display the dataframe.
df_new.head()

# %% [markdown]
# ---

# %% [markdown]
# **Step 2:** Now that we have dealt with outliers and done some feature engineering, the next step is to plot some distributions and check for outliers. To do so, [review this resource to best understand interquartile range](https://www.khanacademy.org/math/cc-sixth-grade-math/cc-6th-data-statistics/cc-6th/a/interquartile-range-review), as we will be using that statistic below. Then, fill in the blanks.

# %%
# TODO: Plot distributions for the relevant columns and check for outliers.
# Boxplot for `Income` distribution.
plt.figure(figsize = (8,5))
sns.boxplot(df, x = 'Income',  color = 'skyblue')
plt.title('Income Distribution');

# %%
# TODO: Calculate the Interquartile range (IQR) for the `Income` column.
Q1 = df['Income'].quantile(0.25)
Q3 = df['Income'].quantile(0.75)
IQR = Q3 - Q1

# TODO: Identify the outliers in the Income column
outliers = df[(df['Income'] < (Q1 - 1.5 * IQR)) | (df['Income'] > (Q3 + 1.5 * IQR))]

# TODO: Print the number of outliers
print("Outliers in the Income column:", len(outliers))

# %%
# TODO: Remove the outliers in the `Income` column.
df = df[~((df['Income'] < (Q1 - 1.5 * IQR)) | (df['Income'] > (Q3 + 1.5 * IQR)))]

# %%
df.columns

# %%
# TODO: Plot Histograms for the important columns.
fig, axes = plt.subplots(nrows = 3, ncols = 2, figsize = (10,10))

# TODO: Histogram for `Income` distribution.
sns.histplot(df, x = 'Income', color = 'skyblue', bins = 50, ax = axes[0,0])
axes[0,0].set_title('Income Distribution')

# TODO: Histogram for `Age` distribution.
sns.histplot(df, x = 'Age', color = 'orange', bins = 50, ax = axes[0,1])
axes[0,1].set_title('Age Distribution')

# TODO: Histogram for `Kidhome` distribution.
sns.histplot(df, x = 'Kidhome', color = 'green', ax = axes[1,0])
axes[1,0].set_title('Number of children by household')

# TODO: Histogram for `Teenhome` distribution.
sns.histplot(df, x = 'Teenhome', color = 'purple', ax = axes[1,1])
axes[1,1].set_title('Teenhome Distribution')
 
# TODO: Histogram for `Education` distribution.
sns.histplot(df, x = 'Education', color ='red', ax = axes[2,0])
axes[2,0].set_title('Education Distribution')

# TODO: Histogram for `Marital_Status` distribution.
sns.histplot(df, x = 'Marital_Status', color = 'brown', ax = axes[2,1])
axes[2,1].set_title('Marital Status Distribution')
plt.xticks(rotation = 45)

plt.tight_layout();

# %%
# TODO: Distributions for `Accepted_Campaigns`, `Total_Items`, and `Total_Purchases columns.
fig, axes = plt.subplots(nrows = 1, ncols = 3, figsize = (14,4))

sns.histplot(df, x = 'Accepted_Campaigns', color = 'skyblue', ax = axes[0])
axes[0].set_title('Accepted Campaign Distribution')

sns.histplot(df, x = 'Total_Items', color = 'pink', ax = axes[1])
axes[1].set_title('Total Item Distribution')

sns.histplot(df, x = 'Total_Purchases', color = 'green', ax = axes[2])
axes[2].set_title('Total Purchases Distribution')
plt.tight_layout();

# %%
fig, axes = plt.subplots(1, 2, figsize = (10,5))

# TODO: Bar plot for `Total_Purchases` by `Education`.
df1 = df.groupby(['Education'])['Total_Purchases'].mean().reset_index()
sns.barplot(df1, x = 'Education', y = 'Total_Purchases', ax = axes[0])
axes[0].set_title('Total Purchases by Education')

# TODO: Bar plot for `Total_Purchases` by `Marital_Status`.
df2 = df.groupby(['Marital_Status'])['Total_Purchases'].mean().reset_index()
sns.barplot(df2, x = 'Marital_Status', y = 'Total_Purchases', ax = axes[1])
axes[1].set_title('Average Total Purchases by Marital Status')
plt.xticks(rotation = 45)

plt.tight_layout();

# %% [markdown]
# **TO DO:** List 3 observations you've made from the visualizations above.
# >*  Filled in Missing values logically. 
# >*  Used group by clause based on the use case Marital Status by Total Purchases and then reset the index value 
# >*  Added a meaningful title for clear interpretation
# 

# %% [markdown]
# ---
# ---

# %% [markdown]
# 
# 
# <h3 align = "center">
#     Milestone #3: K-Means Clustering and Principal Component Analysis
# </h3>

# %% [markdown]
# GOAL: The main goal of this milestone is to perform K-means clustering and dimensionality reduction using principal component analysis(PCA).

# %% [markdown]
# **Step 1:** Now that we have prepared the data and performed exploratory data analysis (EDA), we will now begin with one-hot encoding to encode the categorical variables in the dataset, followed by data scaling. [Find a resource here to better understand one hot encoding, including examples!](https://www.khanacademy.org/math/cc-sixth-grade-math/cc-6th-data-statistics/cc-6th/a/interquartile-range-review) To review the StandardScaler function, [review this resource.](https://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.StandardScaler.html)

# %%
df.dtypes

# %%
df = df.select_dtypes(include=['number'])

# %%
df = df.fillna(df.mean())

# %%
from sklearn.preprocessing import StandardScaler

scaler = StandardScaler()
df[df.select_dtypes(include=['number']).columns] = scaler.fit_transform(df.select_dtypes(include=['number']))

# %%
df

# %%
# TODO: Perform data scaling using StandardScaler function.
scaler = StandardScaler()
scaler.fit(df)
df = pd.DataFrame(scaler.transform(df), columns=df.columns)

# %% [markdown]
# ---
# 

# %% [markdown]
# **Step 2:** After One-hot encoding and data scaling, we can now execute dimensionality reduction using principal component analysis (PCA). Here's a [resource from IBM that further explains PCA.](https://www.ibm.com/topics/principal-component-analysis)

# %%
# TODO: Initialize and fit the PCA model.
pca = PCA(n_components = 3)
pca.fit(df)
PCA_df = pd.DataFrame(pca.transform(df), columns=(["Group_1","Group_2", "Group_3"]))
PCA_df.describe().T

# %%
x = PCA_df["Group_1"]
y = PCA_df["Group_2"]
z = PCA_df["Group_3"]

fig = plt.figure(figsize = (10,8))
ax = fig.add_subplot(111, projection = "3d")
ax.scatter(x, y, z, c = "hotpink")
ax.set_title("3D Projection Of Data after performing PCA")
plt.show()

# %% [markdown]
# ---

# %% [markdown]
# **Step 3:** In this step, we will use the Elbow method to determine the optimal number of clusters and fit the K-Means model. [Here's an explanation of the Elbow method.](https://www.geeksforgeeks.org/elbow-method-for-optimal-value-of-k-in-kmeans/)

# %%
# TODO: Use Elbow method to determine the best number of clusters.
wcss = []

for k in range(1, 15):
    kmeans = KMeans(n_clusters = k, random_state = 42)
    kmeans.fit(PCA_df)
    wcss.append(kmeans.inertia_)

plt.figure()
plt.plot(range(1,15), wcss)
plt.xticks(range(1,15))
plt.xlabel("Number of Clusters)")
plt.ylabel("WCSS (Within Cluster Sum of Squares)")
plt.show()

# %%
# TODO: Fit the K-Means model with the number of clusters and visualize it in 3D.
kmeans = KMeans(n_clusters = 4, random_state = 42)
kmeans.fit(PCA_df)
df['Cluster'] = kmeans.labels_

fig = plt.figure(figsize = (10,8))
ax = plt.subplot(111, projection = '3d')
ax.scatter(x, y, z, c = df["Cluster"])
ax.set_title("3D Visualizations of KMeans Clustering")
plt.show()

# %% [markdown]
# ---
# ---

# %% [markdown]
# <h3 align = 'center' >
# Thank you for completing the project!
# </h3>
# 
# Please submit all materials to the NSDC HQ team at nsdc@nebigdatahub.org in order to receive a virtual certificate of completion. Do reach out to us if you have any questions or concerns. We are here to help you learn and grow.


