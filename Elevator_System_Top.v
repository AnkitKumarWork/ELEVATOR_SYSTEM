
//////////////////////////////////////////////////////////////////////////////////
// Company: NIT DURGAPUR
// Engineer: ANKIT KUMAR( MTECH MVLSI)
// 
// Create Date: 29/11/2024
// Design Name: Four-Floor Elevator System
// Module Name: Elevator_Top_Module
// Project Name: Elevator System Design
// Target Devices: FPGA
// Tool Versions: Cadence EDA Tools
// Description: This module implements the top-level design of a four-floor elevator system. 
//              It includes the alert system and controller modules to manage the elevator operations.
//              The system operates at a frequency of 100MHz. The input weight_alert signal is received 
//              from a mechanical weight machine. The door_status and floor_status signals are received 
//              from floor sensors. The controller module processes these inputs to control the elevator's 
//              movement and ensure safe operation. The alert system provides notifications in case of 
//              any anomalies or emergencies.
// 
// Dependencies: 
// - alert_system.v: Handles alerts and notifications for the elevator system.
// - controller.v: Manages the control logic for the elevator operations.
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// - Ensure all modules are properly instantiated and connected within the top module.
// - Verify the timing and synchronization between the controller and alert system.
// 
//////////////////////////////////////////////////////////////////////////////////
module Elevator_System_Top(
    input wire clk,
    input wire rst,
    input wire [3:0] REQUESTED_FLOOR,
    input wire [3:0] IN_CURRENT_FLOOR,
    input wire DOOR_STATUS,               // Door status: 1 = OPEN, 0 = CLOSED
    input wire WEIGHT_STATUS,             // 1 if weight > 4500, 0 if weight <= 4500
    output wire COMPLETE,
    output wire DIRECTION,
    output wire [3:0] OUT_CURRENT_FLOOR,
    output wire DOOR_ALERT,               // Door alert output
    output wire WEIGHT_ALERT              // Weight alert output
);

    // Instantiate the Elevator_Control_System
    Elevator_Control_System Elevator_Control_System(
        .clk(clk),
        .rst(rst),
        .REQUESTED_FLOOR(REQUESTED_FLOOR),
        .IN_CURRENT_FLOOR(IN_CURRENT_FLOOR),
        .DOOR_ALERT(DOOR_ALERT),
        .WEIGHT_ALERT(WEIGHT_ALERT),
        .COMPLETE(COMPLETE),
        .DIRECTION(DIRECTION),
        .OUT_CURRENT_FLOOR(OUT_CURRENT_FLOOR)
    );

    // Instantiate the new ALERT_SYSTEM
    ALERT_SYSTEM ALERT_SYSTEM(
        .clk(clk),
        .rst(rst),
        .DOOR_STATUS(DOOR_STATUS),
        .WEIGHT_STATUS(WEIGHT_STATUS),
        .DOOR_ALERT(DOOR_ALERT),
        .WEIGHT_ALERT(WEIGHT_ALERT)
    );

endmodule
