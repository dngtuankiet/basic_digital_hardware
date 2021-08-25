module tb_controlFSM();
reg CLK;
reg RST;
reg RUN;
reg [8:0] IR;
wire [7:0] EN;
wire [9:0] MUX;
wire [2:0] ALU;
wire OIR;
wire DONE;

controlFSM CONTROL(.iClk(CLK),
                   .iRst_n(RST),
                   .iRun(RUN),
                   .iIR(IR),
                   .oEn(EN),
                   .oMux(MUX),
                   .oALU(ALU),
                   .oIR(OIR),
                   .oDone(DONE)
                   );

always #5 CLK = ~CLK;

initial begin
CLK = 1'b0;
RST = 1'b0;
RUN = 1'b0;
IR  = 9'd0;
#11
RST = 1'b1;
RUN = 1'b1;
IR = 9'b001_000_000; //movi R0 <- DIN, R0 <- 16'd35
#30
IR = 9'b001_011_000; //movi R3 <- DIN, R3 <- 16'd954
#20
IR = 9'b000_111_011; //mov R7 <- R3, R7 <- 16'd954
#20
IR = 9'b000_001_000; // mov R1 <- R0, R1 <- 16'd35
#20
IR = 9'b010_011_001; //ADD R3 <- R3 + R1, R3 <- 954 + 35 = 989
#30
IR = 9'b011_111_000; // SUB R7 <- R7 - R0, R7 <- 954 - 35 = 919
#40
RUN = 1'b0;
#30
$finish; 
end

endmodule

