module ( ..., package.seeall )
-- main.lua
--
-----------------------------------------------------------------------------------------
--Debug the smart way with Cider!
--start coding and press the debug button
-- Determine if running on Corona Simulator
--
--local isSimulator = "simulator" == system.getInfo("environment")

-- Determine the platform type
-- "iPhoneOS" or "Android" or "Mac OS X"
--
--local isAndroid = "Android" == system.getInfo("platformName")

--local js = require ("json")
--local xmlParser = require( "xml" ):newParser()
--local widget = require "widget"


            
            
local http = require("socket.http")
touchValue = 0 -- 
myBackBtnFlag = 0 --  firstScreenimg  = 1,  WebpopupScreen = 2,  clientScreen = 3,  exit = 4
backBtnFlagS  = 0 -- firstScreenImg = 1, WepPopUpScreen = 2 , SMSComposerScreen = 3, ClientScreen = 4,  exitScreen = 5 
checkShowAdValueFlag = 0
dataconnectionFlag = false -- for check dataconnection 
backBtnFlagB  = 0 --  firstScreenImg = 1, webPopUPScreen = 2, SmsScreen = 3, clientApp = 4 lastScreenImg = 5 webpopupScreen = 6 smsScreen =7 , exitScreen  
backBtnSetFlagForBoth = 1;
backBtnFlagE  = 0 -- ClientAppScreen = 1, lastScreenImg = 2, webPopupScreen = 3  SmsScreenImage = 4 exitScreen = 5 
adCountValue = 0 ; -- adcountvale 0 is ad display single time and adcountValue =1 img is display on last ( it's variable work on showAd=="both")
myBkgBtnbExitAdshowFlag = 0
backBtnDataConnectionOff = 0
myBothFlag = true; -- This flag  only working on Fetching Data  
myWebPopup = "false" 
skipFlag = true
hitCount = 1
touchCount = 0
checkRetryHit = 0
backBtnForSkipAd = 0;
 local function setSkipFlag (flag)
 	skipFlag = flag
 --	 print("print flag ",skipFlag) 		 
 end 
 
function initialize( params )
   -- print(params)
--local zoneID, showAt, skipLabel, exitLabel, adTitle, viewMandetory
    if params.zoneID then
        zoneID = params.zoneID
       -- print("Zontid " .. zoneID)
    end
    if params.showAt then 
        showAt = params.showAt
     --   print("showAt " .. showAt)
    end
    if params.adTitle then 
        adTitle = params.adTitle
      --  print("adTitle " .. adTitle)
    end
    if params.skipLabel then
        skipLabel = params.skipLabel
      --  print("skipLabel " .. skipLabel)
    end
    if params.exitLabel then
        exitLabel = params.exitLabel
  --      print("exitLabel " .. exitLabel)
    end
    if params.viewMandatory then
    	viewMandatory = params.viewMandatory
    	--print("viewMandatory " .. viewMandatory)
    end
end






--[[ 
local function Hex2RGB(sHexString)
	if String.Length(sHexString) ~= 6 then
		return -1, -1, -1
	else
		red = String.Left(sHexString,2)
		green = String.Mid(sHexString,3,2)
		blue = String.Right(sHexString,2)
		red = tonumber(red, 16);
		green = tonumber(green, 16);
		blue = tonumber(blue, 16);
		return red, green, blue
	end
    end
 local function listener( event )
	local shouldLoad = true
        native.showAlert( "Alert", event.type , { "OK" }, nil )
	local url = event.url
	if 1 == string.find( url, "Response.html" ) then
		-- Close the web popup
                native.showAlert( "Alert", event.url , { "OK" }, nil )
		shouldLoad = false
            else 
            native.showAlert( "Alert", event.url , { "OK" }, nil )
            system.openURL( url )    
        end 
	return shouldLoad
    end 
    ]]--
    
    local onButtonEvent = function (event )
        if event.phase == "release" then
           -- print( "You pressed and released a button!" )
          -- print("")
        end
    end
    
 --[[ local function buttomStatusBar(labelText) 
            buttonObj = display.newText( labelText, 0, 0, native.systemFontBold, 20 ) -- Create the text obejct
             print("Button Width " .. buttonObj.width )
            if (buttonObj.width ) > 0 then
                buttonObj.x = 25 --buttonObj.width + 10
                print("Button x Position " .. buttonObj.x )
            else
              --  print("Button Width " .. buttonObj.width )
              -- buttonObj.x = display.contentWidth - 40 --* 0.5 + 98-- Position it to centrescreen
               print("else Button Width " .. buttonObj.width )
            end
           --
            buttonObj.y = display.contentHeight + 20
            buttonObj:setTextColor( 255,255,232 )
    -- Text Background -- 
            local backGrd = display.newRect( 0, 0, buttonObj.width * 1.1, buttonObj.height * 1.1 ) -- Create a rectangle for background slightly larger than text
            backGrd.x = buttonObj.x
            backGrd.y = buttonObj.y
            backGrd:setFillColor( 150,150,150 )
            backGrd:toBack() -- Send rectangle to the back of the display group so we can see the text
    end]]--
    
   --[[ local function buttonCreation(textName)
        buttonGroup = display.newGroup()
         
        local options1 =  {id = "btn001", left = 0, top = 0,label = textName, width = 100, height = 28,cornerRadius = 12, onEvent = onButtonEvent}
        local myButton1 =   widget.newButton(options1)
        myButton1.x = display.contentWidth -50
        myButton1.y = 0
        buttonGroup:insert( 1, myButton1 )
        buttonGroup:setReferencePoint( display.TopRightReferencePoint )
    end
  ]]--
  
  local function processData()
	processData = display.newText("Fetching Data ...", 0, 0, native.systemFontBold, 20 )
     --   print(processData)
	processData.x = display.contentCenterX
    processData.y = 120
   --processData:setFillColor(255,255,255,0)
   
   
	--myText:setTextColor( 0, 0, 255 )
end  

-- bothProcessData() and bothRemoveProcessData()  function start Here

local function bothProcessData() --  this function only working on  showAd = "both"
    
    bothProcessData =  display.newText( "Fetching Data..", 0, 0, native.systemFontBold, 20 )
    bothProcessData.x =  display.contentCenterX
    bothProcessData.y  = 120
end

local function bothRemoveProcessData() --  This function onl working on showd = "both"
	if bothProcessData then
	--print("Remove Process Data: ", processData)
		display.remove(bothProcessData)
		bothProcessData = nil
	end	
end



-- bothProcessData() function end Here



local function removeProcessData()
	if processData then
	--print("Remove Process Data: ", processData)
		display.remove(processData)
		processData = nil
	end	
end
  
  
  local function removeElement()
  	--print("test Skip Button")
    --   local  webpopupflag =  native.cancelWebPopup()
     --   print("webPopup value is :", webpopupflag)
         
          --native.cancelWebPopup()
       -- native.showAlert( "check removeElement",  tostring(webpopupflag) , { "Cancel" } , nil )

   
       ---------------------
       native.cancelWebPopup()
       local screenObj = display.getCurrentStage()
       
       local i = screenObj.numChildren --1 
       local countObj = display.getCurrentStage().numChildren
      --  print("Number of Child in Screen " .. screenObj.numChildren)
      
        while i >= 1 do 
          --print ("index of i " .. i)
            screenObj:remove(i)
            i = i-1
        end 
          -- myBackBtnFlag = 4

      --  native.showAlert( "check removeElement", "remove Element Function Called" , { "Cancel" } , nil )
  end
  
    local function skipAdEvent( event )
   -- native.showAlert( "check Skip Event", "skip Ad Event Called" , { "Ok" } , nil )
   
--   if myWebPopup == "true" then
--       print("webopUp value is" ..myWebPopup)
--        local  webpopupflag =  native.cancelWebPopup()
--        print("webPopup value is :", webpopupflag)
--         
--          --native.cancelWebPopup()
--        --native.showAlert( "check removeElement",  tostring(webpopupflag) , { "Cancel" } , nil )
--    end

        setSkipFlag(false)
        removeElement()

   if myWebPopup == "true" then
       --print("webopUp value is" ..myWebPopup)
        local  webpopupflag =  native.cancelWebPopup()
        --print("webPopup value is :", webpopupflag)
         
          --native.cancelWebPopup()
       -- native.showAlert( "check removeElement",  tostring(webpopupflag) , { "Cancel" } , nil )
    end
   -- native.showAlert( "Check Hang", "on start Ad " , { "Ok" } , nil )
       -- print("sadhd")

 if showAt == "start" then -- write by  alok
        backBtnFlagS  = 5 
       checkShowAdValueFlag = 1
                            --print("backBtnFlagS")
                       end 
    --Method will Implement on client side 
        vservSkipAd()
        
    end
    
    local function exitAdEvent ( event )
 		removeElement()
        os.exit()
    end
    
    local function onComplete (event)
    --    print( "video session ended" )
          --print("")
    end
    
    
    
   
   
   -- Show Ad Title -- 
    local function titleBar() 
        --Screen Title Start
            titleText = display.newText( "Advt.", 0, 0, native.systemFontBold, 16 ) -- Create the text obejct
            titleText.x = display.contentWidth * 0.5-- Position it to centrescreen
            titleText.y = 10 --display.contentHeight --* 0.5
            titleText:setTextColor( 255,255,255 )
    -- Text Background -- 
            local backGrd = display.newRect( 0, 0, titleText.width * 1.1, titleText.height * 1.1 ) -- Create a rectangle for background slightly larger than text
            backGrd.x = titleText.x
            backGrd.y = titleText.y
            backGrd:setFillColor( 60,60,60 )
            backGrd:toBack() -- Send rectangle to the back of the display group so we can see the text
    --screen title end
    end
    local function skipAddButton() 
    --Skip Ad Button Start
    local  skipAdBtn   
    -- native.showAlert( "End Label", showAt , { "Ok" } , nil )
    		if showAt == "start" then
    			if skipLabel then
            	skipAdBtn = display.newText(skipLabel, 0, 0, native.systemFontBold, 16 ) -- Create the text obejct
            	else
            	skipAdBtn = display.newText("skip Ad", 0,0, native.systemFontBold, 16 )
            	end
            	backBtnForSkipAd = 2
            elseif showAt == "end" then
              --  native.showAlert( "End Label", "End Label called" , { "Ok" } , nil )
            	if exitLabel then
            	exitAdBtn = display.newText(exitLabel, 0, 0, native.systemFontBold, 16 ) -- Create the text obejct
            	else
            	exitAdBtn = display.newText("exit Ad", 0, 0, native.systemFontBold, 16 )
            	end
            	backBtnForSkipAd = 4
            elseif showAt == "both" then 
        		if skipFlag then
            	--	print("skip ad : " )
                        --print("")        
            		if skipLabel then
            		--native.showAlert( "Hit Count in Skip:  ", hitCount ,{ "OK"}, nil )
            			if hitCount == 1 then
	            			skipAdBtn = display.newText(skipLabel, 0, 0, native.systemFontBold, 16 ) -- Create the text obejct
	            			backBtnForSkipAd = 2
	            		elseif hitCount > 1 then 
	            			if exitLabel then
	            				exitAdBtn = display.newText(exitLabel, 0, 0, native.systemFontBold, 16 )
	            			else
	            				exitAdBtn = display.newText("exit Ad", 0, 0, native.systemFontBold, 16 )
	            			end
	            			backBtnForSkipAd = 4
	            		end
	            	else 
	            	skipAdBtn = display.newText("skip Ad", 0, 0, native.systemFontBold, 16 )
	            	backBtnForSkipAd = 2
	            	end
	            	setSkipFlag(false)
            	else
            		--print("exit ad : " )
                        --print("")
            		if exitLabel then
            		--native.showAlert( "Hit Count in exit:  ", hitCount ,{ "OK"}, nil )
						if hitCount >=1 then
	            			exitAdBtn = display.newText(exitLabel, 0, 0, native.systemFontBold, 16 ) -- Create the text obejct
	            		end
	            	else
	            	exitAdBtn = display.newText("exit Ad", 0, 0, native.systemFontBold, 16 )
	            	end
	            	backBtnForSkipAd = 4
	            	setSkipFlag(true)
            	end	
            else
            	if skipLabel then
            	skipAdBtn = display.newText(skipLabel, 0, 0, native.systemFontBold, 16 ) -- Create the text obejct
            	else
            	skipAdBtn = display.newText("skip Ad", 0, 0, native.systemFontBold, 16 )
            	end
            	backBtnForSkipAd = 2
            end
            if skipAdBtn then
            skipAdBtn.x = display.contentWidth - 40 --* 0.5 + 98-- Position it to centrescreen
            skipAdBtn.y = 10 --display.contentHeight --* 0.5
            skipAdBtn:setTextColor( 255,255,255 )
    -- Text Background -- 
            local myRoundedRect = display.newRoundedRect(0, 0, skipAdBtn.width * 1.1 + 10, skipAdBtn.height * 1.1 + 10 , 10) --Create a rectangle for background slightly larger than text
            -- myRoundedRect.strokeWidth = 3
            myRoundedRect.x = skipAdBtn.x
            myRoundedRect.y = skipAdBtn.y
            myRoundedRect:setFillColor( 140, 140, 140 )
            -- myRoundedRect:setStrokeColor(180, 180, 180) 
            myRoundedRect:toBack() -- Send rectangle to the back of the display group so we can see the text
            
           --[[ local backGrd = display.newRect( 0, 0, skipAdBtn.width * 1.1, skipAdBtn.height * 1.1 ) -- Create a rectangle for background slightly larger than text
                backGrd.x = skipAdBtn.x
                backGrd.y = skipAdBtn.y
                backGrd:setFillColor( 150,150,150 )
                backGrd:toBack() -- Send rectangle to the back of the display group so we can see the text
            ]]--
    --Skip Ad Button End
    	skipAdBtn:addEventListener( "touch", skipAdEvent)
    	elseif exitAdBtn then
            exitAdBtn.x = display.contentWidth - 40 --* 0.5 + 98-- Position it to centrescreen
            exitAdBtn.y = 10 --display.contentHeight --* 0.5
            exitAdBtn:setTextColor( 255,255,255 )
    -- Text Background -- 
            local myRoundedRect = display.newRoundedRect(0, 0, exitAdBtn.width * 1.1 + 10, exitAdBtn.height * 1.1 + 10 , 10) --Create a rectangle for background slightly larger than text
            -- myRoundedRect.strokeWidth = 3
            myRoundedRect.x = exitAdBtn.x
            myRoundedRect.y = exitAdBtn.y
            myRoundedRect:setFillColor( 140, 140, 140 )
            -- myRoundedRect:setStrokeColor(180, 180, 180) 
            myRoundedRect:toBack() -- Send rectangle to the back of the display group so we can see the text
    --Exit Ad Button End
    	exitAdBtn:addEventListener( "touch", exitAdEvent)
        myBackBtnFlag = 5
        
    	end
    end
            
            
--[[local function xmlParsing()
    print("xmlParser")
    local adResponse = xmlParser:loadFile("xmlRespAd.xml")
   -- local ads = {}
    --local ad = {}
    local media = {}
    local impressionNode = {}

    -- for each "child" in the inbox table...
    for i=1,#adResponse.child do
        -- store the address in the message table
        impressionNode[i] = adResponse.child[i].child[i].child[2]
        print(impressionNode[i].name)
        media[i] = adResponse.child[i].child[i].child[i]
        print(media[i].name)
    end
    for i=1,#media do
        -- extract data from table and store in local variables
        -- for easier readability/access:
        print( "Body: ", media[i].child[1].name)
        print( "Body: ", media[i].child[2].name .. "Value ", media[i].child[2].value)
    end
     
end
]]--
local function parseMediaNode(xmlData) 
 	if string.find(xmlData, "<media") then
		local mediaString =  string.sub(xmlData, string.find(xmlData, "<media"), string.find(xmlData, "</media>"))
		 if string.find(mediaString, "type") then
			local typeString = string.sub(mediaString, string.find(mediaString, "type=\""), string.find(mediaString, "\" ")-1)
			--print("media type ", typeString)
			mediaType = string.sub(typeString, string.find(typeString, "\"")+1)
			--print("media type", mediaType)		
		end
		 if 1 == string.find(mediaType, "text") then 
			--print("type string  ")
		 	local testString = string.sub(mediaString, string.find(mediaString, "<text>"), string.find(mediaString, "</text>")-1)
		 --	print("test String " ..testString)
		 	mediaText = string.sub(testString,string.find(testString, ">")+1)
                      --  native.showAlert( "Media Text", mediaText, { "Ok" }, nil )
		 --	print("text " .. mediaText)
	 	elseif 1 == string.find ( mediaType , "image" ) then 
	 		--mediaImageUrl = {}
	 	--	local i = 1
		 	local mediaImageString = mediaString
		 --	while string.find(mediaImageString, "<url>") do 
		 	--	print("prior string " , mediaImageString) 
			 	local imageString = string.sub(mediaImageString, string.find(mediaImageString, "<url>"), string.find(mediaImageString, "</url>")-1)
			 	--print("image String " ..imageString)
			 	mediaImageUrl = string.sub(imageString,string.find(imageString, ">")+1)
                              --  native.showAlert( "MediaImage Url ", mediaImageUrl, { "Ok" }, nil )
			 	--print("image Url  " .. mediaImageUrl)
			 	--local extractIndex = string.find(mediaImageString, "</url>")
			 	--local stringImages = string.sub(mediaImageString, extractIndex+6)
			 	--mediaImageString = stringImages
			 	--i = i+1
		--	end
		end
		
	end
 end
 
 local function parseActionsNode (xmlDataString)
	if string.find(xmlDataString, "<action") then
		local action =  string.sub(xmlDataString, string.find(xmlDataString, "<action "), string.find(xmlDataString, "</action>")-1)
		--print("action string ", action )
		if string.find(action, "type") then
			local actionTypeString = string.sub(action, string.find(action, "type=\""), string.find(action, "\">")-1)
			--print("action type ", actionType)
 			actionType = string.sub(actionTypeString, string.find(actionTypeString, "=")+2)
			--print("action type", actionType)		
		end
		if string.find(action, "<label>") then
			local labelString = string.sub(action, string.find(action, "<label>"), string.find(action, "</label>")-1)
			--print("action Label ", labelString)
			actionLabel = string.sub(labelString, string.find(labelString, ">")+1)
			--print("label ", actionLabel)
		end
		if string.find(action, "<url>")then
			local actionUrlString = string.sub(action, string.find(action, "<url>"), string.find(action, "</url>")-1)
			--print(actionUrl)
			actionUrl = string.sub(actionUrlString, string.find(actionUrlString, ">")+1)
			--print("click url ", actionUrl)
		end
		if string.find(action, "<data>")then
			local dataString = string.sub(action, string.find(action, "<data>"), string.find(action, "</data>")-1)
			--print(dataString)
			actionData = string.sub(dataString, string.find(dataString, ">")+1)
			--print("action data ", actionData)
		end
		if string.find(action, "<number>")then
			local numberString = string.sub(action, string.find(action, "<number>"), string.find(action, "</number>")-1)
			--print(dataString)
			actionNumber = string.sub(numberString, string.find(numberString, ">")+1)
			--print("action number ", actionNumber)
		end
		if string.find(action, "<trackers>") then
			local trackersString = string.sub(action, string.find(action, "<trackers>"), string.find(action, "</trackers>")-1)
			--print(trackersString)
			local trackerUrlStr = string.sub(trackersString, string.find(trackersString, "<url>"), string.find(trackersString, "</url>")-1)
			--print("trackerUrl String ", trackerUrlStr)
			actionTrackUrl= string.sub(trackerUrlStr, string.find(trackerUrlStr, ">")+1)
			--print("tracker url String ", actionTrackUrl)
		end
	end
 end
 
 local function parseImpressionString(xmlDataString) 
 	if string.find(xmlDataString, "<impressions>") then
		local impressions =  string.sub(xmlDataString, string.find(xmlDataString, "<impression "), string.find(xmlDataString, "</impression>")-1)
		--print("impression string ", impressions )
		impressionUrl = string.sub(impressions, string.find(impressions, ">")+1)
		--print("impression url ", impressionUrl)
	end
 end
 
 local function getActionType()
 	if actionType then
 		return actionType
 	end 
 	return actionType
 end
 
 local function getActionUrl()
 	if actionUrl then
 		return actionUrl
 	end
 	return actionUrl
 end 
 
 local function getActionData()
 	if actionData then
 		return actionData
 	end
 	return actionData
 end
 
 local function getActionNumber()
 	if actionNumber then
 		return actionNumber
 	end
 	return actionData
 end
 
 local function getTrackUrl()
 	if actionTrackUrl then
 		return actionTrackUrl
 	end
 	return actionTrackUrl
 end
 
 local function getMediaType()
 	if mediaType then
 		return mediaType
 	end
 	return mediaType	
 end
 
  local function getMediaImageURL()
      --print( "media Image Image Url is",mediaImageUrl)
 	if mediaImageUrl then
 		return mediaImageUrl
 	end
 	return mediaImageUrl	
 end
 
 local function getMediaText()
 	--print("media Text Check",mediaText)
        --print(mediaText);
        if mediaText then
 		return mediaText
 	end
 	return mediaText 
 end
 
 local function getImpressionURL()
 	if impressionUrl then
 		--print("impressionUrl " .. impressionUrl)
 		return impressionUrl
 	end
 	return impressionUrl
 end
     
local function parseXmlString()
	local xmlDataString = jsonFile("myFile.xml", system.DocumentsDirectory ) -- ("xmlRespAd.xml", system.ResourceDirectory)
	--print("parseXmlString : " .. xmlDataString)
	parseMediaNode(xmlDataString)
	parseImpressionString(xmlDataString)
	parseActionsNode(xmlDataString)
	--print("Media Type Return" , getMediaType())
	--print("Action Type Return", getActionType())
	return xmlDataString
end

local function clickEventListener (event)
	--removeProcessData()
end


local function httpPostRequest1()
    
   local userAgent = getUserAgent()
   -- print("userAgent =  " .. userAgent)
    getDeviceInfo()
     local sHeight = display.contentHeight
     local sWidth = display.contentWidth
   --  print("screen width".. sWidth,"screen height".. sHeight)
        if zoneID then
            postData = "zoneid=".. zoneID .. "&ua=" .. userAgent .."&tm=0&app=1&sw=" .. sWidth .. "&sh=" ..sHeight.. "&zf=1&ml=xml"
        else
         postData = "zoneid=5791&ua=" .. userAgent .."&tm=1&app=1&sw=" .. sWidth .. "&sh=" ..sHeight.. "&ml=xml"
        end
    local params = {}
    params.body = postData
    --print("post body = " ..params.body)
    local url = "http://a.vserv.mobi/delivery/adapi.php" --?zoneid=399&tm=1&app=1"
    checkRetryHit= checkRetryHit + 1
    --print( "checkRetryHit valueagsah is:", checkRetryHit )
    network.request( url, "POST", networkListener,params )
  
end

 local function onClickAlert( event )
        if "clicked" == event.action then
                local i = event.index
                if 1 == i then
                os.exit()
                        -- Retry Again 
                      --initialize(params) 
                   --   print("Retry called")
                      --httpPostRequest1()
                elseif 2 == i then
                        -- Open URL if "exit" (the 2nd button) was clicked
                        os.exit()
                end
        end
end

local function touchEventListener( event ) 
       -- print( "Listener called with event x coordinates " .. event.x," event y".. event.y)
         
      --  native.cancelWebPopup( )  -- comment by Alok
      myWebPopup = "true"; -- Add  by Alok
      touchCount= touchCount+1;
--      native.showAlert("Touch Event Count", tonumber ( touchCount ) , { "Ok" } , nil )
        local id = event.target
         
         	
                if event.phase == "began" then
         		id:setFillColor(200,255,255)
			elseif event.phase == "ended" then
				id:setFillColor(255,255,255)
                                
                                
         	end
        
--        local options = { hasBackground=false, baseUrl=system.DocumentsDirectory, urlRequest=listener }
--        local showWebPopup =   native.showWebPopup( 0, 50 , 400, 400,"http://google.co.in" , options )  


----     New Coding Start Here

if 1 == string.find ( getActionType() , "sms" ) then 
            --print("sms")
            smsCall(getActionNumber(), getActionData())
            myBackBtnFlag  = 3
        if showAt == "start" then -- write by  alok
           backBtnFlagS  = 1
           checkShowAdValueFlag = 1 
           --print("backBtnFlagS")
        end 

 elseif 1 == string.find ( getActionType() , "url" ) then

        local options = { hasBackground=true, baseUrl=system.DocumentsDirectory, urlRequest=listener }
--        local showWebPopup =   native.showWebPopup( 0, 50 , 400, 400,"http://google.co.in" , options )  
        native.showWebPopup(0, titleText.height+10, display.contentWidth, display.contentHeight, getActionUrl(), options )
        --print("touch Event .....")    
        myBackBtnFlag  = 2 -- wtite by alok
        backBtnForSkipAd = 1;
        if showAt == "start" then -- write by  alok
           backBtnFlagS  = 2 
           checkShowAdValueFlag = 1 
           --print("backBtnFlagS")
       end  
       if showAt == "end" then -- write by  alok
           backBtnFlagE  = 3 
           checkShowAdValueFlag = 1 
           --print("backBtnFlagS")
       end 
       --
       
              if adCountValue == 0 then
                  backBtnFlagB = 5
              else
                  backBtnFlagB = 13 -- dummy value
              end
              
       --
       -----   End Coding End Here

------- Tracker  coding start here 
----
--local trackUrl = getTrackUrl()
--           if trackUrl and touchValue == 0 then
--          -- print("Track  Notify:" , trackUrl)
--          touchValue = 1
--           --network.request( jsondata.render[1].notify[1], "GET", nil )
--           		network.request( trackUrl, "GET", nil )
--           else
--           	print("do nothing on track url  ")
--           end
--
--     end   
------- Tracker Coding End Here


end



-----   End Coding End Here

--- Tracker  coding start here 

local trackUrl = getTrackUrl()
           if trackUrl and touchValue == 0 then
               touchValue = 1
          -- print("Track  Notify:" , trackUrl)
           --network.request( jsondata.render[1].notify[1], "GET", nil )
           		network.request( trackUrl, "GET", nil )
           else
           	--print("do nothing on track url  ")
           end  

end
--- Tracker Coding End Here
--

       --  local jsonData = js.decode( jsonFile( "myFile.json",system.DocumentsDirectory ) ) --( "jsTextAd.json" , system.ResourceDirectory)) --
        -- print("type ".. jsonData.action[1].type)
        --if 1 == string.find ( jsonData.action[1].type , "sms" ) then 
        --processData()
          
          --[[ start Here
          print("touch event p")
         if 1 == string.find ( getActionType() , "sms" ) then 
            print("sms")
            smsCall(getActionNumber(), getActionData())
       -- elseif 1 == string.find ( jsonData.action[1].type , "wap" ) then
        elseif 1 == string.find ( getActionType() , "url" ) then
            --native.showAlert( "Alert", "touch event"  , {"Ok"}, nil)
           print("asdajjj")
            local options = { hasBackground=true, baseUrl=system.ResourceDirectory, urlRequest=clickEventListener }
           -- print("RESPONSE: " .. getActionNumber() ) --jsonData.action[1].data )
            --native.showAlert( "Click Action", jsonData.action[1].data, { "OK"}, nil )

            webPopupVFlag = native.showWebPopup(0, titleText.height+10, display.contentWidth, display.contentHeight, getActionUrl(), options )
            print("webPopUpVFlag" ..webPopupVFlag)
             --native.showAlert( "check showWebPop",  tostring(webPopupVFlag) , { "Ok" } , nil )
        elseif 1 == string.find ( getActionType() , "video" ) then
          --  print("RESPONSE: Video" .. getActionUrl()) --jsonData.action[1].data )
            local videoUrl = getActionUrl()
            if videoUrl then
            	media.playVideo( videoUrl, true, onComplete)
            else
            	native.showAlert( "Alert", "Video not found"  , { "OK" }, nil )	
            end	
        end
        local trackUrl = getTrackUrl()
           if trackUrl then
          -- print("Track  Notify:" , trackUrl)
           --network.request( jsondata.render[1].notify[1], "GET", nil )
           		network.request( trackUrl, "GET", nil )
           else
           	-- print("do nothing on track url  ")
           end
      --  jsonData = nil]
      --]] --End Here
