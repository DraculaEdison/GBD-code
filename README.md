# GBD study in childhood sexual abuse 

In the three folders provided, we present the codes and their associated test data for the key sections in analyzing the global burden of childhood sexual abuse, as reported in the study "Global, regional, and national burden of childhood sexual abuse, 1990-2019: Results of the Global Burden of Disease Study 2019," published in Nature Human Behaviour.

(1) System requirements and installation guide:

R is an integrated suite of software facilities for data manipulation, calculation and graphical display. The latest version of R can be downloaded from the official website (The R Project for Statistical Computing), we are using version 4.3.1, which operates on Windows 11(Installation environment: Win7 and above, 64-bit operating system), but it is easy to install R on any operating system (Hardware requirements: CPU@2.0GHz RAM @ 4G (or higher)), just keep clicking on Next after the download to determine the installation path. Rstudio is the most widely used Integrated Development Environment (IDE) for R. The installation process also involves clicking Next and setting the installation location. Installation time is generally less than 20 minutes.

(2) The power of the R language lies in the ability to "plug and play" various toolkits. Among them, the insertion process is the package installation process, with install.packages function to achieve; with the process is the package loading process, with library function to achieve. 

Example:

install.packages(" ")  # only need to install once

library(  )  # need to be loaded every time you use it

(3) Instructions for data entry:

We can easily import or read .csv files using the basic R function read.csv() # read data stored in .csv file

x <- read.csv(“file_name.txt”, header=TRUE/FALSE) # Simple R program to read txt file
x <- read.csv("D://Data//myfile.txt", header=FALSE)
 
# print x
print(x)
