 output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file1
    
    
    if (is.null(inFile))
      return(NULL)
    

    name<-strsplit(basename(as.character(input$file1)),"[.]")[[1]][1]
    divide(read.xlsx(inFile$datapath,1),name)
  })
  
  
  

  
  datasetInput <- reactive({
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    name<-strsplit(basename(as.character(input$file1)),"[.]")[[1]][1]
    divide(read.xlsx(inFile$datapath,1),name)
  })
  
  output$table <- renderTable({
    datasetInput()
  })
  
  output$downloadData <- downloadHandler(
    filename = function() { 
      name<-strsplit(basename(as.character(input$file1)),"[.]")[[1]][1]
      paste(name, '.csv', sep='') 
    },
    content = function(file) {
      write.csv(datasetInput(), file)
    }
  )
  
 
  
  
  divide<-function(filename,name){
    totalM = length(which(filename$旅客列车梯形密度表..日均.. == "上车站"))
    daily<-name
    
    firstTime = 1
    for(i in 1:totalM){
      trainNo <- filename[which(filename$旅客列车梯形密度表..日均.. == "上车站")[i]-1,]
      trainNo <- strsplit(as.character(trainNo[1,1]), " ")[[1]][1]
      
      a <- filename[which(filename$旅客列车梯形密度表..日均.. == "上车站")[i]:which(filename$旅客列车梯形密度表..日均.. == "上车人数合计")[i],1:which(filename[which(filename$旅客列车梯形密度表..日均.. == "上车站")[i],]=="下车人数合计")]
      colnames(a) <- as.data.frame.array(a[1,]) 
      a <- a[-1,]
      rownames(a) <- a[,1]
      b <- c("ZD111-01","ZD111-02","ZD311","ZD326","ZD192","ZD022","ZD250","ZD062","ZD120","ZD121","ZD143","ZD370","ZD190-02","ZD190-01")
      
      c2 <- data.frame()
      c2 <- a[,2]
      if(count(names(a) %in% b)[1,2]!=length(names(a) %in% b)){
        
        if(count(names(a) %in% b)[2,2] >=2 ){
          c2 <- cbind(c2,a[,(names(a) %in% b)])
        }else{
          c2 <- cbind(c2,a[,1:2],a[,(names(a) %in% b)])
          c2 <- c2[,-2]
          c2 <- c2[,-2]
          for(n in 1:length(names(a) %in% b)){
            if((names(a) %in% b)[n]==TRUE){
              break
            }
          }
          colnames(c2)[2] <- colnames(a)[n]
        }
        
        if(length(c2[1,])>=2){
          for(m in 2:length(c2[1,])){
            c <- c2[,1:2]
            c <- cbind(c,c2[,m])
            colnames(c)[3] <- colnames(c2)[m]
            c <- c[,-2]
            c <- c[!is.na(c[,2]),]
            
            if(firstTime==1){
              firstTime=0
              d <- t(data.frame(c("当日时间","車次","上車站","下車站","到站時間","離站時間","人數"),
                                c(name,trainNo,colnames(c)[2],rownames(c)[3],as.character(c[1,2]),as.character(c[3,1]),as.character(c[3,2]))
              ))
              colnames(d) <- d[1,]
            }
            if(length(c[,2])>4){
              d <- rbind(d,c(name,trainNo,colnames(c)[2],rownames(c)[3],as.character(c[1,2]),as.character(c[3,1]),as.character(c[3,2])))
            }
            
            totalR = length(c[,2]) -4
            if(totalR >0){
              for(j in 1:totalR){
                d <- rbind(d,c(name,trainNo,colnames(c)[2],rownames(c)[3+j],as.character(c[1,2]),as.character(c[3+j,1]),as.character(c[3+j,2])))
              }
            }
            
            totalC = length(c[1,]) -2
            if(totalC >0){
              for(k in 1:totalC){
                c <- c[,-2]
                c <- c[!is.na(c[,2]),]
                d <- rbind(d,c(name,trainNo,colnames(c)[2],rownames(c)[3],as.character(c[1,2]),as.character(c[3,1]),as.character(c[3,2])))
                
                totalR2 = length(c[,2]) -4
                if(totalR2 > 0){
                  for(l in 1:totalR2){
                    d <- rbind(d,c(name,trainNo,colnames(c)[2],rownames(c)[3+l],as.character(c[1,2]),as.character(c[3+l,1]),as.character(c[3+l,2])))
                  }
                }
              }
            }
          }
        }
      }
    }
    d <- d[-1,]
    rownames(d) <- NULL
    return(d)
  }
  
   
}