--    end 
    
 local function imageDowloadListener (event) 
        if(event.isError ) then
        	--native.showAlert( "Alert", "Please Check your Network Connection"  , {"Ok"}, onClickAlert )
           -- print("Network Error")
           -- native.showAlert( "Please Check your Network Connection" )
           --print("")
       else
 --          removeProcessData( )
          if myBothFlag then  -- write by alok 20121016_2056
                bothRemoveProcessData()
           else
        	removeProcessData()
           end                      --  write by alok 2012116

        --    print("Network success")
           -- local i = 1 
           -- local imageTable = {}
           -- local  imageTable = getMediaImageURL()
          --  local myImage = {}
           -- for i = 1, #imageTable do
--            	myImage = display.newImage( "firstImg.png", system.TemporaryDirectory, 0, titleText.height + 10, true) comment by alok
              -- native.showAlert("Image Load","load", {"Ok"},nil)
                myImage = display.newImage( "firstImg.png", system.TemporaryDirectory, 0, titleText.height + 80, true)
                myImage:addEventListener( "touch", touchEventListener )
                
                myBackBtnFlag  = 1 -- write by alok
                if showAt == "start" then -- write by  alok
                            backBtnFlagS  = 1 
                            checkShowAdValueFlag = 1
                            --print("backBtnFlagS")
                        end
                        if showAt == "both" and backBtnSetFlagForBoth == 1 then -- write by  alok
                            backBtnFlagB  = 1 
                            --checkShowAdValueFlag = 1
                            --print("backBtnFlagS")
                            backBtnSetFlagForBoth = 0
                        elseif showAt == "both" and backBtnSetFlagForBoth == 0 then
                         --   native.showAlert( "check backBtnalue on oth", "zero", { "ok" }, nil )
                            backBtnFlagB = 10
                        elseif showAt == "end" then
                            backBtnFlagE  = 5 -- for Exit the App 
                        end 

                        
                --print("imageDownloadListener")
          --	end
          -- myImage.y = titleText.height + 100
          -- local jsondata = js.decode( jsonFile( "myFile.json",system.DocumentsDirectory ) )
           local impressionUrl = getImpressionURL()
           if impressionUrl then
       --    print("impression Url Notify :" , impressionUrl)
           --network.request( jsondata.render[1].notify[1], "GET", nil )
           		network.request( impressionUrl, "GET", nil )
           else
           	-- print("do nothing on network ")
                --print("")
           end
          -- for i = 1, #myImage do
          		--myImage:addEventListener( "touch", touchEventListener )
         --  end
         --  jsondata = nil
       end
   end    
    
   
