NetflixRoulette Lua API
=============

A simple API for NetflixRoulette.

### Requirements ###

* [LuaSocket](http://w3.impa.br/~diego/software/luasocket/home.html)

### Example ###

	require("NetflixRoulette")
	
	local res, obj = NetflixRoulette.createRequest("Breaking Bad")
	if res then
		print("Show ID: " .. tostring(obj.show_id) .. ", Show Title: " .. obj.show_title)
	else
		print("Unable to get show info! Error: " .. tostring(obj))
	end
