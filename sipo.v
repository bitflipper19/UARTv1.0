/*
A very trivial serial input parallel output unit having
three states:
    1. IDLE
    2. SHIFTING

Data will arrive LSB first
*/

module sipo(
    output [7:0] op,
    input clk,
    input x 
);
    reg [7:0] op_r=8'b0;
    reg state=1'b0;
    reg [2:0] ctr=3'b000;
    parameter IDLE=1'b0, DATA=1'b1;

    always @(posedge clk) begin
        case(state)
            IDLE: begin
                if(!x) state<=DATA;
            end

            DATA: begin
                op_r<={x, op_r[7:1]};
                ctr<=ctr+1;
                if(ctr==3'b111) state<=IDLE;
            end
        endcase
    end

    assign op=op_r;

endmodule