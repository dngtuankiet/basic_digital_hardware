/*
Date: 22/07/2019
Name: Dang Tuan Kiet
Description: simple CPU
             Connect the frame and controlFSM
*/

module CPU(iClk,
           iRst_n,
           iDIN,
           iRun,
           oBus,
           oDone
           );
           
input iClk;
input iRst_n;
input iDIN;
input iRun;
output oBus;
output oDone;

wire iClk;
wire iRst_n;
wire [15:0] iDIN;
wire iRun;
wire [15:0] oBus;
wire oDone;

//Register Enable
wire [7:0] RxIn;
//Mux
wire [7:0] RxOut;
wire Gout;
wire DINout;
//ALU
wire Ain;
wire AddSub;
wire Gin;
//Instruction Register Enable
wire IRin;
wire [8:0] IR; 

frame F(.iEn(RxIn),
        .iMux({DINout,Gout,RxOut}),
        .iALU({Ain,Gin,AddSub}),
        .iIR(IRin),
        .iClk(iClk),
        .iRst_n(iRst_n),
        .iDIN(iDIN),
        .oBus(oBus),
        .oIns(IR)
        );
        
controlFSM CONTROL(.iClk(iClk),
                   .iRst_n(iRst_n),
                   .iRun(iRun),
                   .iIR(IR),
                   .oEn(RxIn),
                   .oMux({DINout,Gout,RxOut}),
                   .oALU({Ain,Gin,AddSub}),
                   .oIR(IRin),
                   .oDone(oDone)
                   );
                   
                   
endmodule
