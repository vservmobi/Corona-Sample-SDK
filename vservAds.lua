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
 end 
 
function initialize( params )
    if params.zoneID then
        zoneID = params.zoneID
    end
    if params.showAt then 
        showAt = params.showAt
    end
    if params.adTitle then 
        adTitle = params.adTitle
        else
        	adTitle = "Advertisement"
    end
    if params.skipLabel then
        skipLabel = params.skipLabel
        else
        skipLabel = "Skip Ad"
    end
    if params.exitLabel then
        exitLabel = params.exitLabel
        else
        exitLabel = "Exit"
    end
    if params.viewMandatory then
    	viewMandatory = params.viewMandatory
    end
end


    local onButtonEvent = function (event )
        if event.phase == "release" then
        end
    end
    
  local function processData()
	processData = display.newText("Fetching Data ...", 0, 0, native.systemFontBold, 20 )
	processData.x = display.contentCenterX
    processData.y = display.contentHeight * 0.5 -- 120
end  

-- bothProcessData() and bothRemoveProcessData()  function start Here

local function bothProcessData() --  this function only working on  showAd = "both"
    bothProcessData =  display.newText( "Fetching Data...", 0, 0, native.systemFontBold, 20 )
    bothProcessData.x =  display.contentCenterX
    bothProcessData.y  =  display.contentHeight * 0.5 --120
end

local function bothRemoveProcessData() --  This function onl working on showd = "both"
	if bothProcessData then
		display.remove(bothProcessData)
		bothProcessData = nil
	end	
end



-- bothProcessData() function end Here

local function removeProcessData()
	if processData then
		display.remove(processData)
		processData = nil
	end	
