//Testbench

module testbench;
reg clk, reset, ena;
wire pm;
wire [7:0] hh, mm, ss;

top_module test ( clk, reset, ena, pm, hh, mm, ss );

initial begin
clk = 1'b0;
reset = 1'b1;
#3 reset = 1'b0;
#500000 $finish;
end

always #1 clk = ~ clk;


initial begin
#3 ena = 1'b1;
end
endmodule 