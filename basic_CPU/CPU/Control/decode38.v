module decode38(in,
                 out
                 );
input [2:0] in;
output [7:0] out;

assign
out[0] = ~in[2] & ~in[1] & ~in[0],
out[1] = ~in[2] & ~in[1] &  in[0],
out[2] = ~in[2] &  in[1] & ~in[0],
out[3] = ~in[2] &  in[1] &  in[0],
out[4] =  in[2] & ~in[1] & ~in[0],
out[5] =  in[2] & ~in[1] &  in[0],
out[6] =  in[2] &  in[1] & ~in[0],
out[7] =  in[2] &  in[1] &  in[0];         
endmodule