end
  
  
  local function removeElement()
      -- native.cancelWebPopup()
       local screenObj = display.getCurrentStage()
       local i = screenObj.numChildren --1 
       local countObj = display.getCurrentStage().numChildren
    
        while i >= 1 do 
            screenObj:remove(i)
            i = i-1
        end 
  end
  
    local function skipAdEvent( event )
        setSkipFlag(false)
        removeElement()

   --if myWebPopup == "true" then
        --local  webpopupflag = native.cancelWebPopup()
    --end
  
   if showAt == "start" then
       backBtnFlagS = 5 
       checkShowAdValueFlag = 1
      end 
    --Method will Implement on client side 
    	backBtnForSkipAd = 6
    	hitCount = hitCount + 1;
    	removeElement()
        vservSkipAd()
    end
    
    local function exitAdEvent ( event )
 		removeElement()
        os.exit()
    end
    
    local function onComplete (event)
    end
    
    
    
   
   
   -- Show Ad Title -- 
    local function titleBar() 
        --Screen Title Start
            titleText = display.newText( adTitle, 0, 0, native.systemFontBold, 16 ) -- Create the text obejct
            titleText.x = 55 -- Position it to centrescreen
            titleText.y = 12 
            titleText:setTextColor( 255,255,255 )
    	--screen title end
    end
    local function skipAddButton() 
    --Skip Ad Button Start
    local  skipAdBtn   
    		if showAt == "start" then
    			if skipLabel then
            	skipAdBtn = display.newText(">> " ..skipLabel, 0, 0, native.systemFontBold, 16 ) -- Create the text obejct
            	else
            	skipAdBtn = display.newText(">> Skip Ad", 0,0, native.systemFontBold, 16 )
            	end
            	backBtnForSkipAd = 2
            elseif showAt == "end" then
            	if exitLabel then
            	exitAdBtn = display.newText(">> " ..exitLabel, 0, 0, native.systemFontBold, 16 ) -- Create the text obejct
            	else
            	exitAdBtn = display.newText(">> Exit", 0, 0, native.systemFontBold, 16 )
            	end
            	backBtnForSkipAd = 4
            elseif showAt == "both" then 
        		if skipFlag then   
            		if skipLabel then
            			if hitCount == 1 then
	            			skipAdBtn = display.newText(">> " ..skipLabel, 0, 0, native.systemFontBold, 16 ) -- Create the text obejct
	            			backBtnForSkipAd = 2
	            		elseif hitCount > 1 then 
	            			if exitLabel then
	            				exitAdBtn = display.newText(">> " ..exitLabel, 0, 0, native.systemFontBold, 16 )
	            			else
	            				exitAdBtn = display.newText(">> Exit Ad", 0, 0, native.systemFontBold, 16 )
	            			end
	            			backBtnForSkipAd = 4
	            		end
	            	else 
	            	skipAdBtn = display.newText(">> Skip Ad", 0, 0, native.systemFontBold, 16 )
	            	backBtnForSkipAd = 2
	            	end
	            	setSkipFlag(false)
            	else
            		if exitLabel then
						if hitCount >=1 then
	            			exitAdBtn = display.newText(">> " ..exitLabel, 0, 0, native.systemFontBold, 16 ) -- Create the text obejct
	            		end
	            	else
	            	exitAdBtn = display.newText(">> Exit", 0, 0, native.systemFontBold, 16 )
	            	end
	            	backBtnForSkipAd = 4
	            	setSkipFlag(true)
            	end	
            else
            	if skipLabel then
            	skipAdBtn = display.newText(">> " ..skipLabel, 0, 0, native.systemFontBold, 16 ) -- Create the text obejct
            	else
            	skipAdBtn = display.newText(">> Skip Ad", 0, 0, native.systemFontBold, 16 )
            	end
            	backBtnForSkipAd = 2
            end
            if skipAdBtn then
            skipAdBtn.x = display.contentWidth - 40 -- Position it to centrescreen
            skipAdBtn.y = 12 
            skipAdBtn:setTextColor(163,209,101)
    --Skip Ad Button End
    	skipAdBtn:addEventListener( "touch", skipAdEvent)
    	elseif exitAdBtn then
            exitAdBtn.x = display.contentWidth - 40 -- Position it to centrescreen
            exitAdBtn.y = 12 
            exitAdBtn:setTextColor(163,209,101)
    --Exit Ad Button End
    	exitAdBtn:addEventListener( "touch", exitAdEvent)
        myBackBtnFlag = 5
        
    	end
    end
            
