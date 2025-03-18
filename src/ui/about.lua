about = {}

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
    "Back",
    function()
        gamestate = 0
        title:draw()
    end)
)

function about:draw()
    local window_width = love.graphics.getWidth()
    local window_height = love.graphics.getHeight()
    local button_width = window_width * (1/3)
    local button_height = window_height * (1/9)
    local button_margin = 16
    local cursor_y = 300
    local total_height = (button_height + button_margin) * #buttons

    if gamestate == 1 then
        love.graphics.setFont(fonts.pause1)
        love.graphics.setColor(255/255, 255/255, 255/255, 255/255)

        love.graphics.printf("Welcome to For Honor and Glory", love.graphics.getWidth()/2 - 4000, 10 * scale, 8000, "center")
        love.graphics.printf("You are The Mage, the wisened warlock tasked", love.graphics.getWidth()/2 - 4000, 35 * scale, 8000, "center")
        love.graphics.printf("to resolve the issues facing the kingdom. It is up", love.graphics.getWidth()/2 - 4000, 55 * scale, 8000, "center")
        love.graphics.printf("to you to decide how to resolve the conflicts that arise", love.graphics.getWidth()/2 - 4000, 75 * scale, 8000, "center")
        love.graphics.printf("How will you choose?", love.graphics.getWidth()/2 - 4000, 95 * scale, 8000, "center")

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