-- New Code start here  for check  dataconnection  20121025_1859
   
 local function checkDataConnection()

--local viewMandatorys = "true"
 if viewMandatory == "true" then 
-- local function onCloseApp( event )
  --print("ddddddddddddd")
 if http.request( "http://www.vserv.mobi" ) == nil then
   --   print("sttdsssddddddddd")
      dataconnectionFlag = true
      backBtnDataConnectionOff = 1

     -- native.showAlert( "Alert", "An internet connection is required to use this application.", { "Exit" }, onClickAlert )
 else    
       --print("connection avaliable")
       dataconnectionFlag = false
end
end
end
-- New Code End here for check dataconnection  20121025_1859
    
local function networkListener( event )
        if ( event.isError ) then
            --print("viewMandatory before Value is:", viewMandatory)

            --if viewMandatory == "true" then -- This code comment by alok , this code write by gaytri

                checkDataConnection() -- write by alok 2121025_2005 for check network connection            
        	if viewMandatory == "true" and dataconnectionFlag then  -- write by alok 2121025_2005 add new dataconnectionlag flag in condition 
                    --print("viewMandatory after Value is:", viewMandatory)
                   if showAt == "end" then
                           os.exit()
                           backBtnDataConnectionOff = 1
                   else
                                   native.showAlert( "Alert", "Data Connection is not avaliable"  , {"Exit"}, onClickAlert)
                                    backBtnDataConnectionOff = 1
                   end
          --      myText.text = "Network error!"
          	else
	          --	removeProcessData() -- write by alok and comment 20121016_2056
                      if myBothFlag then        --   write by alok 20121016_2056
                         bothRemoveProcessData()
                      else
                         removeProcessData()
                      end                     --  write by alok 20121016_2056
                       
                        if skipFlag == false then 
  					removeElement()
  					os.exit()
        		elseif skipFlag == true then
        			
        			if hitCount == 1 then 
        				hitCount = hitCount + 1
        				vservSkipAd()
        			elseif hitCount>1 then
        				removeElement()
        				os.exit()
        			end
        		end
          	--	removeElement()
        		--Method will Implement on client side 
       		--	 vservSkipAd()
          	end
        else                                                                      -- empty response  
          --print("network response " ,event.response)
            --print("")
           if event.response == "" then
           	if skipFlag == true then 
           --		print("network response ", skipFlag)
                      
            	vservSkipAd()
              --  removeProcessData() -- write By alok
                if myBothFlag then        --   write by alok 20121016_2056
                         bothRemoveProcessData()
                      else
                         removeProcessData()
                      end                     --  write by alok 20121016_2056
            	setSkipFlag(false)
            	if showAt == "end" then
            		setSkipFlag(true) 
            		os.exit()
            	end
            elseif skipFlag == false then
            	setSkipFlag(true) 
            	os.exit()	
            end	
           else 
               titleBar()
            --   native.showAlert( "Skip Ad check", "skip called" , { "ok" } , nil )
               skipAddButton()
               local fileName = "myFile.xml" --"myFile.json"
               writeToFile(event.response, fileName, system.DocumentsDirectory)
              -- appendFile(fileName, system.DocumentsDirectory)
              -- readFromFile("jsonFile.html", system.DocumentsDirectory)
              parseXmlString()
              
         --    local data = js.decode( jsonFile( fileName, system.DocumentsDirectory ) ) --system.ResourceDirectory))
           --  print ( "RESPONSE: " .. data.render[1].notify[1])
           --   print ( "RESPONSE: " .. data.render[1].data )
           --   local responseType = data.render[1].type					
           local responseType = getMediaType()
          -- native.showAlert( "Network Listener", responseType , { "ok" } , nil )
              if 1 == string.find( responseType, "image" ) then
             -- 	local imageUrl = {}
              		local imageUrl = getMediaImageURL()
              	--for i = 1, #imageUrl do 
              		--print("image render " .. "firstImg[" .. i .. "].png" )
              		if imageUrl == "" then
              			--print("find empty string ")
              			if viewMandatory == true then
              				if skipFlag == false then 
              					removeElement()
	                			vservSkipAd()
	                		elseif skipFlag == true then
	                		--print("exit button flag : " )
	                			removeElement()
	                			os.exit()
	                		end
	                	else	
	                		--native.showAlert( "Alert", "Image not found", { "Retry", "Exit" }, nil )
	                		removeElement()
	                		vservSkipAd()
	                	end	
                	else
                		--print("getting image data : " .. imageUrl)
                            --    native.showAlert( "imageUrl", imageUrl , { "ok" } , nil )
                 		imageObj = network.download(imageUrl, "GET", imageDowloadListener, "firstImg.png", system.TemporaryDirectory )
                	end
              elseif 1 == string.find( responseType, "text" ) then
