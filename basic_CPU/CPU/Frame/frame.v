/*
Date: 18/07/2019
Name: Dang Tuan Kiet
Description: a Frame comprises of ALU, Mux, Register, instruction Register
*/

module frame(iEn, 
             iMux, 
             iClk,
             iRst_n,
             iALU, 
             iIR,
             iDIN, 
             oBus,
             oIns
             );
input iEn; //control Reg
input iMux; //control Mux
input iALU; //control ALU
input iIR; //control ins Reg

input iClk;
input iRst_n;
input iDIN;
output oBus;
output oIns;

wire [7:0] iEn; // 8 Registers
wire [9:0] iMux; //{DINout, Gout, 8 Register}
wire [2:0] iALU; // {Ain, Gin, AddSub}
wire iIR;

wire iClk;
wire iRst_n;
wire [15:0] iDIN;
wire [15:0] oBus;
wire [8:0] oIns;

//output Register
wire [15:0] R0;
wire [15:0] R1;
wire [15:0] R2;
wire [15:0] R3;
wire [15:0] R4;
wire [15:0] R5;
wire [15:0] R6;
wire [15:0] R7;

wire [15:0] G;

//8 Registers
registers Regs(.iEnR0(iEn[0]),
              .iEnR1(iEn[1]),
              .iEnR2(iEn[2]),
              .iEnR3(iEn[3]),
              .iEnR4(iEn[4]),
              .iEnR5(iEn[5]),
              .iEnR6(iEn[6]),
              .iEnR7(iEn[7]),
              .iClk(iClk),
              .iRst_n(iRst_n),
              .iData(oBus),
              .oR0(R0),
              .oR1(R1),
              .oR2(R2),
              .oR3(R3),
              .oR4(R4),
              .oR5(R5),
              .oR6(R6),
              .oR7(R7)
              );

Mux M(.iSel(iMux),
      .iReg({R7,R6,R5,R4,R3,R2,R1,R0}),
      .iG(G),
      .iDIN(iDIN),
      .oBus(oBus)
      );
      
ALU A(.iA(iALU[2]),
      .iG(iALU[1]),
      .iAddSub(iALU[0]),
      .iClk(iClk),
      .iRst_n(iRst_n),
      .iRx(oBus),
      .iRy(oBus),
      .oResult(G)
      );
      
insRegister insReg(.iIns(iDIN[8:0]),
                   .iRst_n(iRst_n),
                   .iClk(iClk),
                   .iIR(iIR),
                   .oIns(oIns)
                   );
    
endmodule
