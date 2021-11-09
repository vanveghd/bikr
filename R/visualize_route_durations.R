# bikr "visualize_route_durations" function
# (c) Daniel Van Veghel, 2021

#' Visualize the Trip Durations field of the BikeShare Data
#' @param {} No parameters needed; the function is designed to display the dataframe's TripDuration data.
#' @export

visualize_route_durations <- function(){
  data("bikesharedata")
  hist(bikesharedata$Tripduration, col = "#99CCFF", xlab = "Route Durations (min)",
       ylab = "Frequency", main = "Distribution of BikeShare Trip Lengths (min)", breaks = 500)
  boxplot(bikesharedata$Tripduration, col = "#FFFF66", horizontal = TRUE)
  barplot(cbind((aggregate(bikesharedata$Tripduration,
                     by=list(bikesharedata$Usertype),
                     FUN=mean)))[,2], col = "#CCCCFF", xlab="User Type",
          ylab= "Average Trip Duration (min)", names.arg = c("Unknown", "Customer", "Subscriber"))
}
