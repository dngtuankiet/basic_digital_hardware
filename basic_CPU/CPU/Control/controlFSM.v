/*
Date: 19/07/2019
Name: Dang Tuan Kiet
Description: Control FSM 
             Send control signals to the frame:
             control signal includes: oEn(8 registers enable)
                                      oMux(Din, G, 8 registers)
                                      oALU(A, G, AddSub)
                                      oIR(instruction register
*/
module controlFSM(iClk,
                  iRst_n,
                  iRun,
                  iIR,
                  oEn,
                  oMux,
                  oALU,
                  oIR,
                  oDone
                  );
input iClk;
input iRst_n;
input iRun;
input iIR;
output oEn;
output oMux;
output oALU;
output oIR;
output oDone;

wire iClk;
wire iRst_n;
wire iRun;
wire [8:0] iIR;
reg [7:0] oEn; // 8 registers
reg [9:0] oMux; // {DINout, Gout, 8 regs}
reg [2:0] oALU; // {Ain, Gin, AddSub}
reg oIR;
reg oDone;

//variables
wire [2:0] code;
reg [2:0] state;
wire [2:0] nextState;
//state wire
wire IDLE, BREAK, MV, MVI, AS1, AS2, AS3;
wire [7:0] Rx;
wire [7:0] Ry;

assign code = iIR[8:6];

decode38 DecRx(.in(iIR[5:3]),
               .out(Rx)
               );

decode38 DecRy(.in(iIR[2:0]),
               .out(Ry)
               );               


//------------------STATE-------------------//
assign
IDLE  = ~(state[2] |   state[1]) & ~state[0],
BREAK = ~(state[2] |   state[1]) &  state[0],
MV    = (~state[2] &   state[1]) & ~state[0],
MVI   = (~state[2] &   state[1]) &  state[0],
AS1   =   state[2] & ~(state[1]  |  state[0]),
AS2   =  (state[2] &  ~state[1]) &  state[0],
AS3   =  (state[2] &   state[1]) & ~state[0];


assign
nextState[0] = (((IDLE & iRun) | (BREAK & ~iRun)) | 
               (((BREAK & iRun) & (~code[1] & code[0])) | (MV & iRun))) |
               ((MVI | (AS1 & iRun)) | 
               ((AS2 & ~iRun) | (AS3 & iRun))),
nextState[1] = ((BREAK & iRun & ~code[1]) | (MV & ~iRun)) |
               ((AS2 & iRun) | (AS3 & ~iRun)) | (MVI & ~iRun),
nextState[2] = ((BREAK & iRun & code[1]) | AS1) | 
               (AS2 | (AS3 & ~iRun));

// state flip flop
always @(posedge iClk) begin
  if(~iRst_n) state <= 3'b000;
  else state <= nextState;  
end

//-------------------OUTPUT----------------------//

wire [7:0] nextEn = (({8{MV}} & Rx) | ({8{MVI}} & Rx)) | ({8{AS3}} & Rx);
always@(posedge iClk) begin
  if(~iRst_n) oEn <= 8'b0000_0000;
  else oEn <= nextEn;
end

wire [9:0] nextMux;
assign nextMux[7:0] = (({8{MV}} & Ry) | ({8{AS1}} & Rx)) | ({8{AS2}} & Ry);
assign nextMux[8] = AS3;
assign nextMux[9] = MVI;
always @(posedge iClk) begin
  if(~iRst_n) oMux <= 10'b00_0000_0000;
  else oMux <= nextMux;
end

wire [2:0] nextALU;
assign nextALU[0] = AS2 & code[0];
assign nextALU[1] = AS2;
assign nextALU[2] = AS1;
always @(posedge iClk) begin
  if(~iRst_n) oALU <= 3'b000;
  else oALU <= nextALU;
end

wire nextIR;
assign nextIR = BREAK;
always @(posedge iClk) begin
  if(~iRst_n) oIR <= 1'b0;
  else oIR <= nextIR;
end

wire nextDone;
assign nextDone = (MV | MVI) | AS3;
always @(posedge iClk) begin
  if(~iRst_n) oDone <= 1'b0;
  else oDone <= nextDone;
end


        
endmodule
                  