--Text Display -- 
				--removeProcessData()
                               if myBothFlag then        --   write by alok 20121016_2056
                                    bothRemoveProcessData()
                                else
                                    removeProcessData()
                                end                     --  write by alok 20121016_2056
			--	local mediaText =	getMediaText() -- comment by alok 20121018_1946
 --- write code by Alok  20121018_1932   start here  
                                
                              -- local  mediaText
                              local myMediaString = getMediaText()
                              local mediaText  =  getMediaText()   
                            --  native.showAlert( "Network Listener", myMediaString , { "ok" } , nil )

                                mymediaTextlength =  string.len( myMediaString )
                                
                                if mymediaTextlength > 21 and mymediaTextlength < 42 then
                                          str1 = string.sub( myMediaString, 1, 21 ) 
                                          str2 = string.sub( myMediaString, 22, 42 )
                                          mediaText = str1.."\n"..str2
                                   --print("if called" ..mediaText)
                               elseif mymediaTextlength>42 and mymediaTextlength < 63 then
                                           str1 =  string.sub( myMediaString, 1, 21 ) 
                                           str2 =  string.sub( myMediaString, 22, 42 )
                                           str3 =  string.sub( myMediaString, 43, 63 ) 
                                           mediaText = str1.."\n"..str2.."\n"..str3
                                          
                                    --print(" first else if is called"..mediaText)
                                elseif mymediaTextlength >63 and mymediaTextlength<84 then
                                        str1 =      string.sub( myMediaString, 1, 21 ) 
                                        str2 =     string.sub( myMediaString, 22, 42 ) 
                                        str3 =     string.sub( myMediaString, 43, 63 ) 
                                        str4 =     string.sub( myMediaString, 64, 84 )
                                        mediaText = str1.."\n"..str2.."\n"..str3.."\n"..str4
                                    --print("second else if is called"..mediaText)
                                elseif mymediaTextlength >84 and mymediaTextlength <106 then
                                        str1 =  string.sub( myMediaString, 1, 21 ) 
                                        str2 =  string.sub( myMediaString, 22, 42 ) 
                                        str3 =  string.sub( myMediaString, 43, 63 ) 
                                        str4 =  string.sub( myMediaString, 64, 84 )
                                        str5 = string.sub( myMediaString, 85, mymediaTextlength )
                                        mediaText = str1.."\n"..str2.."\n"..str3.."\n"..str4.."\n"..str5
                                    --print("Third else if is called" ..mediaText)
                                else
                                    mediaText = myMediaString
                                    --print("else is called"..mediaText)
                                end
                                
 --- write code by Alok  20121018_1932   End here                               
                                
				if mediaText == "" then 
					--print("find empty string ")
					--print(viewMandatory)           
              		if viewMandatory == true then
                		if skipFlag == false then
                			--print("skip button empty: ") 
          					removeElement()
                			vservSkipAd()
                		elseif skipFlag == true then
                		--print("exit button flag : " )
                			removeElement()
                			os.exit()
                		end
                	else	
                		-- native.showAlert( "Alert", "Text not Found", { "Retry", "Exit" }, nil )
                		removeElement()
	                	vservSkipAd()
                	end	
                else
                	local  displaytxt = display.newText(mediaText, 0, 0, native.systemFontBold, 16 ) -- Create the text obejct
                	displaytxt.x = display.contentWidth * 0.5 -- Position it to centrescreen
                	displaytxt.y = titleText.height + 100 --display.contentHeight * 0.5 --20 
                	displaytxt:setTextColor( 100,79,232  )
