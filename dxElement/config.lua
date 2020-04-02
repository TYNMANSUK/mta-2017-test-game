local screenWidth, screenHeight = guiGetScreenSize()

dxConfig = {
	
	color = {
		["button"] = {
			Rectangl = tocolor(0,0,0,100); Rectangl_move = tocolor(0,0,0,100);
			Line = tocolor(255,255,255,190); Line_move = tocolor(246,194,32,190);
			Text = tocolor(255,255,255,255); Text_move = tocolor(246,194,32,255);
		},
	};
	
  -- Создаем новые шрифт
	getFont = function ( name , size )
		if assert ( name , 'Error function name font getFont(" name font " , size or default) ' ) then
			local type = "dxElement/font/";
			local font = {
				["default"] = "default-bold",
				["Bold"] = "Roboto-Bold.ttf",
				["Regular"] = "Roboto-Regular.ttf",
			}
			if font[name] and fileExists(type..font[name]) then
				local size = ( size * 10 )
				return dxCreateFont(type..font[name], size ~= nil and size or 1 * 10 )
			end
			return font["default"]
		end
	end;
	
	setFont = function ( element , font , size)
		if assert ( { isElement(element) , font} , "error" ) then
			if dxConfig.getFont (font,size ~= false and size or 1) then
				
				return true
			end
			return false
		end
	end;
	
	
	-- load new element
	addElement = function ( class , data )
		local element = createElement( class )
		element:setData('data',data)
		outputDebugString("Add new element class [ ".. tostring ( class ) .. " ] " )
		return element
	end;
	
	
	drawRender = function ( )
		local cursorx,cursory
		if isCursorShowing() then
			local mx,my = getCursorPosition ()
			cursorx,cursory = mx*screenWidth,my*screenHeight
		end
		for a,v in ipairs ( getElementsByType ("dxdrawButton", true) ) do
			local move = false
			local text,x,y,w,h,font = unpack ( v:getData('data') )
			if ( cursorx and cursory and cursorx > x and cursorx < x + w and cursory > y and cursory < y + h  )then
				move = true
			end
			dxDrawRectangle(x,y,w,h,move and dxConfig.color["button"].Rectangl_move or dxConfig.color["button"].Rectangl)
			dxDrawLine(x, y, x, y + h, move and dxConfig.color["button"].Line_move or dxConfig.color["button"].Line, 1)
			dxDrawLine(x + w, y, x + w, y + h, move and dxConfig.color["button"].Line_move or dxConfig.color["button"].Line, 1)
			dxDrawLine(x, y + h, x + w, y + h, move and dxConfig.color["button"].Line_move or dxConfig.color["button"].Line, 1)
			dxDrawLine(x, y, x + w, y, move and dxConfig.color["button"].Line_move or dxConfig.color["button"].Line, 1)
			dxDrawText(text,x,y,x + w,y + h, move and dxConfig.color["button"].Text_move or dxConfig.color["button"].Text,1,font,"center","center")
		end
	end;
}

local call = dxConfig.drawRender
addEventHandler('onClientRender',root,call)