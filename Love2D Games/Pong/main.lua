function love.load()
    love.window.setTitle("Hello World")
    love.graphics.setNewFont(24)
    
end

function love.draw()
    love.graphics.setBackgroundColor(0.2,0.5,0.7)
    love.graphics.printf("Hello Winner", 0 , love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
    
    
end
