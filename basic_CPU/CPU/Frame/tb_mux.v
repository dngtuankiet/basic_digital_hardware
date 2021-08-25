module tb_mux();
reg [9:0] SEL;
wire [127:0] REG;
reg [15:0] G;
reg [15:0] DIN;
wire [15:0]BUS;

Mux M(.iSel(SEL),
      .iReg(REG),
      .iG(G),
      .iDIN(DIN),
      .oBus(BUS)
      );

reg [15:0] R7;
reg [15:0] R6;
reg [15:0] R5;
reg [15:0] R4;
reg [15:0] R3;
reg [15:0] R2;
reg [15:0] R1;
reg [15:0] R0;

assign REG = {R7,R6,R5,R4,R3,R2,R1,R0};
      
initial begin
R7 = 16'd7;
R6 = 16'd6;
R5 = 16'd5;
R4 = 16'd4;
R3 = 16'd3;
R2 = 16'd2;
R1 = 16'd1;
R0 = 16'd0;
G = 16'd15;
DIN = 16'd22;
SEL = 10'b00_0000_0000;
#20
SEL = 10'b00_0000_0001;
#20
SEL = 10'b00_0000_0010;
#20
SEL = 10'b00_0000_0100;
#20
SEL = 10'b00_0000_1000;
#20
SEL = 10'b00_0001_0000;
#20
SEL = 10'b00_0010_0000;
#20
SEL = 10'b00_0100_0000;
#20
SEL = 10'b00_1000_0000;
#20
SEL = 10'b01_0000_0000;
#20
SEL = 10'b10_0000_0000;
#20
$finish;
end
endmodule
