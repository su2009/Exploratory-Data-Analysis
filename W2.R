setwd("d:/Users/yangsu/Desktop")
getwd()

library(ggplot2)
str(mpg)
#scatterplot
qplot(displ,hwy,data=mpg)
qplot(displ,hwy,data=mpg,shape=drv) #color might be better to be seen
# seperate points by certain categories with diff colors
qplot(displ,hwy,data=mpg,color=drv)
# adding statistics
qplot(displ,hwy,data=mpg,geom=c("point","smooth"))  #default:low S
qplot(displ,hwy,data=mpg,geom=c("point","smooth"),method="lm")  #linear regressoin
#histgram
qplot(hwy,data=mpg,fill=drv)
#density
qplot(hwy,data=mpg,geom="density",color=drv)
#facets
qplot(displ,hwy,data=mpg,facets=.~drv)
qplot(hwy,data=mpg,facets=drv~.)

# Basic components of a ggplot2 plot (time 2:42)

#build up qqplot in layers
g<-ggplot(mpg,aes(displ,hwy))
summary(g)
print(g)  # will get erros as no layers in the plot,meaning doesn't know how to draw
#this plot, eg:points or lines or sth else
p<-g+geom_point() #can also try"g+geom_line()"
print(p)  #same as "g+geom_point()",but the later one is not saved in the system 
#add smooth
p<-g+geom_point()+geom_smooth()
p<-g+geom_point()+geom_smooth(method="lm")
#add facet
p<-g+geom_point()+geom_smooth(method="lm")+facet_grid(.~drv) #important to have the correct lable structure
#add color
p<-g+geom_point(color="steelblue",size=4,alpha=1/2) #assign a constant value to the color
p<-g+geom_point(aes(color=drv),size=4,alpha=1/2) #assign data variable to the color
                                                #alpha: 透明度
#add notation
p<-g+geom_point(aes(color=drv))+labs(title="Example")+labs(x=expression("displ"),y=expression("hwy"))

#customize smoother
p<-g+geom_point()+geom_smooth(size=4,linetype=3,mothed="lm",se=FALSE)

#change the theme
p<-g+geom_point()+theme_bw(base_family="Times")

#control the axis limits
testdata<-data.frame(x=1:100,y=rnorm(100))
testdata
testdata[50,2]<-100
g<-ggplot(testdata,aes(x,y))
g+geom_line()+coord_cartesian(ylim=c(-3,3))

# remember to categorize continous variables into categorical ones for facets
cutpoints<-quantile(testdata$x,seq(0,1,length=4),na.rm=TRUE)
testdata$dec<-cut(testdata$x,cutpoints)
testdata
levels(testdata$dec)

g<-ggplot(testdata,aes(x,y))
p<-g+geom_point()+facet_grid(testdata$x~.)
print(p)  # have bug

# another example of plotting facets
library(dataset)
data(airquality)
#method 1: result: Error in layout_base(data, cols, drop = drop) : 
# At least one layer must contain all variables used for facetting
qplot(Wind, Ozone, data = airquality, facets = . ~ factor(Month))
#method 2:
airquality = transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)
