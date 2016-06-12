---
title: Testing ImpressJS
author: Ramnath Vaidyanathan
mode  : selfcontained
framework: impressjs
github:
  user: ramnathv
  repo: slidify
twitter:
  text: "Slidify with impress.js!"
url:
  lib: ../../libraries
widgets     : [bootstrap, quiz, shiny, interactive, nvd3]            # {mathjax, quiz, bootstrap}
knit        : slidify::knit2slides
ext_widgets: {rCharts: [libraries/nvd3]}
--- .slide x:-1000 y:-1500 

<q>問題背景： **Coding** 是不是很**Boring**?</q>

--- .slide x:0 y:-1500

<q>真正的問題背景： **列車資料** 能否 **用R處理**  並可視化？</q>

--- .slide x:1000 y:-1500 

<q>程序猿有**255**種解決辦法！！！</q>


--- #title x:0 y:0 scale:4

<span class="try">and you should try</span>
# This one!^*
<span class="footnote">^* 報告人：王正</span>

--- #its x:850 y:3000 rot:45 scale:5

  **Slidify&GoogleVis** <br/>
期末專題報告：資料可視化？ [slidify](http://slidify.org) <br/>
基於 **R Package-Slidify** 的另類玩法.

--- #big x:3500 y:2100 rot:180 scale:6

將 <b>列車</b> <span class="thoughts">資料可視化</span>


--- #tiny x:2825 y:2325 z:-3000 rot:300 scale:1 


<span class="try">資料的型態：</span>
# 醜!^*
<span class="footnote">^* 那怎麼辦？</span>

![preview](/Users/apple/Documents/i work/about codes/Taiwan/R language/Demo/impressjs/Preview.jpg)



--- #ing x:3500 y:-850 rot:270 scale:6
使用 <b class="positioning">Shiny</b>, 將<b class="rotating">資料</b> 自動 <b class="scaling">處理</b> ：首先使用Shiny搭建一款APP，堆資料進行預處理。

--- #imagination x:6700 y:-300 scale:6

處理完之後，我們將看到 **可視化資料** 這才是我們的目標！ <b class="imagination">不只是Cool!</b>

--- #source x:6300 y:2000 rot:20 scale:4


<div class="row-fluid">
  <h2>上傳檔案：</h2>
  <div class="col-sm-4">
    <form class="well">
      <div class="form-group shiny-input-container">
        <label>请上传相应的xls檔案</label>
        <input id="file1" name="file1" type="file"/>
        <div id="file1_progress" class="progress progress-striped active shiny-file-input-progress">
          <div class="progress-bar"></div>
        </div>
      </div>
      <hr/>
      <a id="downloadData" class="btn btn-default shiny-download-link " href="" target="_blank">
        <i class="fa fa-download"></i>
        Download
      </a>
    </form>
  </div>
  <div class="col-sm-8">
    <div id="contents" class="shiny-html-output"></div>
  </div>
</div>

--- #one-more-thing x:6000 y:4000 scale:2

one more thing...

--- #its-in-3d x:6200 y:4300 z:-100 rotx:-40 roty:-10 scale:2

<span class="have">此</span> <span class="you">套</span> <span class="noticed">件</span> <span class="its">支</span> <span class="in">援</span> <b>3D<sup>*</sup></b>?

<span class="footnote">* 這就很有意思了！</span>

--- #rstats x:-1000 y:5000


```r
original<-read.csv("20150108.csv")
by1<-aggregate(original$人數,by=list(original$車次,original$下車站),sum)
names(by1)<-c("Train","Station","Man")
require(googleVis)
b1<-gvisBubbleChart(by1,idvar = "Train",sizevar = "Man",options=list(width=1200, height=700))  
plot(b1,tag = 'chart')
```

--- x:-1500 y:5500 




  
