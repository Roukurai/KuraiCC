local x = 1
turtle.select(x)
redstone.setOutput("back",false)
redstone.setOutput("left",false)
redstone.setOutput("right",false)
 
function redAlert()
    redstone.setOutput("left",false)
    redstone.setOutput("right",false)
    redstone.setOutput("back",true)
end
 
function detected()
    redstone.setOutput("right",false)
    redstone.setOutput("left",true)
end
 
function notDetected()
    redstone.setOutput("left",false)
    redstone.setOutput("right",true)
end
 
function check()
if turtle.detect() == true then 
    detected()
    stack()
else
    notDetected()
    inventory()
    stack()
end 
end
 
function stack()
sleep(2)
check()
end
 
function fulfillment(stock)
if stock == "y" then
turtle.place()
else
end
end
 
function inventory()
    turtle.select(x)
    if turtle.getItemCount() == 0 then
        x=x+1
        if x == 17 then 
        redAlert()
        else
        inventory()
        end
    else
    fulfillment("y")
    end
end
check()