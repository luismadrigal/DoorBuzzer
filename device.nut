// The <- is Squirrel’s way of creating a global variable and assigning its initial value
// Create a global variable called 'led' and assign the 'pin9' object to it
led <- hardware.pin9;
// Configure 'led' to be a digital output with a starting value of digital 0 (low, 0V)
led.configure(DIGITAL_OUT, 0);
// Create a global variable to store current state of 'led'
state <- 0;
// Global variable 'button' assigned 'pin1'
button <- hardware.pin1;

// Local/Direct Door Buzzer
function localBuzzer(){
    local state = button.read();
    if(state == 0){
        led.write(state + 1);
    } else {
        led.write(state);
        duration(5); // Go to sleep for 10 secs and hold in the ON position.
        server.log("Holding for 10 seconds.")
        led.write(state - 1); // Change to the OFF position.
    }
}

// Remote Door Buzzer
function remoteBuzzer(state){
    server.log("Received request to Open door: " + state);
    led.write(state);
    duration();
    state = 0
    led.write(state);
    server.log("Closing door now! " + state);
}

// Sleeper function force blocking
function duration(time=10){
    if(time != 10){
      imp.sleep(time);
    }else {
      imp.sleep(10);
    }
}

// configure button
button.configure(DIGITAL_IN_PULLUP, localBuzzer);
// agent to device communication
agent.on("set.led", remoteBuzzer);