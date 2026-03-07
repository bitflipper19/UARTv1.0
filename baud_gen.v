module baud_gen(
    output clk_b,
    input clk_s
);
    reg [8:0] ctr=9'b0;
    reg b=1'b1;
    always @(posedge clk_s) begin
        ctr<=ctr+1;
        if(ctr==9'd4) begin
            b<=~b;
            ctr<=9'b0;
        end
    end

    assign clk_b=b;


endmodule