local function parseMediaNode(xmlData) 
 	if string.find(xmlData, "<media") then
		local mediaString =  string.sub(xmlData, string.find(xmlData, "<media"), string.find(xmlData, "</media>"))
		 if string.find(mediaString, "type") then
			local typeString = string.sub(mediaString, string.find(mediaString, "type=\""), string.find(mediaString, "\" ")-1)
			mediaType = string.sub(typeString, string.find(typeString, "\"")+1)		
		end
		 if 1 == string.find(mediaType, "text") then 
		 	local testString = string.sub(mediaString, string.find(mediaString, "<text>"), string.find(mediaString, "</text>")-1)
		 	mediaText = string.sub(testString,string.find(testString, ">")+1)
	 	elseif 1 == string.find ( mediaType , "image" ) then 
		 	local mediaImageString = mediaString
			 	local imageString = string.sub(mediaImageString, string.find(mediaImageString, "<url>"), string.find(mediaImageString, "</url>")-1)
			 	mediaImageUrl = string.sub(imageString,string.find(imageString, ">")+1)
		end
		
	end
 end
 
 local function parseActionsNode (xmlDataString)
	if string.find(xmlDataString, "<action") then
		local action =  string.sub(xmlDataString, string.find(xmlDataString, "<action "), string.find(xmlDataString, "</action>")-1)
		if string.find(action, "type") then
			local actionTypeString = string.sub(action, string.find(action, "type=\""), string.find(action, "\">")-1)
 			actionType = string.sub(actionTypeString, string.find(actionTypeString, "=")+2)	
		end
		if string.find(action, "<label>") then
			local labelString = string.sub(action, string.find(action, "<label>"), string.find(action, "</label>")-1)
			actionLabel = string.sub(labelString, string.find(labelString, ">")+1)
		end
		if string.find(action, "<url>")then
			local actionUrlString = string.sub(action, string.find(action, "<url>"), string.find(action, "</url>")-1)
			actionUrl = string.sub(actionUrlString, string.find(actionUrlString, ">")+1)
		end
		if string.find(action, "<data>")then
			local dataString = string.sub(action, string.find(action, "<data>"), string.find(action, "</data>")-1)
			actionData = string.sub(dataString, string.find(dataString, ">")+1)
		end
		if string.find(action, "<number>")then
			local numberString = string.sub(action, string.find(action, "<number>"), string.find(action, "</number>")-1)
			actionNumber = string.sub(numberString, string.find(numberString, ">")+1)
		end
		if string.find(action, "<trackers>") then
			local trackersString = string.sub(action, string.find(action, "<trackers>"), string.find(action, "</trackers>")-1)
			local trackerUrlStr = string.sub(trackersString, string.find(trackersString, "<url>"), string.find(trackersString, "</url>")-1)
			actionTrackUrl= string.sub(trackerUrlStr, string.find(trackerUrlStr, ">")+1)
		end
	end
 end
 
 local function parseImpressionString(xmlDataString) 
 	if string.find(xmlDataString, "<impressions>") then
		local impressions =  string.sub(xmlDataString, string.find(xmlDataString, "<impression "), string.find(xmlDataString, "</impression>")-1)
		impressionUrl = string.sub(impressions, string.find(impressions, ">")+1)
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
 	if mediaImageUrl then
 		return mediaImageUrl
 	end
 	return mediaImageUrl	
 end
 
 local function getMediaText()
        if mediaText then
 		return mediaText
 	end
 	return mediaText 
 end
 
 local function getImpressionURL()
 	if impressionUrl then
 		return impressionUrl
 	end
 	return impressionUrl
 end
     
local function parseXmlString()
	local xmlDataString = jsonFile("myFile.xml", system.DocumentsDirectory )
	parseMediaNode(xmlDataString)
	parseImpressionString(xmlDataString)
	parseActionsNode(xmlDataString)
	return xmlDataString
end

local function clickEventListener (event)
end

 local function onClickAlert( event )
        if "clicked" == event.action then
                local i = event.index
                if 1 == i then
                	os.exit()
                elseif 2 == i then
                   	os.exit()
                end
        end
end

 local function touchEventListener(event) 
      myWebPopup = "true"; 
      touchCount = touchCount+1;
       local id = event.target
         
        if event.phase == "began" then
 			id:setFillColor(200,255,255)
		elseif event.phase == "ended" then
			id:setFillColor(255,255,255)                                       
        end
	if  event.phase == "ended" then
		if 1 == string.find ( getActionType() , "sms" ) then 
	            smsCall(getActionNumber(), getActionData())
	            myBackBtnFlag  = 3
	        if showAt == "start" then 
	           backBtnFlagS  = 1
	           checkShowAdValueFlag = 1 
	        end 

 		elseif 1 == string.find ( getActionType() , "url" ) then
	        local options = { hasBackground=true, baseUrl=system.DocumentsDirectory, urlRequest=listener }
	        system.openURL(getActionUrl())
	        --native.showWebPopup(0, titleText.height+10, display.contentWidth, display.contentHeight, getActionUrl(), options )
	        myBackBtnFlag  = 2 
	        backBtnForSkipAd = 1;
	        if showAt == "start" then
	           backBtnFlagS  = 2 
	           checkShowAdValueFlag = 1 
	       	end  
	       	if showAt == "end" then
	           backBtnFlagE  = 3 
	           checkShowAdValueFlag = 1 
	       	end 
	     
		      if adCountValue == 0 then
		          backBtnFlagB = 5
		      else
		          backBtnFlagB = 13 -- dummy value
		      end
	      end
  end

