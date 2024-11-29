`timescale 1ns / 1ps

module Elevator_System_Top_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [3:0] REQUESTED_FLOOR;
    reg [3:0] IN_CURRENT_FLOOR;
    reg DOOR_STATUS;
    reg [15:0] WEIGHT_STATUS;

    // Outputs
    wire COMPLETE;
    wire DIRECTION;
    wire [3:0] OUT_CURRENT_FLOOR;
    wire DOOR_ALERT;
    wire WEIGHT_ALERT;

    // Instantiate the Elevator_System_Top
    Elevator_System_Top uut (
        .clk(clk),
        .rst(rst),
        .REQUESTED_FLOOR(REQUESTED_FLOOR),
        .IN_CURRENT_FLOOR(IN_CURRENT_FLOOR),
        .DOOR_STATUS(DOOR_STATUS),
        .WEIGHT_STATUS(WEIGHT_STATUS),
        .COMPLETE(COMPLETE),
        .DIRECTION(DIRECTION),
        .OUT_CURRENT_FLOOR(OUT_CURRENT_FLOOR),
        .DOOR_ALERT(DOOR_ALERT),
        .WEIGHT_ALERT(WEIGHT_ALERT)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns clock period

    // Test procedure
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 1;
        REQUESTED_FLOOR = 4'b0000; // GROUND floor
        IN_CURRENT_FLOOR = 4'b0000; // Start at GROUND floor
        DOOR_STATUS = 0;            // Door closed
        WEIGHT_STATUS = 16'd0;      // No weight

        // Reset the system
        #10 rst = 0;

        // Test Case 1: Move from GROUND to SECOND floor
        #10 REQUESTED_FLOOR = 4'b0010; // Request SECOND floor
        #100;                          // Wait to observe elevator movement

        // Test Case 2: Trigger door alert
        DOOR_STATUS = 1;               // Door open
        #200;                          // Wait to observe DOOR_ALERT
        DOOR_STATUS = 0;               // Door closed
        #50;                           // Wait for DOOR_ALERT to clear

        // Test Case 3: Trigger weight alert
        WEIGHT_STATUS = 16'd5000;      // Exceed weight limit
        #100;                          // Wait to observe WEIGHT_ALERT
        WEIGHT_STATUS = 16'd0;         // Reset weight
        #50;                           // Wait for WEIGHT_ALERT to clear

        // Test Case 4: Move from SECOND to THIRD floor
        REQUESTED_FLOOR = 4'b0011; // Request THIRD floor
        #100;                      // Wait to observe elevator movement

        // Test Case 5: Move from THIRD to FIRST floor
        REQUESTED_FLOOR = 4'b0001; // Request FIRST floor
        #150;                      // Wait to observe elevator movement

        // Test Case 6: Move from FIRST to GROUND floor
        REQUESTED_FLOOR = 4'b0000; // Request GROUND floor
        #150;                      // Wait to observe elevator movement

        // Test Case 7: Complex scenario - Door opens and weight alert at the same time
        DOOR_STATUS = 1;           // Door open
        WEIGHT_STATUS = 16'd5000;  // Exceed weight limit
        #100;                      // Observe both alerts active
        DOOR_STATUS = 0;           // Door closed
        WEIGHT_STATUS = 16'd0;     // Reset weight
        #100;                      // Wait for alerts to clear

        // Finish simulation
        $stop;
    end

    // Monitor signal changes
    initial begin
        $monitor("Time: %0t | IN_CURRENT_FLOOR: %b | REQUESTED_FLOOR: %b | OUT_CURRENT_FLOOR: %b | DIRECTION: %b | COMPLETE: %b | DOOR_ALERT: %b | WEIGHT_ALERT: %b",
                 $time, IN_CURRENT_FLOOR, REQUESTED_FLOOR, OUT_CURRENT_FLOOR, DIRECTION, COMPLETE, DOOR_ALERT, WEIGHT_ALERT);
    end

endmodule