-- Text Background -- 
              		local backGrd = display.newRect( 0, 0, displaytxt.width * 1.1, displaytxt.height * 1.1 ) -- Create a rectangle for background slightly larger than text
                	backGrd.x = displaytxt.x
                	backGrd.y = displaytxt.y
                	backGrd:setFillColor( 250,255,255)
                	backGrd:toBack() -- Send rectangle to the back of the display group so we can see the text
                      --  native.showAlert( "Display Media Txt", "Text", { "Ok" }, nil )
                	backGrd:addEventListener( "touch", touchEventListener) -- add listener with text
                        myBackBtnFlag = 1 -- write by alok 
                       if showAt == "start" then -- write by  alok
                            backBtnFlagS  = 1 
                            checkShowAdValueFlag = 1
                            --print("backBtnFlagS")
                       end 
                      if showAt == "both" and backBtnSetFlagForBoth == 1 then -- write by  alok
                            backBtnFlagB  = 1 
                            --checkShowAdValueFlag = 1
                            --print("backBtnFlagS")
                            backBtnSetFlagForBoth = 0
                      elseif showAt == "both" and backBtnSetFlagForBoth == 0 then
                          --  native.showAlert( "check backBtnalue on oth", "zero", { "ok" }, nil )
                            backBtnFlagB = 10
                      elseif showAt == "end" then
                            backBtnFlagE  = 5 -- for Exit the App              
                     end 
                          
                        --print("network listener = 734")
                end		
				local impressionUrl = getImpressionURL()
				if impressionUrl then
					--print("Impression Url Notify " , impressionUrl)
					network.request( impressionUrl, "GET", nil )
				else
					--print("do nothing on network side ")
				end
                --network.request( data.render[1].notify[1], "GET", nil )
            end
          end
      end
