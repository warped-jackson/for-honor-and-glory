title = {}

function newButton(text, fn)
    return {
        text = text,
        fn = fn,
        now = false,
        last = false
    }
end

local buttons = {}

table.insert(buttons, newButton(
    "Start Game",
    function()
        startFresh(1)

        if data.map and string.len(data.map) > 0 then
            curtain:call(data.map, data.playerX, data.playerY, "fade")
        end
    end)
)

table.insert(buttons, newButton(
    "About Game",
    function()
        gamestate = 1
        about:draw()
    end)
)

table.insert(buttons, newButton(
    "How to Play",
    function()
        gamestate = 2
        controls:draw()
    end)
)

table.insert(buttons, newButton(
    "Quit",
    function()
        love.event.quit()
    end)
)

function title:draw()
    local window_width = love.graphics.getWidth()
    local window_height = love.graphics.getHeight()
    local button_width = window_width * (1/3)
    local button_height = window_height * (1/9)
    local button_margin = 3 * scale
    local cursor_y = 30 * scale
    local total_height = (button_height + button_margin) * #buttons

    if gamestate == 0 then

        background_scale = window_height / sprites.startScreenBackground:getHeight()
        background_width = sprites.startScreenBackground:getWidth() * background_scale
        background_height = sprites.startScreenBackground:getHeight() * background_scale

        love.graphics.draw(sprites.startScreenBackground,
                           (window_width - background_width) * 0.5,
                           (window_height - background_height) * 0.5,
                           nil,
                           background_scale,
                           background_scale)

        local color = {128/255, 0/255, 0/255, 196/255}
        love.graphics.setColor(unpack(color))
        love.graphics.rectangle(
            "fill",
            (window_width - background_width) * 0.5,
            (window_height - background_height) * 0.5,
            background_width,
            background_height * 0.22
        )

        local color = {184/255, 134/255, 11/255, 255/255}
        love.graphics.setColor(unpack(color))
        love.graphics.setFont(fonts.title)
        love.graphics.printf("For Honor and Glory", love.graphics.getWidth()/2 - 4000, 3 * scale, 8000, "center")

        local color = {0/255, 0/255, 0/255, 255/255}
        love.graphics.setColor(unpack(color))

        love.graphics.setFont(fonts.pause1)
        for i, button in ipairs(buttons) do
            button.last = button.now
            local button_x = (window_width * 0.5) - (button_width * 0.5)
            local button_y = (window_height * 0.5) - (total_height * 0.5) + cursor_y

            local color = {128/255, 0/255, 0/255, 196/255}
            local mouse_x, mouse_y = love.mouse.getPosition()

            local hot = mouse_x > button_x and
                        mouse_x < button_x + button_width and
                        mouse_y > button_y and
                        mouse_y < button_y + button_height
             
            if hot then
                color = {0.8,0.8,0.9,1}
            end

            button.now = love.mouse.isDown(1)
            if button.now and not button.last and hot then
                button.fn()
            end

            love.graphics.setColor(unpack(color))
            love.graphics.rectangle(
                "fill",
                button_x,
                button_y,
                button_width,
                button_height
            )

            local text_width = fonts.pause1:getWidth(button.text)
            local text_height = fonts.pause1:getHeight(button.text)
            local color = {184/255, 134/255, 11/255, 255/255}
            love.graphics.setColor(unpack(color))
            love.graphics.print(
                button.text,
                fonts.pause1,
                (window_width * 0.5) - (text_width * 0.5),
                (button_y - button_margin) + (text_height * 0.5)
            )
            cursor_y = cursor_y + (button_height + button_margin)

            local color = {255/255, 255/255, 255/255, 255/255}
            love.graphics.setColor(unpack(color))
        end
    end
end

