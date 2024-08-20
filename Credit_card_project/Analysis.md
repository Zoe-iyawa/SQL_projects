1. How does approval rate vary by age and if they are employed ?
- The analysis indicates that adults (25 - 44) who are unemployed are very likely to be declined a credit card
- Some seniors who are unemployed will likely be approved. This can be due to a stable income from pension providers and free governemnt services and also low debt level. Most seniors will likely have paid off their debts from mortgage, cars etc. However, seniors who are currently working will get their credit card applicaion declined.
  
2. How does approval rate vary by gender and marital status ?
- The analysis revealed that single males will likely be approved for a creidt card. This is because they have fewer financial responsibilities
- Married male will likely be accepted for a credit card compared to married females. In some households, married males may traditionally handle financial responsibilities, including applying for credit, managing bills, and maintaining household budgets. This experience can lead to a stronger credit history.

3. How does the employment class affect approval rate. Does the type of work affect approval rate ?
- Analysis reveals that employed people who also recieve pension will most likely be approved for a credit card

4. Does count of chidren affect approval rate ?
- families with 4 kids will likely be approved for a credit card
- families with 14 kids will be declined a credit card.

5. Does count of chidren and marital status affect approval rate ?
- Separated families with 4 kids will likely be declined a credit card
- Married families with 4 kids will likely be approved a credit card
- Widowed families will likely be declined a credit card.


## Multiple Regression using Python
In this analysis, I conducted a multiple linear regression to predict a target variable based (Approved or not) on multiple features using a dataset of credit card approvals. The steps involved included data preparation, model training using the LinearRegression model from the sklearn library, and evaluation of the model's performance using the R-squared (R²) metric.

# Interpretation of the R-squared Value
The R-squared value obtained from the model was 0.0146. This value is quite low, indicating that the model explains only about 1.46% of the variance in the target variable based on the features used in the model.

# Conclusion
The R-squared value of 0.0146 suggests that the linear regression model has very limited predictive power for this dataset. This could be due to several reasons:
- Weak Relationship: The features used may have a weak or non-linear relationship with the target variable, making them poor predictors.
- Insufficient Features: Important predictors might be missing from the model, leading to poor performance.

In conclusion, while the model was implemented correctly, the low R-squared value indicates that it doesn't adequately explain the variation in the target variable. 
