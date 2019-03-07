# Project Proposal

## Project Description

#### The Dataset
-	The dataset we will be working with is the _International Union for Conservation of Nature’s Red List of Threatened Species_. This dataset provides comprehensive data on **animal**, **fungi**, and **plant** species _globally_. Specifically, one can find information regarding population size, habitat, ecology, threats, and conservation actions for these different species.
- The dataset was accessed [here.](http://apiv3.iucnredlist.org/)
-	Data for the IUCN Red List is collected by members of the _Red List Partnership_. These partners include the _Species Survival Commission, BirdLife International, Conservation International,_ and others. A complete list of these partners can be found [here.](https://www.iucnredlist.org/about/partners)
-	There are more than 96,500 species in this dataset. As a result, the IUCN Red List is a product of the participation of its partners - it would be impossible to collect this much data without them.

#### Target Audience
-	Our target audience is students at the college age level, because this audience is the next generation of people who can and want to make a lasting impact on the world. Students at this age still have the time to find their passion and start a career. Through education with this dataset, we hope that students are encouraged to participate in conservation measures and find a passion in conserving wildlife.  

#### 3 Questions This Project Will Answer
-	How seriously is **climate change** affecting our world's species?
-	How are the species around us (in the **Pacific Northwest** area) being impacted?
-	What areas (habitats) are in the most danger, and what **conservation measures** can help suppress this danger?




## Technical Description
We will be reading in our data through an **API**, which will require the httr and jsonlite libraries. Since the API separates its data into many different dataframes, our initial stages of data wrangling will deal with _joining_ and synchronizing these different datasets. This will allow us to see the relationships between geography, threats, habitats, endangerment, and many more variables across the different species in the data. We then hope to use this information to drive an _interactive_ Shiny app. This app will include **plots** created through the ggplot2 and plotly libraries and an interactive **map** that utilizes ggmap and leaflet.

In working with such a large dataset, a potential challenge that presents itself will be sifting through the data  to find meaningful _trends_ and _interpretations_ that we would like to present to our audience in our final project. Additionally, since working with Shiny is a relatively new skill for us, we may encounter hurdles simply due to unfamiliarity.
