`timescale 1ns / 1ps

module ClockDivide(
input clk,
output slow_clk
    );
    
reg [31:0] counter = 0;

always@(posedge clk)
begin
    counter <= counter + 1;
end
assign slow_clk = counter[27];
endmodule
