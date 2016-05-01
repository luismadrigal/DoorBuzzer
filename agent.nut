// Log the URLs we need
server.log("Turn LED On, Buzz the Open Door and hold for 10 sec. " + http.agenturl() + "?led=1");

function requestHandler(request, response) {
    try {
        if ("led" in request.query) {
            if (request.query.led == "1" || request.query.led == "0") {
                local ledState = request.query.led.tointeger();
                device.send("set.led", ledState);
            }
        }
        response.header("Content-Type","Application/JSON")
        response.send(200, "{\"Response\" : \"OK\", \"Status\":}");
    } catch (ex) {
        response.send(500, "Internal Server Error: " + ex);
    }
}

// Register the HTTP handler to begin watching for HTTP requests from your browser
http.onrequest(requestHandler);