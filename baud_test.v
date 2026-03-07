module tb();
    reg clk_s;
    wire clk_b;

    baud_gen dut(
        .clk_s(clk_s),
        .clk_b(clk_b)
    );

    initial clk_s=1'b0;

    always #5 clk_s=~clk_s;

    initial begin
        $dumpfile("baud.vcd"); $dumpvars(0, tb);
        #200 $finish;
    end
endmodule