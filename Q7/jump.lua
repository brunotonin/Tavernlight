jumpWindow = nil
jumpButton = nil
moveEvent = nil

function moveButton()
    local width = jumpWindow:getWidth()
    local margin = jumpButton:getMarginRight()
    if margin >= width - 100 then
        moveButtonToRandomLine(jumpButton)
    else
        jumpButton:setMarginRight(margin + 10)
    end
end

function moveButtonToRandomLine()
    local height = jumpWindow:getHeight()
    local y =  math.random(50, height - 100)
    jumpButton:setMarginRight(0)
    jumpButton:setMarginTop(y)
end

function init()
    print("Jump module loaded")
    jumpWindow = g_ui.displayUI('jump')
    jumpWindow:setVisible(true)
    jumpButton = jumpWindow:getChildById('jumpButton')

    moveButtonToRandomLine()

    -- Create a cycle event to move the button
    moveEvent = cycleEvent(function()
        moveButton()
    end, 100)

    -- Set the button to move to a random line when clicked
    jumpButton.onClick = function()
        moveButtonToRandomLine(jumpButton)
    end
end

function terminate()
    -- Destroy the window and cancel the event if it exists
    if moveEvent then
        moveEvent:cancel()
        moveEvent = nil
    end
    jumpWindow:destroy()
end
