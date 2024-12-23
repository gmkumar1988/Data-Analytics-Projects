import pandas as pd
import numpy as np

print("Reading data: ")
diabetes_dataset = pd.read_csv("/Users/maheshg/Dropbox/Sample Datasets Kaggle/diabetes.csv")
diabetes_dataset.head(10)

diabetes_dataset.dropna(how="all")
diabetes_dataset.dropna(how="any")

print(diabetes_dataset.isnull().values.any())
# print(diabetes_dataset.isnull().values.any())
diabetes_dataset.fillna(0)

diabetes_dataset.fillna(0)
print("Any values has NaN:",diabetes_dataset.isnull().values.any())
diabetes_dataset.fillna(method="ffill")
diabetes_dataset.describe()
diabetes_dataset.info()
diabetes_dataset = diabetes_dataset.replace(np.nan,999999999)
print("Any values has NaN in this dataset :",diabetes_dataset.isnull().values.any())
