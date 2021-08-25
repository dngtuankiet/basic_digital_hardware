`timescale 1ns/1ps
module tb_frame();
reg [7:0] EN; // 8 Registers
reg [9:0] MUX; //{DINout, Gout, 8 Register}
reg [2:0] ALU; // {Ain, Gin, AddSub}
reg IR;

reg CLK;
reg RST;
reg [15:0] DIN;
wire [15:0] BUS;
wire [8:0] INS;

frame F(.iEn(EN),
        .iMux(MUX),
        .iALU(ALU),
        .iIR(IR),
        .iClk(CLK),
        .iRst_n(RST),
        .iDIN(DIN),
        .oBus(BUS),
        .oIns(INS)
        );
        
always #5 CLK= ~CLK;
        
initial begin
CLK = 1'b0;
RST = 1'b0;
EN = 8'd0;
MUX = 10'd0;
ALU = 3'd0;
IR = 1'b0;
DIN = 16'd0;
#20
RST = 1'b1;
#1 //movi R0 <- DIN, R0 <- 16'd35
EN = 8'b0000_0001;
MUX = 10'b10_0000_0000;
ALU = 3'd0;
IR = 1'b0;
DIN = 16'd35;
#10 // TAKE ANOTHER INS
EN = 8'd0;
MUX = 10'd0;
ALU = 3'd0;
IR = 1'b1;
DIN = 16'd0;
#10 //movi R3 <- DIN, R3 <- 16'd954
EN = 8'b0000_1000;
MUX = 10'b10_0000_0000;
ALU = 3'd0;
IR = 1'b0;
DIN = 16'd954;
#10 //TAKE ANOTHER INS
EN = 8'd0;
MUX = 10'd0;
ALU = 3'd0;
IR = 1'b1;
DIN = 16'd0;
#10 //mov R7 <- R3, R7 <- 16'd954
EN = 8'b1000_0000;
MUX = 10'b00_0000_1000;
ALU = 3'd0;
IR = 1'b0;
DIN = 16'd375;
#10 //TAKE ANOTHER INS
EN = 8'd0;
MUX = 10'd0;
ALU = 3'd0;
IR = 1'b1;
DIN = 16'd0;
#10 // mov R1 <- R0, R1 <- 16'd35
EN = 8'b0000_0010;
MUX = 10'b00_0000_0001;
ALU = 3'd0;
IR = 1'b0;
DIN = 16'd487;
#10 //TAKE ANOTHER INS
EN = 8'd0;
MUX = 10'd0;
ALU = 3'd0;
IR = 1'b1;
DIN = 16'd0;
#10 //ADD R3 <- R3 + R1, R3 <- 954 + 35 = 989
//T1
EN = 8'b0000_0000;
MUX = 10'b00_0000_1000;
ALU = 3'b100; //Load in A
IR = 1'b0;
DIN = 16'd221;
#10
//T2
EN = 8'b0000_0000;
MUX = 10'b00_0000_0010;
ALU = 3'b010; //Load in G and ADD
#10
//T3
EN = 8'b0000_1000;
MUX = 10'b01_0000_0000;
ALU = 3'b000;
#10 //TAKE ANOTHER INS
EN = 8'd0;
MUX = 10'd0;
ALU = 3'd0;
IR = 1'b1;
DIN = 16'd0;
#10 //SUB R7 <- R7 - R0, R7 <- 954 - 35 = 919
//T1
EN = 8'b0000_0000;
MUX = 10'b00_1000_0000;
ALU = 3'b100; //Load in A
IR = 1'b0;
DIN = 16'd221;
#10
//T2
EN = 8'b0000_0000;
MUX = 10'b00_0000_0001;
ALU = 3'b011; //Load in G and SUB
#10
//T3
EN = 8'b1000_0000;
MUX = 10'b01_0000_0000;
ALU = 3'b000;
#10
$finish;
end

endmodule
