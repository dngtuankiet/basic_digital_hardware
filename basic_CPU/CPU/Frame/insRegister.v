/*
Date: 07/11/2019
Name: Dang Tuan Kiet
Description: instruction register
*/

module insRegister(iIns,
                   iRst_n,
                   iClk,
                   iIR,
                   oIns
                   );
                   
input iIns;
input iRst_n;
input iClk;
input iIR;
output oIns;

wire [8:0] iIns;
wire iRst_n;
wire iClk;
wire iIR;
reg [8:0] oIns;

always @(posedge iClk) begin
  if(~iRst_n) begin
    oIns <= 9'd0;
  end
  else begin
    if(iIR) begin
      oIns <= iIns;
    end
    else begin
      oIns <= oIns;
    end
  end
end

endmodule
