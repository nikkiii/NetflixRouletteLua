module("NetflixRoulette", package.seeall)

local url = require("socket.url")
local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require ("dkjson")

function createRequest(t)
	queryString = "type=json"
	if type(t) == 'string' then
		queryString = queryString .. "&title=" .. url.escape(t)
	elseif type(t) == 'table' and t.title then
		queryString = queryString .. "&title=" .. url.escape(tostring(t.title))
		
		if t.year then
			queryString = queryString .. "&year=" .. url.escape(tostring(t.year))
		end
	else
		error("Invalid request.")
	end
	
	response = { }
	
	r, c, h = http.request {
		url = "http://netflixroulette.net/api/api.php?" .. queryString,
		headers = {
			["Host"] = "netflixroulette.net"
		},
		sink = ltn12.sink.table(response)
	}
	
	if c ~= 200 then
		return false, "Unknown API Response"
	end
	
	local obj, pos, err = json.decode(table.concat(response))
	
	if err then
		return false, err
	end
	
	return true, obj
end