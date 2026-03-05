/*
A very trivial serial input parallel output unit having
four states:
    1. IDLE
    2. READY
    3. SHIFTING
    4. STOP

Data will arrive in little-endian manner i.e. LSB first
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
        if(rst) op<=8'h00;
        case(state)
            IDLE: begin
                if(!x) state<=SHIFT;
            end

            SHIFT: begin
                op[ctr]<=x;
                if(ctr==3'b111) state<=STOP;
            end
            STOP: begin
                state<=IDLE;
                ctr<=3'b000;
            end
        endcase
    end

    always @(posedge clk) begin
        if(rst)
            ctr <= 0;
        else if(state == SHIFT)
            ctr <= ctr + 1;
        else
            ctr <= 0;
    end

endmodule