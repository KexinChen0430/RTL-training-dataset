module 
input rd_en, 
output reg empty, 
output reg [127:0] dout 
    );
always@(*) 
begin
  case(address) 
  3'h0:begin 
     rd_en0=rd_en; 
	 rd_en1=1'b0; 
	 rd_en2=1'b0; 
	 rd_en3=1'b0; 
	 rd_en4=1'b0; 
	 rd_en5=1'b0; 
	 rd_en6=1'b0; 
	 rd_en7=1'b0; 
	 empty=empty0; 
	 dout = dout0; 
  end
  3'h1:begin
     rd_en0=1'b0;
	 rd_en1=rd_en;
	 rd_en2=1'b0;
	 rd_en3=1'b0;
	 rd_en4=1'b0;
	 rd_en5=1'b0;
	 rd_en6=1'b0;
	 rd_en7=1'b0;
	 empty=empty1;
	 dout = dout1;
  end
  3'h2:begin
     rd_en0=1'b0;
	 rd_en1=1'b0;
	 rd_en2=rd_en;
	 rd_en3=1'b0;
	 rd_en4=1'b0;
	 rd_en5=1'b0;
	 rd_en6=1'b0;
	 rd_en7=1'b0;
	 empty=empty2;
	 dout = dout2;
  end
  3'h3:begin
     rd_en0=1'b0;
	 rd_en1=1'b0;
	 rd_en2=1'b0;
	 rd_en3=rd_en;
	 rd_en4=1'b0;
	 rd_en5=1'b0;
	 rd_en6=1'b0;
	 rd_en7=1'b0;
	 empty=empty3;
	 dout = dout3;
  end
  3'h4:begin
     rd_en0=1'b0;
	 rd_en1=1'b0;
	 rd_en2=1'b0;
	 rd_en3=1'b0;
	 rd_en4=rd_en;
	 rd_en5=1'b0;
	 rd_en6=1'b0;
	 rd_en7=1'b0;
	 empty=empty4;
	 dout = dout4;
  end
  3'h5:begin
     rd_en0=1'b0;
	 rd_en1=1'b0;
	 rd_en2=1'b0;
	 rd_en3=1'b0;
	 rd_en4=1'b0;
	 rd_en5=rd_en;
	 rd_en6=1'b0;
	 rd_en7=1'b0;
	 empty=empty5;
	 dout = dout5;
  end
  3'h6:begin
     rd_en0=1'b0;
	 rd_en1=1'b0;
	 rd_en2=1'b0;
	 rd_en3=1'b0;
	 rd_en4=1'b0;
	 rd_en5=1'b0;
	 rd_en6=rd_en;
	 rd_en7=1'b0;
	 empty=empty6;
	 dout = dout6;
  end
  3'h7:begin
     rd_en0=1'b0;
	 rd_en1=1'b0;
	 rd_en2=1'b0;
	 rd_en3=1'b0;
	 rd_en4=1'b0;
	 rd_en5=1'b0;
	 rd_en6=1'b0;
	 rd_en7=rd_en;
	 empty=empty7;
	 dout = dout7;
  end
  default:begin 
     rd_en0=1'b0; 
	 rd_en1=1'b0;
	 rd_en2=1'b0;
	 rd_en3=1'b0;
	 rd_en4=1'b0;
	 rd_en5=1'b0;
	 rd_en6=1'b0;
	 rd_en7=1'b0;
	 empty =1'b1; 
	 dout =128'b0; 
  end
  endcase
end
endmodule 