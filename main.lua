-- Make Ad features available under "vservAds" namespace
require ( "vservAds" )

local options = { }
options.zoneID = Your_ZoneID --Enter your ZoneID here, Note it's a string value
options.showAt =    "both"--OR "end" OR "start" --both
options.viewMandatory = "false" -- Check for Connection activity

--Vserv exit Ad implementation
----Please do not modify this method
local function exitAdEvent (event) 
       local screenObj = display.getCurrentStage()
       local i = screenObj.numChildren
       local countObj = display.getCurrentStage().numChildren
       
        while i >= 1 do 
            screenObj:remove(i)
            i = i-1
        end  
     
      if options.showAt == "start" then
          os.exit()
      else
          vservAds.vservLibInitCall()
      end
end

 --Exit Method
 ----Use this method to finish/exit you app. Make sure you call the exitAdEvent
local function exitButton()
	--App Cleanup/exit code
	--For this app we exit the app when the Exit button in pressed,you may select to call exitAdEvent directly
    local exitBtn = display.newText("Exit App", 0, 0, native.systemFontBold, 16 ) 
    exitBtn.x = display.contentWidth - 40
    exitBtn.y = display.contentHeight 
    exitBtn:setTextColor( 255,255,255 )
    local myRoundedRect = display.newRoundedRect(0, 0, exitBtn.width * 1.1 + 10, exitBtn.height * 1.1 + 10 , 10) 
    myRoundedRect.x = exitBtn.x
    myRoundedRect.y = exitBtn.y
    myRoundedRect:setFillColor( 140, 140, 140 )
    myRoundedRect:toBack()
	
	--Vserv to handle App exit
    exitBtn:addEventListener( "touch", exitAdEvent) 
end

--Application Entry Method
----Please do not modify this method
local function start()
	--initialization call of vservAdSdk---------------
	vservAds.initialize( options )
    if options.showAt == "end" then
     	clientApp()
    else
        vservAds.vservLibInitCall()
     end
end

--Handler for the skip button, launches your App
function vservAds.vservSkipAd() 
 	clientApp()
end

--You need to either call your App from here or implement your launch sceen here
function clientApp()
    local myText = display.newText("Hello World", 0, 0, native.systemFont, 50)
    myText.x = display.contentCenterX
    myText.y = 120
    exitButton() 
end

--Start the app
start()
