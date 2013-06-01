--CiderRunMode = {};CiderRunMode.runmode = true;CiderRunMode.assertImage = true;require "CiderDebugger";
require ( "vservAds" )


local options = { }
options.zoneID = "3329"
options.skipLabel = "Skip Ad"
options.exitLabel = "Exit"
options.adTitle =  "Ads by Vserv"
options.showAt =    "both"--OR "end" OR "start" --both
options.viewMandatory = "false"

local function exitAdEvent (event) 
       local screenObj = display.getCurrentStage( )
       local i = screenObj.numChildren --1 
       local countObj = display.getCurrentStage( ).numChildren
       
        while i >= 1 do 
        
            screenObj:remove(i)
            i = i-1
        end  
      if options.showAt == "both" then
          vservAds.vservLibInitCall()-- options )
      elseif options.showAt == "end" then
          vservAds.vservLibInitCall()-- options )
      elseif options.showAt == "start" then
                     os.exit()
      end
	
end

local function exitButton()
    
    local exitBtn = display.newText("Exit App", 0, 0, native.systemFontBold, 16 ) 
    exitBtn.x = display.contentWidth - 40 --* 0.5 + 100-- Position it to centrescreen
    exitBtn.y = display.contentHeight -- * 0.5  + 30 
    exitBtn:setTextColor( 255,255,255 )
	-- Text Background -- 
    local myRoundedRect = display.newRoundedRect(0, 0, exitBtn.width * 1.1 + 10, exitBtn.height * 1.1 + 10 , 10) --Create a rectangle for background slightly larger than text
    -- myRoundedRect.strokeWidth = 3
    myRoundedRect.x = exitBtn.x
    myRoundedRect.y = exitBtn.y
    myRoundedRect:setFillColor( 140, 140, 140 )
    -- myRoundedRect:setStrokeColor(180, 180, 180) 
    myRoundedRect:toBack()
    exitBtn:addEventListener( "touch", exitAdEvent) 
end

local function start()

vservAds.initialize( options )
    if options.showAt == "start" then
        vservAds.vservLibInitCall( )-- options )
    elseif  options.showAt == "both" then
        vservAds.vservLibInitCall( )--options )
    else
       clientApp()
       local var = options.showAt
       
       vservAds.handleExitAd(var)
     end
end

    -- Key listener
--[[
local function onKeyEvent( event )
        local phase = event.phase
        local keyName = event.keyName
        eventTxt.text = "("..phase.." , " .. keyName ..")"
 
        -- we handled the event, so return true.
        -- for default behavior, return false.
        return true
end
 
-- Add the key callback
Runtime:addEventListener( "key", onKeyEvent );]]--

function vservAds.vservSkipAd() 
 
 --native.showAlert( "check VservSkipAd", "client side4" , { "Ok" } , nil )
 local myText = display.newText("Hello World", 0, 0, native.systemFont, 50)
    myText.x = display.contentCenterX
    myText.y = 120
   exitButton()
   
   
end

function clientApp()

    local myText = display.newText("Hello World", 0, 0, native.systemFont, 50)
    myText.x = display.contentCenterX
    myText.y = 120
    exitButton()
   
end

start()