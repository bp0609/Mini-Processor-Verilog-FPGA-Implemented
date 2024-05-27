`timescale 1ns / 1ps
module Processor_tb;
reg clk, rstn, pause;
reg [4:0] mode;
wire CB;
wire [7:0] Output;
wire [3:0] PC;
wire slow_clk;
Processor dut(
    .clk(clk),
    .rstn(rstn),
    .pause(pause),
    .mode(mode),
    .CB(CB),
    .Output(Output),
    .slow_clk(slow_clk),
    .PC(PC)
);
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    rstn = 0;
    pause = 0;
    mode = 5'b11111;
    #13 rstn = 1;
    #500 $finish;
end
endmodule

