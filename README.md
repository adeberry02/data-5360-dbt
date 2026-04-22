# Data 5360 Final Project Description

This project provided a hands-on introduction to data warehousing. As consultants for Eco Essentials, an eco-friendly cookware company, we took raw data sources and converted them into a functional data warehouse. Eco Essentials can now answer important sales questions and make informed business decisions in an efficient way. Throughout this project, we utilized DBeaver, DBT, Fivetran, and Snowflake.  

## Step 1: Enterprise Data Warehouse Design
To begin this project, we were given two raw data sources stored in a Postgres database and an S3 bucket on AWS. These data sources had different formatting and lacked a standard data structure. We identified each unique business process and combined these data sources to create a comprehensive star-schema entity relationship diagram. To combine the two sources, we had several conformed dimensions and two separate fact tables. This ERD served as the baseline for the formation of our data warehouse. 

[Star Schema ERD] (https://lucid.app/lucidchart/3594d33b-69ff-4354-b708-a6b542b259ca/edit?viewport_loc=-531%2C83%2C1960%2C1105%2C0_0&invitationId=inv_dcce761d-3c9f-4509-809c-3174d24cb030)

## Step 2: Extract, Transform, and Load
Based on the ERD created in step 1, we then created a process to extract, transform, and load the data into the warehouse in Snowflake. We utilized Fivetran to extract and load both data sources. Once the raw data was in Snowflake, we used DBT to transform, create, and populate the dimensional models. To connect fact and dimensions, we created surrogate keys based on the primary identifiers of each row. 

## Step 3: Testing and Scheduling
Although the database was now created, we needed to make sure that there were checks in place to prevent future errors. New data will be added to the sources, and they should be consistently refreshed and checked for quality issues. We created a job for each  model that will refresh the data in the data warehouse daily. Each time these jobs are run, quality tests will be automatically performed for each dimension and fact. This ensures the data remains consistent, and queries run on the data will produce accurate results.  


## Step 4: Data Visualization
We rounded out our database project with a visualization component to help answer business questions and use information from the database. EcoEssentials, our client, is interested in which marketing campaigns are performing the best. Due to business needs, we focused on trends in sales and conversions from marketing campaigns to sales. We connected our Snowflake warehouse to Tableau and created dynamic visualizations that cater to the business's needs. 
We began with a simple chart of sales over time, specifically divided by months. Then, we narrowed the scope and created a top 10 Campaigns by Sales chart. Filters allow us to view sales by individual campaigns and time of the year. These two charts give EcoEssentials a general idea of how their products are doing and how different campaigns affect that success.
Finally, we created a visualization showing the discount and clicks for each campaign. This helps EcoEssentials understand the engagement with their marketing emails. Higher discounts may not always lead to higher click rates. Now, EcoEssentials can utilize this dashboard to make more informed decisions on future marketing campaigns. 

## Takeaways
1. Constant iteration is necessary. At each step in the process, we received feedback and implemented changes to remain on track. Even if something appears perfect when created, it can always fail.
2. Attention to detail is very important when creating a data warehouse. For example, the two data sources had different naming conventions (one used underscores, the other didn't). This was a source of confusion throughout the project, and would have been a little fix in the beginning. Additionally, in step two, detail was very important when creating the fact tables. One mistype could create a false join or break the code.
3. We learned how each tool works together to create a fabulous end product. As mentioned previously, we learned how dbt, Fivetran, and Snowflake work together. Step four allowed us to take a step back, truly understand the data, and generate valuable insights. All the steps are necessary.   