--- Tracker  coding start here 

local trackUrl = getTrackUrl()
           if trackUrl and touchValue == 0 then
               touchValue = 1
           		network.request( trackUrl, "GET", nil )
           else
           
           end  
end
--- Tracker Coding End Here
--

 local function imageDowloadListener (event) 
        if(event.isError ) then
        	--native.showAlert( "Alert", "Please Check your Network Connection"  , {"Ok"}, onClickAlert )
       else
          if myBothFlag then
                bothRemoveProcessData()
           else
        	removeProcessData()
           end          

                local myImage = display.newImage( "firstImg.png", system.TemporaryDirectory, 0, titleText.height + 80, true)
                myImage:addEventListener( "touch", touchEventListener )
                
                myBackBtnFlag  = 1 
                if showAt == "start" then 
                    backBtnFlagS  = 1 
                    checkShowAdValueFlag = 1
                 end
                if showAt == "both" and backBtnSetFlagForBoth == 1 then
                    backBtnFlagB  = 1 
                    backBtnSetFlagForBoth = 0
                elseif showAt == "both" and backBtnSetFlagForBoth == 0 then

                    backBtnFlagB = 10
                elseif showAt == "end" then
                    backBtnFlagE  = 5 -- for Exit the App 
                end 

           local impressionUrl = getImpressionURL()
           if impressionUrl then
           		network.request( impressionUrl, "GET", nil )
           else
           end
       end
   end    
    
   
--  Code start here  for check  dataconnection
   
 local function checkDataConnection()
	 if viewMandatory == "true" then 
		 if http.request( "http://www.vserv.mobi" ) == nil then
		      dataconnectionFlag = true
		      backBtnDataConnectionOff = 1
		
		 else    
		       dataconnectionFlag = false
		end
	end
end
-- New Code End here for check dataconnection  20121025_1859
    
