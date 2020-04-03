local xScreen,yScreen = guiGetScreenSize();

local shader
local screensource

inventory = {
	element = {
		moveBox_active = nil;
		scroll_i = 0;
		scroll_l = 0;
		
		itemsLoot = {
			{"Бинт",2},
			{"Бинт",2},
			{"Бинт",2},
			{"Бинт",2},
			{"Бинт",2},

		};
		
		itemsPlayer = {
			{"Бинт",2},
			{"Бинт",2},
			{"Бинт",2},
			{"Бинт",2},
			{"Бинт",2},
			{"Бинт",2},
			{"Бинт",2},
			{"Бинт",2},
			{"Бинт",2},
			{"Бинт",2},
			{"Бинт",2},
			{"Бинт",2},
			{"Бинт",2},
			{"Бинт",2},
		};
		
	};

	assistBlur = function ()
		shader = dxCreateShader("data/Shader/blur.fx")
		screensource = dxCreateScreenSource(xScreen,yScreen)
		dxSetShaderValue(shader, "ScreenSource", screensource)
		dxSetShaderValue(shader, "UVSize", xScreen, yScreen)
	end;
	
	_lib_boxItems = function(tabName,x,y,table,scroll)
		if assert ( {tabName,x,y,table,scrol} , "" ) then
			local relX, relY = getCursorPosition()
			local cursorX, cursorY = relX * xScreen, relY * yScreen	
			local myScrollHeight = 0
			local HEIGHT = ( getSize(inventory_Config.size_boxH) + 1 ) * inventory_Config.max_items
			local start_y = 0
			for i = 1 , #table do
				if item[table[i][1]] then
					if i > scroll then
						if i > inventory_Config.max_items + scroll then
							break
						end
						local moveItems = isCursorOnElement(x,y + start_y,getSize(inventory_Config.size_boxW),getSize(inventory_Config.size_boxH)) or false
						dxDrawRectangle(x,y + start_y,getSize(inventory_Config.size_boxW),getSize(inventory_Config.size_boxH),tocolor(155,155,155,moveItems and 150 or 100))
						dxDrawRectangle(x,y + start_y,getSize(inventory_Config.size_boxlib),getSize(inventory_Config.size_boxH),tocolor(255,255,255,30))
						local data = "data/items/"
						-- local data = "C\\window\\temp\\images\\@"..assert(":"..item[table[i][1]])
						dxDrawImage(x,y + start_y,getSize(inventory_Config.size_boxlib),getSize(inventory_Config.size_boxH),data..item[table[i][1]].image)
						-- name
						drawText(table[i][1],x + getSize(inventory_Config.size_boxlib) + 6,y + start_y,getSize(inventory_Config.size_boxW),getSize(inventory_Config.size_boxH),tocolor(0,0,0,200),1,inventory_Config.fontNameItems,"left","center")
						drawText(table[i][1],x + getSize(inventory_Config.size_boxlib) + 5,y + start_y,getSize(inventory_Config.size_boxW),getSize(inventory_Config.size_boxH),tocolor(255,255,255,200),1,inventory_Config.fontNameItems,"left","center")
						-- value
						if item[table[i][1]].stak then
							drawText(i,x - 6,y + start_y,getSize(inventory_Config.size_boxW),getSize(inventory_Config.size_boxH),tocolor(0,0,0,200),1,inventory_Config.fontNameItems,"right","center")
							drawText(i,x - 5,y + start_y,getSize(inventory_Config.size_boxW),getSize(inventory_Config.size_boxH),tocolor(255,255,255,200),1,inventory_Config.fontNameItems,"right","center")
						end
						start_y = start_y + getSize(inventory_Config.size_boxlib) + 1
					end
				end
			end
			if #table > inventory_Config.max_items then
				local scrolly = HEIGHT/#table*scroll
				if #table < inventory_Config.max_items then
					scrollh = HEIGHT * inventory_Config.max_items
				else
					scrollh = inventory_Config.max_items / #table*HEIGHT
				end
				dxDrawLine(x + getSize(175),y,x + getSize(175),y + HEIGHT,tocolor(255,255,255,10),5)
				dxDrawLine(x + getSize(175),y + scrolly,x + getSize(175),y + scrollh,tocolor(255,255,255,100),5)
			end
			-- dxDrawRectangle(x,y,getSize(inventory_Config.size_boxW), HEIGHT)  
			-- inventory.element.moveBox_active = nil;
			if isCursorOnElement(x ,y,getSize(inventory_Config.size_boxW), HEIGHT) then
				inventory.element.moveBox_active = scroll
			end
		end

	end;
	
	createBoxItems = function (element,x,y)
		if assert ( {element,x,y} , "error" ) then
		
		end
	end;
	
	render = function ()
		if ( not screensource ) then
			return
		end
		if isChatVisible() then
			showChat(false)
		end

		dxUpdateScreenSource(screensource)
		dxDrawImage(0, 0, xScreen, yScreen, shader)
		
		local HEIGHT = ( getSize(inventory_Config.size_boxH) + 1 ) * inventory_Config.max_items

		-- world loot
		
		local x,y = getSize(50),getSize(130)
		inventory._lib_boxItems("Wordl",x , y , inventory.element.itemsLoot , inventory.element.scroll_l)
		
		-- line
		dxDrawLine(x + getSize(200),y,x + getSize(200),y + HEIGHT,tocolor(255,255,255,50),2)
		
		-- player loot
		local x,y = getSize(270),getSize(130)
		inventory._lib_boxItems("Player item", x , y , inventory.element.itemsPlayer , inventory.element.scroll_i)
		
		-- sloot player
		local boxAnim = 0
		local barWidth = getSize(150)
		local barSlot = barWidth * cfgPlayer.slotDefault / cfgPlayer.maxSlot
		local x = x +  getSize(220)
		dxDrawRectangle(x,( yScreen - y ) / 2 ,getSize(8),barWidth,tocolor(255,255,255,50))
		dxDrawLineBox(x,( yScreen - y ) / 2 ,getSize(8),barWidth,tocolor(255,255,255,50),1)

		for i = 0 , barSlot - 5 , 1 do
			local r, g, b = hslToRgb(0,0, i / barWidth)
			dxDrawRectangle (x + getSize(2),(( yScreen - y ) / 2 + barWidth - boxAnim ) - 4,getSize(5),getSize(1),tocolor(r * 255,g * 255,b * 255,150))
			boxAnim = boxAnim + 1
		end
		
		-- sloot box
		createBoxItems = function (element,x,y)
		
	end;
	
	keyD = function(key, down)
    if ( not down ) then return end
		if inventory.element.moveBox_active then
			local delta
			if key == "mouse_wheel_up" then
				delta = -1
			elseif key == "mouse_wheel_down" then
				delta = 1
			else
				return
			end
			inventory.element.moveBox_active  = math.max(0, inventory.element.moveBox_active  + delta)
		end
	end;
}

function getSize(value)
	-- local value = math.sin ( value / 2 )
	local max = 1280
	if xScreen < max then
		return value * xScreen / max
	end
	return value
end

-- cleardebug

addEventHandler("onClientResourceStart", resourceRoot, function ()
	inventory.assistBlur()
	bindKey("tab","down",function()
		show = not show
		if ( show ) then
			addEventHandler("onClientRender",root,inventory.render)
			addEventHandler("onClientKey", root, inventory.keyD)
		else
			removeEventHandler("onClientRender",root,inventory.render)
			removeEventHandler("onClientKey", root, inventory.keyD)
		end
		-- контроль запрета игрока в инвентаре
		local Control = {
			 "fire",
			 "aim_weapon",
			 "enter_exit",
			 "look_behind",
		}
		for a = 1 , #Control do
			toggleControl ( Control[a], ( not show ) )
		end
		showCursor ( show , false )
	end)
	toggleControl ( "action", false ) 
end)


