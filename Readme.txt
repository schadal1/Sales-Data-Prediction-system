Name:	Sumanth Venkata Naga Satya Chadalla
Email: 	shcadal1@binghamton.edu
Language used: R programming Language

References: 
Forecasting Principles and Practice by Rob J Hyndman and George Athanasopoulos

Data Mining Project:
Unzip the schadal1 zip file
schadal1.R is the source code file.
output.txt is the output file

Instructiions to Run in Windows:
Preffered Rstudio application or in R Gui
1.Install the following Packages before executing my code
1.a. forecast
1.b. Matrix
1.c. caret
1.d. ggplot
1.e. lapice
2. Run my R code in the command or press ctrl+r on each line 
3. In the browse option please choose the product_distribution_training_set as the input file 
4. Run the code entirely
5. the output.txt will have the predicted values of the 28 days of 100 products and overall prediction.

Instructiions to Run in Linux and Ubuntu:
1. Required R installed into the system reference: https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Installing-R-under-Unix_002dalikes
2. Install the following Packages before executing my code
2.a. forecast
2.b. Matrix
2.c. caret
2.d. ggplot
2.e. lapice
3.Type the command: Rscript schadal1.R
4.Browse and choose product_distribution_training_set
5.check  the output in output.txt in the R project directory 


Row 1 the overall sales of all the products for each day to 28 days
Row 2 to Row 100 will have the predictions for each product on each day to 28 days.
colomn 1 are the product ids
column 2-28 will have predictions for each days