end
 
 local function getUserAgent()
        --[[ This is copied from the Android source frameworks/base/core/java/android/webkit/WebSettings.java.
        // It is somewhat of a hack since Android does not expose this to us but ad networks need it
        // for ad picking. ]]
                                                        
        local arg = ""
                                                        
        -- Add version
        local version = system.getInfo("platformVersion") --Build.VERSION.RELEASE;
        if version then
                        arg = arg .. version
        else
                        -- default to "1.0"
                arg = arg .. "1.0"
                version = "1.0"
        end
        arg = arg .. "; "
        
        -- Initialize the mobile user agent with the default locale.
        local language = system.getPreference( "locale", "language" )
        if  language ~= nil  then
        
                        arg = arg .. language:lower()
                        local country =  system.getPreference( "locale", "country" )
                        if country ~= nil then
                                        arg = arg .. "-" .. country:lower()
                        end
        else
                        -- default to "en"
                        arg = arg .. "en"
        end
        
        -- Add the device model name and Android build ID.
        model = system.getInfo("model")
        if model then
                arg = arg .. "; " .. model
        end
 
      --  local id = (require "UserID").getHashedID();
 
      --  if id then
                arg = arg .. " Build/" .. version
      --  end                                           
        local userAgent = "Mozilla/5.0 (Linux; U; Android " .. arg  ..  ") AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1"                                                               
        return userAgent 
    end
    
   local function getDeviceInfo()
        model = system.getInfo( "model" )
    --   print("model = ".. model)
        deviceId = system.getInfo( "deviceID" )
       --print("deviceID = ".. deviceId)
       local env = system.getInfo( "environment" )
      -- print("environment = ".. env)
        pName = system.getInfo( "platformName" )
     --  print("platformName = ".. pName)
       pVersion = system.getInfo( "platformVersion" )
     --  print("platformVersion = ".. pVersion)
        archInfo = system.getInfo( "architectureInfo" )
      -- print("architectureInfo = ".. archInfo)
         version = system.getInfo( "version" )
     --  print("version info = ".. version)
         build = system.getInfo( "build" )
     --  print("build info = ".. build)
   end
 
-- Access vserv Ad Http Post Request :
local function httpPostRequest()
    --local zoneId = "399"
    local userAgent = getUserAgent()
   -- print("userAgent =  " .. userAgent)
    getDeviceInfo()
     local sHeight = display.contentHeight
     local sWidth = display.contentWidth
   --  print("screen width".. sWidth,"screen height".. sHeight)
        if zoneID then
            postData = "zoneid=".. zoneID .. "&ua=" .. userAgent .."&tm=0&app=1&sw=" .. sWidth .. "&sh=" ..sHeight.. "&zf=1&ml=xml"
        else
         postData = "zoneid=5791&ua=" .. userAgent .."&tm=1&app=1&sw=" .. sWidth .. "&sh=" ..sHeight.. "&ml=xml"
        end
    local params = {}
    params.body = postData
    --print("post body = " ..params.body)
    local url = "http://a.vserv.mobi/delivery/adapi.php" --?zoneid=399&tm=1&app=1"
    checkRetryHit= checkRetryHit + 1
    --print( "checkRetryHit value is:", checkRetryHit )
    network.request( url, "POST", networkListener,params )
    touchValue = 0
end

-- http Get Request--

--local url = "http://a.vserv.mobi/delivery/adapi.php?zoneid=399&tm=1&app=1" --&ml=html"
--network.request( url, "GET", networkListener )

--httpPostRequest()


function writeToFile( data, filename, baseDirectory )
    local baseDirectory = baseDirectory or system.DocumentsDirectory
    local path = system.pathForFile( filename, baseDirectory )
    local file = io.open( path, "w")
    file:write( data )
    io.close( file )
    
end

function readFromFile( filename, baseDirectory )
    local baseDirectory = baseDirectory or system.ResourceDirectory
    local path = system.pathForFile( filename, baseDirectory )
    local file = io.open( path, "r" )
    for line in file:lines() do
      --  print(line)
      --print("")
        end
 io.close( file )
    --return data
end

function appendFile(filename, baseDirectory)
    local count = 0
     --local baseDirectory = baseDirectory or system.ResourceDirectory
    local appendString = '<script type="text/javascript" src="ormma.js"></script>';
    --local javascriptPlugin = '<object id = "corona" type = "application/x-osp-jsbridge" width = "0" height = "0hk"></object>';
    local path = system.pathForFile(filename, system.DocumentsDirectory)
   -- print ( path )
    local fh = io.open( path, "r");
--Appended File 
    local path1 = system.pathForFile( "jsonFile.html",  system.DocumentsDirectory )
    local newfile = io.open( path1, "w" )
    
    for line in fh:lines() do
       count = count + 1
        newfile:write( line )
        if (count == 1) then
            newfile:write( appendString )
          -- newfile:write( javascriptPlugin )
         --print(line)
        end
    end
    
    io.close( newfile )
    fh:close()
end

--[[local function webListener( event )
    if event.url then
        print( "You are visiting: " .. event.url )
    end
    if event.type then
        print( "The event.type is " .. event.type)  
        -- print the type of request
    end
 
    if event.errorCode then
        native.showAlert( "Error!", event.errorMessage, { "OK" } )
    end
end
 
--local webView = native.newWebView( 0, 0, 320, 480, webListener )
--webView:request( "javascriptHtml.html" )
 
--webView:addEventListener( "urlRequest", webListener )

-- remove the webView as with any other display object
webView:removeSelf()
webView = nil
]]--
-- WebPopUp is not supported on Simulator
--
--[[if isSimulator then
	msg = display.newText( "WebPopUp not supported on Simulator!", 0, 0, "Verdana-Bold", 14 )
	msg.x = display.contentWidth/2		-- center title
	msg.y = display.contentHeight/2		-- center title
	msg:setTextColor( 255,255,0 )
end]]--
    
function smsCall(number, message)
	if message then
		if number then
		    local options =
		    {
		    	to = number,
		        body = message
		    } 
		 --   print("to: " .. number .. "body: " ..message)
		    native.showPopup("sms", options)
	    else
	    	native.showAlert( "Alert", "Number is not found", { "OK" }, nil )
	    	
	    end
    else
	   native.showAlert( "Alert", "message is not found", { "OK" }, nil )
    end
  
  --  native.showPopup("sms", options)
end    

function jsonFile( filename, base )

    -- set default base dir if none specified
    if not base then base = system.ResourceDirectory; end

    -- create a file path for corona i/o
    local path = system.pathForFile( filename, base )

    -- will hold contents of file
    local contents

    -- io.open opens a file at path. returns nil if no file found
    local file = io.open( path, "r" )
    if file then
    -- read all contents of file into a string
    contents = file:read( "*a" )
    io.close( file )	-- close the file after using it
    end

    return contents
end


function vservLibInitCall( ) --params )
   -- native.setActivityIndicator( true )
    --initialize( params )
    httpPostRequest()
  
  if myBothFlag then 
    myBothFlag = false
    processData()
else
        myBothFlag = true
	bothProcessData()
   end
end

   

--[[function vservLibExitCall( params )
	setSkipLabel(2)
	initialize(params)
    httpPostRequest()
end
]]--
function vservSkipAd() 
     
end

--local function onKeyEvent( event )
--    local keyname = event.keyName;
--    if event.keyName=="back"  then
--          --  if keyname == "menu" then
--            	--goToMenuScreen()
--                native.showAlert( "check back1 Button", "success" , { "Ok" }, nil )
--           -- if keyname == "back" then
--            	--goBack();
--             --   storyboard.getPrevious( )
--            --elseif keyname == "search" then
--            	--performSearch();
--          --  end
--	end
--    return true;
--end
--local function callOtherEvent( event )
--    if myBackBtnFlag  == 2 then
--            native.cancelWebPopup( )
--        elseif myBackBtnFlag  == 3 then
--            print("smsComposerScreen close" )
--        elseif myBackBtnFlag  == 4 then
--               native.showAlert( "sh", "call" , { "ok" } , nil )
--               removeElement()
--               httpPostRequest()
--               bothProcessData()
--               myBackBtnFlag = 5
--        elseif myBackBtnFlag  == 5 then
--            os.exit()
--        end
--    end
 
 function handleExitAd(var)
     backBtnFlagE = 1
     --print("handle Exit Ad" ..var)
 end    
 
 
local function onKeyEvent( event )
    --local keyname = event.keyName;
   -- if event.keyName=="back"  then
        
        if event.keyName=="back" and checkShowAdValueFlag == 1 and  backBtnFlagS  == 1 then
            
            removeElement()
            vservSkipAd()
            
            --native.showAlert( "showClient", "VservSkip Function called" , { "ok" } , nil )
              backBtnFlagS = 9
            
        elseif event.keyName=="back" and checkShowAdValueFlag == 1 and  backBtnFlagS == 2 then
               native.cancelWebPopup()
               backBtnFlagS = 1
        
        
        elseif event.keyName=="back" and checkShowAdValueFlag == 1 and backBtnFlagS == 9 then
            --native.showAlert( "keyEvent", "onKeyEvent Called 5" , { "ok" }, nil ) 
            backBtnFlagS = 5
            --os.exit()
       elseif event.keyName=="back" and checkShowAdValueFlag == 1 and backBtnFlagS == 5 then
                os.exit()
        
        
       elseif event.keyName=="back" and backBtnFlagE == 1 then 
               removeElement( )
             -- hitCount =hitCount + 1
               httpPostRequest()
                           
                if myBothFlag then 
                    myBothFlag = false
                    processData()
                else
                    myBothFlag = true
                    bothProcessData()
       end
                backBtnFlagE = 9
       elseif event.keyName=="back" and backBtnFlagE ==9 then
                backBtnFlagE = 5;
                
       elseif event.keyName=="back" and backBtnFlagE ==3 then
                native.cancelWebPopup()
                backBtnFlagE = 9
       elseif event.keyName=="back" and backBtnFlagE ==5 then
               -- native.showAlert( "backutton exit app", "app exit" , { "ok" }, nil )
                os.exit()
            
--       elseif event.keyName=="back" and backBtnFlagB == 1 then
--            --  native.showAlert( "backBtnFlagB", "backBtnFlagB called", { "Ok" } , nil )
--               backBtnFlagB = 9
--               removeElement()
--               vservSkipAd()
--               
--       elseif event.keyName=="back" and backBtnFlagB == 9 then
--               backBtnFlagB = 5
--               bFlag = true
--       elseif event.keyName=="back" and backBtnFlagB == 5 then
--               if bFlag then
--                bFlag = false
--                removeElement()
--                -- hitCount =hitCount + 1
--                httpPostRequest()
--             --   native.showAlert( "backBtnFlagB", "backBtnFlagB called", { "Ok" } , nil )
--                 
--               end
--                if myBothFlag then 
--                    myBothFlag = false
--                    processData()
--                else
--                    myBothFlag = true
--                    bothProcessData()
--                end
--               backBtnFlagB = 10
--       elseif event.keyName=="back" and backBtnFlagB == 6 then              
--              native.cancelWebPopup() 
--              backBtnFlagB = 7
--       elseif event.keyName=="back" and backBtnFlagB == 10 then              
--           -- native.showAlert( "bck button on exit app1", "exit called", { "ok" } , nil )
--            backBtnFlagB = 7
--       elseif event.keyName=="back" and backBtnFlagB == 7 then              
--       --   native.showAlert( "bck button on exit app", "exit called", { "ok" } , nil )
--          os.exit( )

--  New Code Start Here for showAd = both
--
--    elseif event.keyName=="back" and backBtnFlagB == 1 then   
--        adCountValue = 1
--        removeElement()
--        vservSkipAd()
--        backBtnFlagB = 11 -- dummy
--    elseif event.keyName=="back" and backBtnFlagB == 11 then
--        backBtnFlagB = 2
--        bFlag = true
--    elseif event.keyName=="back" and backBtnFlagB == 2 then   
--        if bFlag then
--                bFlag = false
--                removeElement()
--                -- hitCount =hitCount + 1
--                httpPostRequest()
--             --   native.showAlert( "backBtnFlagB", "backBtnFlagB called", { "Ok" } , nil )
--                 
--               end
--                if myBothFlag then 
--                    myBothFlag = false
--                    processData()
--                else
--                    myBothFlag = true
--                    bothProcessData()
--                end
--                backBtnFlagB =3
--                
--     elseif event.keyName=="back" and backBtnFlagB == 3 then   
--                   
--                   backBtnFlagB = 4
----                   native.showAlert( "back button", tostring (backBtnFlagB), { "ok" }, nil ) 
--     elseif event.keyName=="back" and backBtnFlagB == 4 then  
--               --native.showAlert( "back button11", tostring (backBtnFlagB), { "ok" }, nil )
--                os.exit()
--     elseif event.keyName=="back" and backBtnFlagB == 5 then
--                      native.cancelWebPopup( )
--                      backBtnFlagB = 12 -- dummy
--     elseif event.keyName=="back" and backBtnFlagB == 12 then           
--         if  adCountValue== 0 then
--		backBtnFlagB = 1
--	else
--		backBtnFlagB = 11            
--        end
--            
--    elseif event.keyName=="back" and backBtnFlagB == 13 then           
--            native.cancelWebPopup( )
--            backBtnFlagB = 14
--    elseif event.keyName=="back" and backBtnFlagB == 14 then           
--                  bacBtnFlagB = 4
                  
   elseif event.keyName =="back" and backBtnDataConnectionOff == 1 then   -- if data connection not avaliable in device
                 --native.showAlert("check connection close on ","press back burtton key",{"Ok"},nil)
                 os.exit()
                  
-- End New Code End Here for showAd = both

end
--    if event.keyName=="back" and backBtnFlagB == 4 then
	if backBtnForSkipAd == 2 then
	hitCount = hitCount + 1;
			removeElement()
            vservSkipAd()
            backBtnForSkipAd = 5; -- dummy test for client
            --native.showAlert( "back button11", tostring (backBtnFlagB), { "ok" } , nil )
            --backBtnForSkipAd = 2
        elseif backBtnFlagB == 10 then
        --native.showAlert( "back button11", tostring (backBtnFlagB), { "ok" } , nil )
        removeElement()
        os.exit()
		elseif backBtnForSkipAd == 1 then
 				native.cancelWebPopup()
                --native.showAlert( "back button11", tostring (backBtnFlagB), { "ok" }, nil )
                if showAt == "start" then
                	backBtnForSkipAd = 2;
                elseif showAt == "end" then
                	backBtnForSkipAd = 4
                elseif showAt == "both" then
                	if hitCount == 1 then
                		backBtnForSkipAd = 2;
                	elseif hitCount > 1 then
                		backBtnForSkipAd = 4
                	end 
                end		  
--                 os.exit()
		elseif backBtnForSkipAd == 5 then 
			backBtnForSkipAd = 3
 		elseif backBtnForSkipAd == 3 then
			removeElement( )
               httpPostRequest()
                           
                if myBothFlag then 
                    myBothFlag = false
                    processData()
                else
                    myBothFlag = true
                    bothProcessData()
                end
          elseif backBtnForSkipAd == 4 then
          	   removeElement()   
			--native.showAlert( "back button11", tostring (backBtnFlagB), { "ok" }, nil )
			os.exit()
        end

               -- native.showAlert( "back button on Both only", tostring (backBtnFlagB), { "ok" }, nil )
               -- native.showAlert( "back button on End only", tostring (backBtnFlagE), { "ok" }, nil )
               -- native.showAlert( "back button on Start only", tostring (backBtnFlagS), { "ok" }, nil )
                --native.cancelWebPopup()
    
        return true
end


 --add the runtime event listener
if system.getInfo( "platformName" ) == "Android" then  
    Runtime:addEventListener( "key", onKeyEvent )
end
