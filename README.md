# Butterfly
Analysis of Butterfly data set


<h1 align="center"> Butterfly Analysis
     <a style="color:#E7655A;"> Rscript Explanation</a>
</h1>

<p align="center">  
<a><img src="https://img.shields.io/github/stars/FitBeatDepresso?label=Organization%20Stars&style=social"></a>     
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
</p>


## Dataset: 
This dataset included two xlsx files which contained an unstructured information on butterflies such as:<br>
     -sex<br>
     -Collection date<br>
     -Dimensions<br>
     -Location<br>
using Rstudio, we organized and cleaned the data to perform analysis and give descriptions using different visuals.
## Cleaning
 Step 1: Got rid off Null columns.<br>
 Step 2: Left joining the two files<br>
 Step 3:Changed month in date from number to word<br>
 Step 4: Found average values for Width, Length, Apex area, Anterior spot, and stored them in a table<br>


 ## Question 1: Effect of Sex 
 **On Wing Length and Width:**
 ![Rplot02](https://user-images.githubusercontent.com/108307724/207140937-aeabdb32-b60b-43e4-8484-c35dc89c43e8.png)
 
 Purpose:This visual shows information on the Wingth and Length of Butterflies with different colors for males(Blue) and females(Pink). 
Conclusion:<br>
-Females wings are wider than wings of the males<br>
-Males wings are longer than wings of females<br>
**On apex Area and Anterior Spot:**
 ![Rplot05](https://user-images.githubusercontent.com/108307724/207142182-63dfdbd5-43a2-424b-b00f-4f4a962df130.png)

Purpose:This visual shows information on the Apex Area and Anterior Spot of Butterflies with different colors for males(Red) and females(Green). 
Conclusion:<br>
-Females have higher Apex area<br>
-Females have wider Anterior Spot<br>
**** Extra Visual:****

![Rplot09](https://user-images.githubusercontent.com/108307724/207144114-1edfb004-d486-4c0a-9d18-cf13b7b8bd83.png)

Purpose:This visual shows the distribution of butterflies on the US map and world map based on sex. 
Conclusion:<br>
-Genrally the butterflies that were collected were from the western hemisphere<br>
-In the US, butterflies collected from the west were females and the ones collecetd from the east were males.<br>

 ## Question 2: The Effect of Location
 **Wing Measurement by Country**
 ![Rplot10](https://user-images.githubusercontent.com/108307724/207145147-ed81ab58-8d50-4b8b-8bae-81b521b08e39.png)

Purpose: This visual tells about about the width, apex area and anterior spot measurements by country.
Conclusion:<br>
-Butterflies with the widest wings were from Canada<br>
-Butterflies with the highest Apex area were from Ireland<br>
-Butterflies with the widet Anterior spots were from Ireland.<br>

 ## Question 3: The Relationship between Apex area and Anterior spot area, and wing length,
 ![IMG-4650](https://user-images.githubusercontent.com/108307724/207147357-a7d0c39d-bb54-44a7-b0dd-1a2537c79a17.jpg)
We performed a correlation test to test the correlation between anteririor spot and Apex Area
Findning: Corrrelation value of 0.63
Conclusion: Anterior spot area and WIng lnegth have a moderate positive relationship. This means as Anterior spot increases, so does the apex area.
## Question 4:Effect of collection Month
**on Wing Length :**
![Rplot](https://user-images.githubusercontent.com/108307724/207148516-be0576c3-2352-43e4-b763-fe13765b021b.png)
Conclusion: <br>
-Widest was in August<br>
-Shortest was in March<br>

## Question 4: Comparison of Male vs Female by decade for each Wing






## Contributors
Hildana Teklegiorgis(hteklegiorgis20@augustana.edu)<br>
Joshua Chalachew(Eyasuyenesew20@augustana.edu)<br>



