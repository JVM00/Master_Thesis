library(plyr)

all_nout %>% mutate(Exposure= as.factor(Exposure)) 
all_nout$Exposure <- revalue(all_nout$Exposure,c("202" = "Financial Corporations", "301" = "Non-Financial Corporations","401" = "Households"))

all_nout %>% ggplot(aes(x=Year, y=NPL_ratio)) + 
  stat_boxplot(geom = "errorbar", width = 0.2) +
  geom_boxplot(outlier.colour = "red", outlier.alpha = 0.3,fill="lightsteelblue2")+
  xlab("Year") +
  ylab("NPL ratio(%)")+
  # scale_fill_discrete("",labels = c("Financial Institutions","Non-Financial Institutions","Households"))+
  facet_wrap(~ Exposure, nrow = 1)+
  #scale_fill_brewer("",labels = c("Financial Institutions","Non-Financial Institutions","Households"),palette = "RdYlBu") +
  #scale_fill_discrete("",labels = c("Financial Institutions","Non-Financial Institutions","Households")) +
  #scale_fill_manual("",labels = c("Financial Institutions","Non-Financial Institutions","Households"), values = c("lightyellow", "lightsteelblue2","palegreen"))+
  #scale_colour_manual(values = c("lightsteelblue2"))+
  scale_y_continuous(breaks=seq(0,100,10),labels = scales::percent_format(accuracy = 1,scale = 1))+
  theme_bw()+
  theme(plot.title = element_text(hjust = 0.5,size=8))+
  theme(strip.background =element_rect(fill="lightblue4"))+
  theme(strip.text = element_text(colour = 'white',size = 8))+
  theme(legend.position="bottom",panel.background = element_rect(fill = "lightgray"),
        axis.text.x = element_text(angle = 30, hjust = 1, vjust = 1),axis.title.x = element_blank(),axis.title.y = element_blank())+
  theme(axis.text=element_text(size=8))+   
  theme(plot.caption = element_text(color = "black", face = "italic",hjust = 0.0))+
  labs(caption = "Source: EBA Transparency Exercises, authors' calculations")
#ggtitle("Boxplot")