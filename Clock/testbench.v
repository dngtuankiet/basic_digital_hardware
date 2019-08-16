module testbench();

reg  clk;
reg  i_rst_n;
wire [6:0]o_sec0;
wire [6:0]o_sec1;
wire [6:0]o_min0;
wire [6:0]o_min1;
wire [6:0]o_h0;
wire [6:0]o_h1;

Clock C(.clk(clk),
        .i_rst_n(i_rst_n),
        .o_sec0(o_sec0),
        .o_sec1(o_sec1),
        .o_min0(o_min0),
        .o_min1(o_min1),
        .o_h0(o_h0),
        .o_h1(o_h1)
        );
        
always #5 clk = ~clk;

initial begin
  clk = 0;
  i_rst_n = 0;
  
  #21
  i_rst_n = 1;
  #1000
  $finish;
end
        

endmodule
