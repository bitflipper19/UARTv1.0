module sipo_tb();
    reg clk, x;
    wire [7:0] op;

    sipo dut(
        .clk(clk),
        .x(x),
        .op(op)
    );

    always #5 clk=~clk;
    initial begin
        clk=1'b1;
        x=1'b1;
    end

    initial begin
        $dumpfile("sipo.vcd"); $dumpvars(0, sipo_tb);
        #25 x=0; 
        // test case 1
        // Data being sent LSB first so the number is N = 01111001 = 0x79
        #10 x=1; #10 x=0; #10 x=0; #10 x=1; 
        #10 x=1; #10 x=1; #10 x=1; #10 x=0;
        
        


        // test case 2, N = 01101011 = 0x6B
        #10 x=1; #10 x=1; #10 x=0; #10 x=1; 
        #10 x=0; #10 x=1; #10 x=1; #10 x=0;
        // data
        
        #10 x=1;

        #20 $finish;
    end
endmodule