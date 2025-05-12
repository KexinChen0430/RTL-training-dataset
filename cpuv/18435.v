module sub (
   out1, out2,
   in
   );
   input      [23:0] in;
   output reg 	     out1;
   output reg [4:0]  out2;
   always @* begin
      case (in[3:0]) inside
	default:          {out1,out2} = {1'b0,5'h0F};   
	4'h1, 4'h2, 4'h3: {out1,out2} = {1'b1,5'h01};
	4'h4:             {out1,out2} = {1'b1,5'h04};
	[4'h6:4'h5]:        {out1,out2} = {1'b1,5'h05};  
	4'b100?:   {out1,out2} = {1'b1,5'h08};
	[4'hc:4'hf]:        {out1,out2} = {1'b1,5'h0C};
      endcase
   end
endmodule