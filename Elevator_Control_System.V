module Elevator_Control_System(
    input wire clk,
    input wire rst,
    input wire [3:0] REQUESTED_FLOOR,
    input wire [3:0] IN_CURRENT_FLOOR,
    input wire DOOR_ALERT,
    input wire WEIGHT_ALERT,
    output reg COMPLETE,
    output reg DIRECTION,
    output reg [3:0] OUT_CURRENT_FLOOR
);

    parameter GROUND = 2'b00, FIRST = 2'b01, SECOND = 2'b10, THIRD = 2'b11;
    parameter UP = 1'b1, DOWN = 1'b0;

    reg [1:0] ps, ns;
    reg [3:0] current_floor;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            ps <= GROUND;
            current_floor <= IN_CURRENT_FLOOR;
            OUT_CURRENT_FLOOR <= IN_CURRENT_FLOOR;
            COMPLETE <= 0;
            DIRECTION <= DOWN;
        end else begin
            ps <= ns;
            current_floor <= IN_CURRENT_FLOOR;
        end
    end

    always @(*) begin
        ns = ps;
        if (!DOOR_ALERT && !WEIGHT_ALERT) begin
            case (ps)
                GROUND: if (REQUESTED_FLOOR > GROUND) 
                            ns = FIRST;
                        

                FIRST: if (REQUESTED_FLOOR > FIRST) ns = SECOND;
                       else if (REQUESTED_FLOOR < FIRST) ns = GROUND;
                SECOND: if (REQUESTED_FLOOR > SECOND) ns = THIRD;
                        else if (REQUESTED_FLOOR < SECOND) ns = FIRST;
                THIRD: if (REQUESTED_FLOOR < THIRD) ns = SECOND;
                default: ns = GROUND;
            endcase
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            OUT_CURRENT_FLOOR <= IN_CURRENT_FLOOR;
            DIRECTION <= DOWN;
            COMPLETE <= 0;
        end else if (!DOOR_ALERT && !WEIGHT_ALERT) begin
            if (OUT_CURRENT_FLOOR < REQUESTED_FLOOR) begin
                DIRECTION <= UP;
                OUT_CURRENT_FLOOR <= OUT_CURRENT_FLOOR + 1;
                COMPLETE <= 0;
            end else if (OUT_CURRENT_FLOOR > REQUESTED_FLOOR) begin
                DIRECTION <= DOWN;
                OUT_CURRENT_FLOOR <= OUT_CURRENT_FLOOR - 1;
                COMPLETE <= 0;
            end else begin
                COMPLETE <= 1;
                DIRECTION <= 1'bz;
            end
        end
    end

endmodule
