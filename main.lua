local nativeSockets = require "plugin.nativeSockets"
nativeSockets.init(function ( e )
    print(json.encode(e))
end)
local json = require "json"
local widget= require "widget"

local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
bg:setFillColor( 0,0,.5 )
local title = display.newText( "Native Sockets Plugin", display.contentCenterX, 40, native.systemFontBold, 20 )
local testSocket
local openSocketText = display.newText( "Open socket and send data", display.contentCenterX, display.contentCenterY, native.systemFont, 17 )

local function openAndSendData()
    openSocketText.alpha = .5
    timer.performWithDelay(500, function()
        openSocketText.alpha = 1
        nativeSockets.disconnect(testSocket)
    end )
    testSocket = nativeSockets.connect("wss://echo.websocket.org", function(e)
        print(json.encode(e))
    end)
    
end

openSocketText:addEventListener("tap", openAndSendData)
local function onKeyEvent( event )
    
    if event.phase =="up" and event.keyName =="buttonA" then
        openAndSendData()
    end
    
end

Runtime:addEventListener( "key", onKeyEvent )