local function networkListener( event )
        if ( event.isError ) then
            checkDataConnection() --check network connection            
        	if viewMandatory == "true" and dataconnectionFlag then 
                   if showAt == "end" then
                       os.exit()
                       backBtnDataConnectionOff = 1
                   else
                       native.showAlert( "Alert", "Data Connection is not avaliable"  , {"Exit"}, onClickAlert)
                        backBtnDataConnectionOff = 1
                   end
          	else
              if myBothFlag then      
                 bothRemoveProcessData()
              else
                 removeProcessData()
              end                     
                if skipFlag == false then 
  					removeElement()
  					os.exit()
        		elseif skipFlag == true then
        			if hitCount == 1 then 
        				hitCount = hitCount + 1
        				removeElement()
        				vservSkipAd()
        			elseif hitCount>1 then
        				removeElement()
        				os.exit()
        			end
        		end
          	end
        else                                                                      -- empty response  
           if event.response == "" then
           	if skipFlag == true then 
           		removeElement()
            	vservSkipAd()
                if myBothFlag then  
                         bothRemoveProcessData()
                      else
                         removeProcessData()
                      end      
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
               --titleBar()
               skipAddButton()
               local fileName = "myFile.xml" 
               writeToFile(event.response, fileName, system.DocumentsDirectory)
              parseXmlString()
              
           local responseType = getMediaType()
              if 1 == string.find( responseType, "image" ) then
              		local imageUrl = getMediaImageURL()
              		if imageUrl == "" then
              			if viewMandatory == true then
              				if skipFlag == false then 
              					removeElement()
	                			vservSkipAd()
	                		elseif skipFlag == true then
	                			removeElement()
	                			os.exit()
	                		end
	                	else	
	                		removeElement()
	                		vservSkipAd()
	                	end	
                	else
                 		imageObj = network.download(imageUrl, "GET", imageDowloadListener, "firstImg.png", system.TemporaryDirectory )
                	end
              elseif 1 == string.find( responseType, "text" ) then
                   if myBothFlag then     
                        bothRemoveProcessData()
                    else
                        removeProcessData()
                    end                     
                  local myMediaString = getMediaText()
                  local mediaText  =  getMediaText()   
               
                    local mymediaTextlength =  string.len( myMediaString )
                    
                    if mymediaTextlength > 21 and mymediaTextlength < 42 then
                             local str1 = string.sub( myMediaString, 1, 21 ) 
                              local str2 = string.sub( myMediaString, 22, 42 )
                              mediaText = str1.."\n"..str2
                   elseif mymediaTextlength>42 and mymediaTextlength < 63 then
                               local str1 =  string.sub( myMediaString, 1, 21 ) 
                               local str2 =  string.sub( myMediaString, 22, 42 )
                               local str3 =  string.sub( myMediaString, 43, 63 ) 
                               mediaText = str1.."\n"..str2.."\n"..str3
                    elseif mymediaTextlength >63 and mymediaTextlength<84 then
                            local str1 =      string.sub( myMediaString, 1, 21 ) 
                            local str2 =     string.sub( myMediaString, 22, 42 ) 
                            local str3 =     string.sub( myMediaString, 43, 63 ) 
                            local str4 =     string.sub( myMediaString, 64, 84 )
                            mediaText = str1.."\n"..str2.."\n"..str3.."\n"..str4
                    elseif mymediaTextlength >84 and mymediaTextlength <106 then
                            local str1 =  string.sub( myMediaString, 1, 21 ) 
                            local str2 =  string.sub( myMediaString, 22, 42 ) 
                            local str3 =  string.sub( myMediaString, 43, 63 ) 
                            local str4 =  string.sub( myMediaString, 64, 84 )
                            local str5 = string.sub( myMediaString, 85, mymediaTextlength )
                            mediaText = str1.."\n"..str2.."\n"..str3.."\n"..str4.."\n"..str5
                    else
                        mediaText = myMediaString
                    end
                                
                            
				if mediaText == "" then           
              		if viewMandatory == true then
                		if skipFlag == false then
          					removeElement()
                			vservSkipAd()
                		elseif skipFlag == true then
                			removeElement()
                			os.exit()
                		end
                	else	
                		removeElement()
	                	vservSkipAd()
                	end	
                else
                	local  displaytxt = display.newText(mediaText, 0, 0, native.systemFontBold, 16 ) -- Create the text obejct
                	displaytxt.x = display.contentWidth * 0.5 -- Position it to centrescreen
                	displaytxt.y = titleText.height + 100 
                	displaytxt:setTextColor( 100,79,232  )
-- Text Background -- 
              		local backGrd = display.newRect( 0, 0, displaytxt.width * 1.1, displaytxt.height * 1.1 ) -- Create a rectangle for background slightly larger than text
                	backGrd.x = displaytxt.x
                	backGrd.y = displaytxt.y
                	backGrd:setFillColor( 250,255,255)
                	backGrd:toBack() -- Send rectangle to the back of the display group so we can see the text
      
                	backGrd:addEventListener( "touch", touchEventListener) -- add listener with text
                end		
				local impressionUrl = getImpressionURL()
				if impressionUrl then
					network.request( impressionUrl, "GET", nil )
				else
				end
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
 
      --  if id then
                arg = arg .. " Build/" .. version
      --  end                                           
       local userAgent = "Mozilla/5.0 (Linux; U; Android " .. arg  ..  ")"--AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1"                                                               
        return userAgent 
    end
    
   local function getDeviceInfo()
        model = system.getInfo( "model" )
        deviceId = system.getInfo( "deviceID" )
       local env = system.getInfo( "environment" )
        pName = system.getInfo( "platformName" )
       pVersion = system.getInfo( "platformVersion" )
        archInfo = system.getInfo( "architectureInfo" )
         version = system.getInfo( "version" )
         build = system.getInfo( "build" )
   end
 
