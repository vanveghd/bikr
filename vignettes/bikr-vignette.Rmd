---
title: "bikr-vignette"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{bikr-vignette}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---

# Bike Share Trip Data -- Pittsburgh, PA; Q1 of 2021
### **Source:** Adam S. Carroll, available at [This location](https://www.kaggle.com/adamscarroll/pittsburgh-healthy-ride-bikeshare-rentals-2021-q1/metadata)

***

The Bike Share Data included in the **bikr** package is a data frame of 14,619 cases and 10 variables. 
While originally a csv document loaded from the site indicated above, the data frame is now an R Data object, for use within bikr functions or other analyses. 
  The data details individual BikeShare rides in Pittsburgh, Pennsylvania, for the first Quarter of 2021. It is available for download at the author's [Github Repository](http://www.github.com/vanveghd/bikr)

### **Accessing the Data**

First, the bikr package must be installed:

```{r setup, cache=TRUE}
if(!require(remotes)){
    install.packages("remotes")
    library(remotes)
}
remotes::install_github("vanveghd/bikr")
```

Next, we add the _bikr_ package into our library:

``` {r}
library(bikr)

# For more info on the package use:
?bikr

```

Then, we load the data object into our R Global Environment:

``` {r}
data("bikesharedata")

```

### **Dataset Variables**

Below are the variables and a brief outline of each of them:

- **trip.id:** ID Number for the individual trip, _Nominal_
- **Starttime:** The date/time the bikeshare trip began, _Date/Time_
- **Stoptime:** The date/time the bikeshare trip ended, _Date/Time_
- **Bikeid:** The BikeShare bike's identifier number, _Nominal_
- **Tripduration:** The length of the trip in minutes, _Continuous_
- **From.station.id:** The origin hub ID number, _Nominal_
- **From.station.name:** The origin hub name/location, _String, Nominal_
- **To.station.id:** The destination hub ID number, _Nominal_
- **To.station.name:** The destination hub name/location, _String, Nominal_
- **Usertype:** Whether the rider is a customer or subscriber, _Nominal_

To confirm this, let's take a look:

```{r}

head(bikesharedata)

```

### **Data Summarization**:

We can see the data summarization:

``` {r}

summary(bikesharedata)

```

Or we can visualize the data either through bikr's _visualize_route_durations_ function, or through:

```{r}

hist(bikesharedata$Tripduration, col = "#99CFFF", xlab = "Route Durations (min)",
       ylab = "Frequency", main = "Distribution of BikeShare Trip Lengths (min)", breaks = 500)

```

Later versions of the _bikr_ package are likely to include more functions with better analytical capabilities for the bikeshare data. 

### **BONUS -- a sample analysis of the dataset:

For this bonus, we want to determine whether there is a significant difference in the trip durations between "Customers" and "Subscribers". We take a very small sample, because t-tests are most effective with small samples (<=30).

##### **First, let's get the necessary values:**

```{r}

# We'll get this small sample of data as its own data matrix

means <- aggregate(bikesharedata$Tripduration[1:30], by=list(bikesharedata$Usertype[1:30]), FUN=mean)

variances <- aggregate(bikesharedata$Tripduration[1:30], by=list(bikesharedata$Usertype[1:30]), FUN=var)

n_obs <- aggregate(bikesharedata$Tripduration[1:30], by=list(bikesharedata$Usertype[1:30]), FUN=length)

means # Let's look at these values

variances # And these

n_obs # And finally, these
```
##### **Now, let's compare the means**
Comparing the means can be done several ways. Let's start using the bikr function:

```{r}

bikr::compare_means(means[1,2], means[2,2], variances[1,2], variances[2,2], n_obs[1,2], n_obs[2,2])

#Note, the indices refer to cells in the matrices generated in the previous code chunk.

```

Conversely, we can run this analysis manually. This is done using built-in `R` basic functions.

We do this using a two-sample t-test, whose formula looks like:

$$t = \frac{m_A - m_A}{\sqrt{\frac{S_A^2}{n_A} + \frac{S_B^2}{n_B}}}$$
Where $t$ = the value from the t-distribution,
  $m_A$ and $m_B$ are the two sample means,
  $S_A^2$ and $S_B^2$ are the two sample variances, and
  $n_A$ and $n_B$ are the two sample sizes.
  
We can calculate this t -value using the formula above in `R`. 

```{r}
t <- (means[[1,2]] - means[[2,2]])/sqrt((variances[[1,2]]/n_obs[[1,2]])+(variances[[2,2]]/n_obs[[2,2]]))

t
```

And finally, compute the probability of this t-value occurring (to know whether to reject the Null Hypothesis that these sample means are not significantly different). 

``` {r}

p <- 2*pt(-abs(t), df=(n_obs[1,2] + n_obs[2,2] - 2))

p
```

These sample means are not statistically significant!

### **Thanks for reading!**
We hope you've enjoyed this data description, and have learned more about using the data as well as _bikr_ functions. 
  For reporting any data or function issues with _bikr_, visit the author's [Github Repository](http://www.github.com/vanveghd/bikr).
