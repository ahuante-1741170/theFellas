# Project Proposal

## Project Description

#### The Dataset
-	The dataset we will be working with is the _Bike Index_. This dataset provides comprehensive data on a variety of topics regarding **bikes**, including *biking organizations*, *makes*, and *bike theft incidences*. This particular dataset has a somewhat loose definition for "bikes", although they tend to be non-motorized and powered by physical movement. Our project will specifically examine and answer questions about bike theft in the US.
- The dataset was accessed [here](https://bikeindex.org/documentation/api_v3#!/bikes/GET_version_bikes_id_format_get_0).
-	Data for the Bike Index is collected through **crowdsourcing** from users that register with the site. By registering, users are given the ability to quickly track their bikes in case of theft, while allowing the Bike Index to collect information about the bikes in a particular city. The service was created in 2013 by **Seth Herr** and **Bryan Hance**, intended to serve as a "universal bike registration service".  More information about the service can be found [here](https://bikeindex.org/about).
-	There are more than **221,000** registered bikes in this dataset. Evidently, the Bike Index is a product of the participation of its users - it would be impossible to collect this much data without them.

#### Target Audience
-	Our target audience members consist of bike owners and enthusiasts. Since bike theft is a common problem in many cities, especially dense areas where biking is simply faster and more convenient compared to automobiles, we hope to encourage audience members to exercise the necessary precautions to avoid having their means of transportation stolen. Through education with this dataset, we hope that people gain a better understanding of the prevalence of bike theft and learn how they can counteract or avoid such incidences from happening to themselves.

#### 3 Questions This Project Will Answer
-	How are **theft locations** distributed in the major US cities?
-	**When** do most of these crimes occur during the day?
-	Is there any correlation between the **manufacturer** of a bike and theft rate?




## Technical Description
We will be reading in our data through an **API**, which will require the httr and jsonlite libraries. Since the API separates its data into many different dataframes, our initial stages of data wrangling will deal with _joining_ and synchronizing these different datasets. This will allow us to see the relationships between location, bike manufacturer, time, bike types, and many more variables across the different individual bikes in the data. We then hope to use this information to drive an _interactive_ Shiny app. This app will include **plots** created through the ggplot2 and plotly libraries and an interactive **map** that utilizes ggmap and leaflet.

In working with such a large dataset, a potential challenge that presents itself will be sifting through the data  to find meaningful _trends_ and _interpretations_ that we would like to present to our audience in our final project. Additionally, since working with Shiny is a relatively new skill for us, we may encounter hurdles simply due to unfamiliarity.

[Final Project: Bike Incidences Across the US](https://ahuante-1741170.shinyapps.io/theFellas)
