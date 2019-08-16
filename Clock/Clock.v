module Clock(clk,
				     i_rst_n,
				     o_sec0,
				     o_sec1,
				     o_min0,
			     	 o_min1,
			     	 o_h0,
				     o_h1,
			     	 );
				 
input  clk;
input  i_rst_n;
output [6:0]o_sec0;
output [6:0]o_sec1;
output [6:0]o_min0;
output [6:0]o_min1;
output [6:0]o_h0;
output [6:0]o_h1;

reg [5:0] sec_count;
reg [5:0] min_count;
reg [4:0] h_count;
wire sec59;
wire min59;
wire h23;
wire sec_select;
wire min_select;
wire h_select;

//Second

always @(posedge clk) begin
	if(sec_select) begin
		sec_count <= sec_count + 6'd1;
	end
	else begin
		sec_count <= 6'd0;
	end
end

//sec59 = sec_count == 59
assign sec59 = sec_count[0] & sec_count[1] & sec_count[3] & sec_count[4] & sec_count[5];
assign sec_select = i_rst_n & ~sec59;

//Minute

always @(posedge clk) begin
	if(min_select) begin
		if(sec59) begin
			min_count <= min_count + 6'd1;
		end
		else begin
			min_count <= min_count;
		end
	end
	else begin
		min_count <= 6'd0;
	end
end

//min59 = min_count == 59
assign min59 = min_count[0] & min_count[1] & min_count[3] & min_count[4] & min_count[5]; 
assign min_select = i_rst_n & ~min59;

//Hour

always @(posedge clk) begin
	if(h_select) begin
		if(min59) begin
			h_count <= h_count + 5'd1;
		end
		else begin
			h_count <= h_count;
		end
	end
	else begin
		h_count <= 5'd0;
	end
end

//h23 = h_count == 23
assign h23 = ((h_count[0] & h_count[1]) & (h_count[2] & h_count[4]));
assign h_select = i_rst_n & ~h23;

endmodule