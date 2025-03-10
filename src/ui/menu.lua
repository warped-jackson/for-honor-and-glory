menu = {}

function newButton(text, fn)
    return {
        text = text,
        fn = fn
    }
end

local buttons = {}

table.insert(buttons, newButton(
    "Start Game",
    function()
        print("Starting game")
    end)
)

table.insert(buttons, newButton(
    "Settings",
    function()
        print("Settings Menu")
    end)
)

function menu:draw()
    local window_width = love.graphics.getWidth()
    local window_height = love.graphics.getHeight()
    local button_width = window_width * (1/3)
    local button_height = window_height * (1/9)
    local button_margin = 16
    local cursor_y = 0
    local total_height = (button_height + button_margin) * #buttons

    if gamestate == 0 then
        love.graphics.setFont(fonts.pause1)

        for i, button in ipairs(buttons) do
            local button_x = (window_width * 0.5) - (button_width * 0.5)
            local button_y = (window_height * 0.5) - (total_height * 0.5) + cursor_y

            local color = {0.4,0.4,0.5,1}
            local mouse_x, mouse_y = love.mouse.getPosition()

            local hot = mouse_x > button_x and
                        mouse_x < button_x + button_width and
                        mouse_y > button_y and
                        mouse_y < button_y + button_height
             
            if hot then
                color = {8,8,9,1}
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
            love.graphics.setColor(0.7, 0.7, 0.7, 1.0)
            love.graphics.print(
                button.text,
                fonts.pause1,
                (window_width * 0.5) - (text_width * 0.5),
                (button_y - button_margin) + text_height * 0.5
            )
            cursor_y = cursor_y + (button_height + button_margin)
        end
    end
end

