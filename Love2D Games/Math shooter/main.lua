windowWidth, windowHeight = love.graphics.getDimensions()

function love.load()
    initializeGrid()
    initializePlayer()
    initializeBullets()
end

function love.update(dt)
    playerMovement(dt)
    -- bulletShooting(dt)
    updateBullets(dt)
end

function love.draw()
    drawGrid()
    love.graphics.setColor(0.8,0.2,0.2)
    love.graphics.circle("fill", player.x, player.y, 20)
    drawBullets()
end

function initializeGrid() 
    gridLines = {}
    cellSize = 30
    for x = cellSize, windowWidth, cellSize do
        local line = {x, 0, x, windowHeight}
        table.insert(gridLines, line)
    end
    
    for y = cellSize, windowHeight, cellSize do
        local line = {0, y, windowWidth, y}
        table.insert(gridLines, line)
    end
end

function drawGrid()
    love.graphics.setBackgroundColor(1,1,1)
    love.graphics.setColor(0.2,0.5,0.7)
    love.graphics.setLineWidth(0.5)
    for i, line in ipairs(gridLines) do
        love.graphics.line(line)
    end
end

function playerMovement(dt)
    if love.keyboard.isDown("right") then
        player.x = player.x + (player.speed * dt)
    elseif love.keyboard.isDown("left") then
        player.x = player.x - (player.speed * dt)
    end
    if love.keyboard.isDown("up") then
        player.y = player.y - (player.speed * dt)
    elseif love.keyboard.isDown("down") then
        player.y = player.y + (player.speed * dt)
    end

end

function love.keypressed( key, scancode, isrepeat )
    local dx, dy = 0, 0
    local bulletShot = false
    if scancode == "d" then -- move right
       dx = 1
       bulletShot = true
    elseif scancode == "a" then -- move left
       dx = -1
       bulletShot = true
    end
    if scancode == "s" then -- move down
       dy = 1
       bulletShot = true
    elseif scancode == "w" then -- move up
       dy = -1
       bulletShot = true
    end
    if bulletShot then
        createBullet(dx,dy)
    end
 end

-- function bulletShooting(dt)
--     local x = 0
--     local y = 0
--     local bulletShot = false
--     if love.keyboard.is("d") then
--         x = 1
--         bulletShot = true
--     elseif love.keyboard.isDown("a") then
--         x = -1
--         bulletShot = true
--     end
--     if love.keyboard.isDown("w") then
--         y = -1
--         bulletShot = true
--     elseif love.keyboard.isDown("s") then
--         y = 1
--         bulletShot = true
--     end
    
--     updateBullets(dt)
-- end

function initializePlayer()
    player = {}
    player.x = windowWidth/2
    player.y = windowHeight/2
    player.speed = 200
end

function initializeBullets()
    bullets = {}
    bulletSpeed = 400
end

function createBullet(x, y)
    local startX = player.x
    local startY = player.y

    -- local angle = math.atan2(y - startY, x - startX)
    -- local bulletDirX = bulletSpeed * math.cos(angle)
    -- local bulletDirY = bulletSpeed * math.sin(angle)
    -- table.insert(bullets, {x = startX, y = startY, dirX = bulletDirX, dirY = bulletDirY})

    
    print('bulletDirX: ', bulletDirX)
    print('x: ', x)
    print('player.x: ', player.x)
    print('My dir X: ', (player.x + x)*bulletSpeed)
    print('My dir Y: ', (player.y + y)*bulletSpeed)


    table.insert(bullets, {x = startX, y = startY, dirX = x * bulletSpeed, dirY = y * bulletSpeed})
-- end
end

function updateBullets(dt)
    for i=1, #bullets do
        bullets[i].x = bullets[i].x + (bullets[i].dirX * dt)
        bullets[i].y = bullets[i].y + (bullets[i].dirY * dt)
    end
end

function drawBullets()
    for i=1, #bullets do
        love.graphics.setColor(0.8, 0.5, 0.2)
        love.graphics.circle("fill", bullets[i].x, bullets[i].y, 5)
    end
end