-- Access vserv Ad Http Post Request :
local function httpPostRequest()
    local userAgent = getUserAgent()
    getDeviceInfo()
     local sHeight = display.contentHeight
     local sWidth = display.contentWidth
    if zoneID then
    	postData = "zoneid=".. zoneID .. "&app=1&sw=" .. sWidth .. "&sh=" ..sHeight.. "&cca=0&vr=c0.1.0&zf=1&ml=xml"
    end
    local params = {}
    params.body = postData
    local url = "http://a.vserv.mobi/delivery/adapi.php" 
    checkRetryHit= checkRetryHit + 1
    network.request( url, "POST", networkListener,params )
    touchValue = 0
end

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
        end
 io.close( file )
    --return data
end

function appendFile(filename, baseDirectory)
    local count = 0
    local appendString = '<script type="text/javascript" src="ormma.js"></script>';
    local path = system.pathForFile(filename, system.DocumentsDirectory)
    local fh = io.open( path, "r");
--Appended File 
    local path1 = system.pathForFile( "jsonFile.html",  system.DocumentsDirectory )
    local newfile = io.open( path1, "w" )
    
    for line in fh:lines() do
       count = count + 1
        newfile:write( line )
        if (count == 1) then
            newfile:write( appendString )
         --print(line)
        end
    end
    
    io.close( newfile )
    fh:close()
end

function smsCall(number, message)
	if message then
		if number then
		    local options =
		    {
		    	to = number,
		        body = message
		    } 
		    native.showPopup("sms", options)
	    else
	    	native.showAlert( "Alert", "Number is not found", { "OK" }, nil )
	    	
	    end
    else
	   native.showAlert( "Alert", "message is not found", { "OK" }, nil )
    end
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


function vservLibInitCall()
	titleBar() 
    httpPostRequest()
  
  if myBothFlag then 
    myBothFlag = false
    processData()
  else
    myBothFlag = true
	bothProcessData()
   end
end

function vservSkipAd() 
     
end

 function handleExitAd(var)
     backBtnFlagE = 1
 end    
 
 
 local function onKeyEvent( event )
 	 if event.keyName=="back" and checkShowAdValueFlag == 1 and  backBtnFlagS  == 1 then
            removeElement()
            vservSkipAd()
            backBtnFlagS = 9
        elseif event.keyName=="back" and checkShowAdValueFlag == 1 and  backBtnFlagS == 2 then
               native.cancelWebPopup()
               backBtnFlagS = 1
        elseif event.keyName=="back" and checkShowAdValueFlag == 1 and backBtnFlagS == 9 then
            backBtnFlagS = 5
       elseif event.keyName=="back" and checkShowAdValueFlag == 1 and backBtnFlagS == 5 then
            os.exit()
       elseif event.keyName=="back" and backBtnFlagE == 1 then 
           removeElement()
           
           titleBar()
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
             os.exit()
   	   elseif event.keyName =="back" and backBtnDataConnectionOff == 1 then   -- if data connection not avaliable in device
             os.exit()
end

	if event.keyName=="back" and backBtnForSkipAd == 2 then
		hitCount = hitCount + 1;
			removeElement()
            vservSkipAd()
            backBtnForSkipAd = 5; -- dummy test for client
    elseif event.keyName=="back" and backBtnFlagB == 10 then
    removeElement()
    os.exit()
	elseif event.keyName=="back" and backBtnForSkipAd == 1 then
 		native.cancelWebPopup()
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
      elseif event.keyName=="back" and backBtnForSkipAd == 4 then
      	   removeElement()   
			os.exit()
    end

      return true
 end


 --add the runtime event listener
if system.getInfo( "platformName" ) == "Android" then  
    Runtime:addEventListener("key", onKeyEvent)
end
