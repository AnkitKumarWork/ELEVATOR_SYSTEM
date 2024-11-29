module ALERT_SYSTEM(
    input clk,
    input rst,
    input DOOR_STATUS, // 1 = OPEN, 0 = CLOSE
    input WEIGHT_STATUS, // 1 if weight is greater then 4500, 0 if weight is less than 4500;
    output reg DOOR_ALERT, 
    output reg WEIGHT_ALERT
    );

    //parameter Max_Open_Time = 180;          // Reduced for debugging purposes
    parameter WEIGHT_IS_GREATER_THAN_4500 = 1'b01;
    parameter WEIGHT_IS_LESS_THAN_4500 = 1'b00;

    reg [7:0] counter;      
    integer count_time;               

    //////////////////////// DOOR_ALERT_BEHAVIOR ////////////////////////////
    //Door_alert_logic with corresponding two always blocks and this design is valid only for 100MHz frequency only
//If this design is used for other frequency then change the count_time value in if condition accordingly
always @(posedge(clk)) begin
    if(DOOR_STATUS == 1'b1) begin
        count_time <= count_time + 1'b1;        
    end
    else begin
        count_time <= 1'b0;
    end
end
always @(count_time) begin
    if(count_time > 20'b1000_0111_1010_0010_0011) begin
        DOOR_ALERT <= 1'b1;
    end
    else begin
        DOOR_ALERT <= 1'b0;
    end
end
    //////////////////////// WEIGHT_ALERT_BEHAVIOR ///////////////////////////
    always @(WEIGHT_STATUS) begin
            // Check if weight exceeds the limit and set alert
            if (WEIGHT_STATUS == WEIGHT_IS_GREATER_THAN_4500) 
                WEIGHT_ALERT <= 1;
            else 
                WEIGHT_ALERT <= 0;
    end
endmodule  