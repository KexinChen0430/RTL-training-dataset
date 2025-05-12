module interface are not supported by vmodel 
); 
assign out_96bit = {in_64bit,in_24bit,in_8bit}+{32'b0,in_64bit};
assign out_64bit = ~in_64bit;
assign out_24bit = {in_8bit,in_8bit,in_8bit} - in_24bit;
wire hidden_var;
assign hidden_var=~in_8bit[0];
reg [1:0]hidden_mem[0:9] ;
reg [7:0]hidden_mem_data;
reg [100:0]huge_hidden_mem[0:5] ;
integer i;
always @(*)
    begin
        for (i=0; i<10; i=i+1)
        begin
            out_mem_8bit[i]=in_mem_8bit[i]+1;
            out_mem_78bit[i]=in_mem_78bit[9-i];
            hidden_mem_data=in_mem_8bit[i];
            hidden_mem[i]=hidden_mem_data[1:0];
        end
        for (i=0; i<6; i=i+1)
        begin
            huge_hidden_mem[i]=0;
        end
    end
endmodule 