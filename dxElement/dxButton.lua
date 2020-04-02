button = {
	drawButton = function (text,x,y,w,h,font)
		if assert ( {text,x,y,w,h} , " error create to drawButton ") then
			local font = dxConfig.getFont(font ~= nil and font or "default")
			return dxConfig.addElement("dxdrawButton",{text,x,y,w,h,font})
		end
	end;

	
}

-- button.drawButton ( "DASDSA134" , 115 , 255 , 155 , 25 )
-- button.drawButton ( "DASDSA134" , 300 , 300 , 100 , 25 , "Bold" )
