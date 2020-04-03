if triggerServerEvent then
	function drawText(text,x,y,w,h,color,size,font,a,c)
		if assert ({text,x,y,w,h,color,size,font,a,c},"Lol") then
			dxDrawText(
				text or "",
				x or 0,
				y or 0,
				(x+w) or 0,
				(y+h) or 0,
				color or tocolor(0,0,0,0),
				size or 0,
				font or nil,
				a or nil,
				c or nil
			)
		end
	end
	function hslToRgb(h, s, l)
		local lightnessValue
		
		if l < 0.5 then
			lightnessValue = l * (s + 1)
		else
			lightnessValue = (l + s) - (l * s)
		end
		
		local lightnessValue2 = l * 2 - lightnessValue
		local r = hueToRgb(lightnessValue2, lightnessValue, h + 1 / 3)
		local g = hueToRgb(lightnessValue2, lightnessValue, h)
		local b = hueToRgb(lightnessValue2, lightnessValue, h - 1 / 3)
		
		return r, g, b
	end
	
	function hueToRgb(l, l2, h)
		if h < 0 then
			h = h + 1
		elseif h > 1 then
			h = h - 1
		end
		if h * 6 < 1 then
			return l + (l2 - l) * h * 6
		elseif h * 2 < 1 then
			return l2
		elseif h * 3 < 2 then
			return l + (l2 - l) * (2 / 3 - h) * 6
		else
			return l
		end
	end
	
	function dxDrawLineBox (x,y,w,h,color,size,data)
		size = size or 1
		data = data or false
		dxDrawLine(x, y, x, y + h, color, size , data)
		dxDrawLine(x + w, y, x + w, y + h, color, size , data)
		dxDrawLine(x, y + h, x + w, y + h, color, size , data)
		dxDrawLine(x, y, x + w, y, color, size , data)
	end
	
	function isCursorOnElement(x,y,w,h)
		if isCursorShowing() then
			local mx,my = getCursorPosition ()
			local fullx,fully = guiGetScreenSize()
			cursorx,cursory = mx*fullx,my*fully
			if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then return true else return false end
		end
	end
end