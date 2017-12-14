#' @title Read in sample and specimen data from the Foodbase database.

#' @description Pulls exported data from the Foodbase database for use in R.

#' @param gear The sampling gear type of interest (\code{Drift}, \code{LightTrap}, etc). Default is \code{Drift}.
#' @param type Whether to download \code{Sample} or \code{Specimen} data. Default is \code{Sample}.
#' @param path The download location of the data on the \code{Network}, on \code{GitHub}, or elsewhere. Default is \code{Network}.

#' @details
#' Currently only \code{Drift} is implemented for \code{gear}.
#'
#' The \code{type} argument specifies whether to return \code{Sample} data (i.e., sample collection information) or \code{Specimen} data (i.e., bug counts and sizes, where relevant). If you are interested in working with both \code{Sample} and \code{Specimen} data, then using this function to get the \code{Sample} data, filtering to only the data of interest, then running the \code{\link{foodbase}} function will be faster, and more useful (see examples).
#'
#' The \code{path} argument is helpful if you are off the USGS network, in which case data can be downloaded from the web by specifying \code{path = "GitHub"}. Note that data are not routinely pushed to GitHub, however, so the data there may be slightly dated. Alternately, you can specify \code{path} to a local directory (see examples).
	
#' @return Creates a dataframe containing the desired data from the Foodbase database.

#' @seealso \code{\link{foodbase}}, which provides more powerful formatting for working with data from the Foodbase database.

#' @concept access, database

#' @examples
#' ## Read in drift sample data from the network (all the defaults).
#' foo <- readDB()
#'
#' ## Subset only data from Lees Ferry
#' foo2 <- foo[foo$Reach == "CRLeesFerry",]
#'
#' ## Get the specimen data for these samples, all wrapped together and formatted nicely.
#' foo3 <- foodbase(samp = foo2)
#'
#' ## Or, if you don't like shiny things, get the specimen data from GitHub.
#' fugly <- readDB(type = "Specimen", path = "GitHub")
#'
#' ## Example of data stored in a local directory.
#' loc <- readDB(path = "C:/Users/nflanders/Documents/Analysis/")

#' @author Jeffrey D. Muehlbauer, \email{jmuehlbauer@usgs.gov}

#' @export

## Function call
readDB <- function(gear = "Drift", type = "Sample", path = "Network"){

## Set the file path to USGS P drive, GitHub repository, or a different, specified path
if(path == 'Network'){
	path1 <- 'P:/BIOLOGICAL/Foodbase/Database/Exports/'	
} else {
	if(path == 'GitHub'){
		path1 <- 'https://raw.githubusercontent.com/jmuehlbauer-usgs/Database/master/'
	} else {
		path1 <- paste0(path, '/')
	}
}

## Read in the data,type
dat <- read.csv(paste0(path1, gear, type, '.csv'))
return(dat)

## Close function
}