/*
A very trivial serial input parallel output unit having
three states:
    1. IDLE
    2. SHIFTING

Data will arrive LSB first
*/

module sipo(
    output reg [7:0] op,
    input rst,
    input clk,
    input x 
);
    reg [1:0] state=2'b00;
    reg [2:0] ctr=3'b000;
    parameter IDLE=2'b00, SHIFT=2'b10, STOP=2'b11;

    always @(posedge clk) begin
        if(rst) begin 
            op<=8'b0;
            ctr<=3'b0;
        end
        case(state)
            IDLE: begin
                if(!x) state<=SHIFT;
            end

            SHIFT: begin
                // op[ctr]<=x; // Decoder+MUX
                op<={x, op[7:1]}; // Flip-Flops
                ctr<=ctr+1;
                if(&ctr) state<=STOP;
            end
            STOP: begin
                state<=IDLE;
                ctr<=3'b000;
            end
        endcase
    end

endmodule