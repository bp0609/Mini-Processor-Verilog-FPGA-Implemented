`timescale 1ns / 1ps

module Processor(
    clk, rstn, pause,mode,
    CB,
    Output
    ,slow_clk
    ,PC
);
output wire slow_clk;
input [4:0] mode;
input clk, rstn, pause;
reg [7:0] PROGRAM [15:0];
reg [7:0] RegFile [15:0];
reg [7:0] ACC;
reg [7:0] EXT;
output reg [7:0] Output;
output reg CB;
reg [8:0] SUMDIFF;
reg [15:0] MULTDIV;
wire [7:0] Div;
reg [7:0] IR;
output reg [3:0] PC;
wire [7:0] Rem;
integer i;
//ClockDivide inst1(.clk(clk), .slow_clk(slow_clk));
assign slow_clk = clk;
division inst2(
    .A(ACC),
    .B({4'b0, RegFile[IR[3:0]]}),
    .Res(Div),
    .Rem(Rem)
  );


always @(posedge slow_clk) begin
    if(!rstn)begin

        RegFile[0] = 8'd0;
        RegFile[1] = 8'd1;
        RegFile[2] = 8'd2;
        RegFile[3] = 8'd3;
        RegFile[4] = 8'd4;
        RegFile[5] = 8'd5;
        RegFile[6] = 8'd6;
        RegFile[7] = 8'd7;
        RegFile[8] = 8'd8;
        RegFile[9] = 8'd9;
        RegFile[10] = 8'd10;
        RegFile[11] = 8'd11;
        RegFile[12] = 8'd12;
        RegFile[13] = 8'd13;
        RegFile[14] = 8'd14;
        RegFile[15] = 8'd15;


//        PROGRAM[0] <= 8'b10010011; 
//        PROGRAM[1] <= 8'b01100011;
////        PROGRAM[2] <= 8'b00010101;
//        PROGRAM[2] <= 8'b00011011;
//        PROGRAM[3] <= 8'b10100111;       
//        PROGRAM[4] <= 8'b00000110;
//        PROGRAM[5] <= 8'b00000111;
//        PROGRAM[6] <= 8'b00101010;
//        PROGRAM[7] <= 8'b00110100;
//        PROGRAM[8] <= 8'b01100101;
//        PROGRAM[9] <= 8'b00110100;
//        PROGRAM[10] <= 8'b01000100;
//        PROGRAM[11] <= 8'b01110101;
//        PROGRAM[12] <= 8'b10000101;
//        PROGRAM[13] <= 8'b00000000;
//        PROGRAM[14] <= 8'b11111111;
            
        PROGRAM[0] = 8'b10010001;  //Mov to acc
        PROGRAM[1] = 8'b01100001;  //XOR
        PROGRAM[2] = 8'b01000011;  //Divide
        PROGRAM[3] = 8'b00010101;  //Add R5
        PROGRAM[4] = 8'b00010110;  //Add R6
//        PROGRAM[5] <= 8'b00000000;
//        PROGRAM[6] <= 8'b00000000;
        PROGRAM[5] = 8'b11111111;

        PC = 4'b0000;
        IR = 8'b0;
        ACC = 8'b00011000;
        EXT = 8'b0;
        CB = 1'b0;
        SUMDIFF = 9'b0;
        MULTDIV = 16'b0;
        Output = ACC;
    end

    else begin
        if(mode == 5'b00001)begin
            Output = RegFile[0];
        end
        else if(mode == 5'b11111)begin
            Output = ACC;
        end
        else if(mode == 5'b00010)begin
            Output = RegFile[1];
        end
        else if(mode == 5'b00011)begin
            Output = RegFile[2];
        end
        else if(mode == 5'b00100)begin
            Output = RegFile[3];
        end
        else if(mode == 5'b00101)begin
            Output = RegFile[4];
        end
        else if(mode == 5'b00110)begin
            Output = RegFile[5];
        end
        else if(mode == 5'b00111)begin
            Output = RegFile[6];
        end
        else if(mode == 5'b01000)begin
            Output = RegFile[7];
        end
        else if(mode == 5'b01001)begin
            Output = RegFile[8];
        end
        else if(mode == 5'b01010)begin
            Output = RegFile[9];
        end
        else if(mode == 5'b01011)begin
            Output = RegFile[10];
        end
        else if(mode == 5'b01100)begin
            Output = RegFile[11];
        end
        else if(mode == 5'b01101)begin
            Output = RegFile[12];
        end
        else if(mode == 5'b01110)begin
            Output = RegFile[13];
        end
        else if(mode == 5'b01111)begin
            Output = RegFile[14];
        end
        else if(mode == 5'b10000)begin
            Output = RegFile[15];
        end
        else if(mode == 5'b10001)begin
            Output = IR;
        end
        else if(mode == 5'b10010)begin
            Output = {3'b0,PC};
        end
        else if(mode == 5'b10011)begin
            Output = EXT;
        end
        if (!pause) begin
            
            IR = PROGRAM[PC];
            PC = PC + 1;
        end

        else begin
            IR = IR;
            PC = PC;
        end





        case(IR[7:4] )
            4'b0000:begin
                if (IR[3:0] == 4'b0000)begin
                    //NOP
                end
                else if (IR[3:0] == 4'b0001) begin
                    // LSL ACC
                    ACC = ACC << 1;
                end
                else if (IR[3:0] == 4'b0010) begin
                    // LSR ACC
                    ACC = ACC >> 1;
                end
                else if (IR[3:0] == 4'b0011) begin
                    // CIR ACC
                    ACC = {ACC[0], ACC[7:1]};
                end
                else if (IR[3:0] == 4'b0100) begin
                    // CIL ACC
                    ACC = {ACC[6:0], ACC[7]};
                end
                else if (IR[3:0] == 4'b0101) begin
                    // ASR ACC
                    ACC = {ACC[7], ACC[7:1]};
                end
                else if (IR[3:0] == 4'b0110) begin
                    // INC ACC
                    SUMDIFF = ACC + 1;
                    CB = SUMDIFF[8];
                    ACC = SUMDIFF[7:0];
                end
                else if (IR[3:0] == 4'b0111) begin
                    // DEC ACC
                    SUMDIFF = ACC - 1;
                    CB = SUMDIFF[8];
                    ACC = SUMDIFF[7:0];
                end
            end
    
            4'b0001:begin
                //ADD Ri
                SUMDIFF = ACC + RegFile[IR[3:0]];
                CB = SUMDIFF[8];
                ACC = SUMDIFF[7:0];
            end
            4'b0010:begin
                //SUB Ri
                SUMDIFF = ACC - RegFile[IR[3:0]];
                CB = SUMDIFF[8];
                ACC = SUMDIFF[7:0];
            end
            4'b0011:begin
                //MUL Ri
                MULTDIV = ACC * RegFile[IR[3:0]];
                ACC = MULTDIV[7:0];
                EXT = MULTDIV[15:8];
            end
            4'b0100:begin
                //DIV Ri
                // Need a synthesizable way to implement division
                ACC = Div;
                EXT = Rem;
            end
            4'b0101:begin
                //AND Ri
                ACC = ACC & RegFile[IR[3:0]];
            end
            4'b0110:begin
                //XOR Ri
                ACC = ACC ^ RegFile[IR[3:0]];
            end
            4'b0111:begin
                //CMP Ri
                SUMDIFF = ACC - RegFile[IR[3:0]];
                CB = SUMDIFF[8];
            end
            4'b1000:begin
                //BR <4-bit address>
                if(CB == 1)begin
                    PC <= IR[3:0];
                end
            end
            4'b1001:begin
                //MOV Ri
                ACC = RegFile[IR[3:0]];
            end
            4'b1010:begin
                //MOV ACC Ri
                RegFile[IR[3:0]] = ACC;
            end
            4'b1011:begin
                //RET <4-bit address>
                PC = IR[3:0];
            end
            4'b1111:begin
                //HLT
                
                $finish;
            end
        endcase
     end
end
endmodule